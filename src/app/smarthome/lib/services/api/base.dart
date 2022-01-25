import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:Smarthome/constants/api.dart';
import 'package:Smarthome/constants/constants.dart';
import 'package:Smarthome/core/certificate_validation.dart';
import 'package:Smarthome/models/rest_resource.dart';
import 'package:Smarthome/redux/store.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HTTP {
  static HttpClient? httpClient = kIsWeb
      ? null
      : (HttpClient()
        ..badCertificateCallback = ((
          X509Certificate cert,
          String host,
          int port,
        ) =>
            ValidateCaCertificate(
              cert,
              host,
              port,
            ))
        ..connectionTimeout = const Duration(seconds: 5));

  static dynamic fetch(RestResource resource) async {
    if (kIsWeb)
      return await fetchInWeb(resource);
    else if (Platform.isAndroid || Platform.isIOS)
      return await fetchNative(resource);
    else
      return HTTPError.PLATFORM_ERROR;
  }

  static dynamic fetchInWeb(RestResource resource) async {
    try {
      Uri uri = Uri.parse(resource.toString());

      http.Response response;

      Map<String, String>? headers = {};
      var body = null;

      if (resource.useToken) {
        headers["smarthome-session"] = (store.state.sessionID ?? "").toString();
      }

      if (resource.requestString != null) {
        body = resource.requestString!;
        headers["content-type"] = "text/plain";
        headers["content-length"] = body.length.toString();
      } else if (resource.requestData != null) {
        body = json.encoder.convert(resource.requestData);
        headers["content-type"] = "application/json";
        headers["content-length"] = body.length.toString();
      }

      switch (resource.method) {
        case HTTPMethod.GET:
          response = await http.get(uri, headers: headers);
          break;
        case HTTPMethod.POST:
          response = await http.post(uri, headers: headers, body: body);
          break;
        case HTTPMethod.PUT:
          response = await http.put(uri, headers: headers, body: body);
          break;
        case HTTPMethod.PATCH:
          response = await http.patch(uri, headers: headers, body: body);
          break;
        case HTTPMethod.DELETE:
          response = await http.delete(uri, headers: headers, body: body);
          break;
        default:
          return HTTPError.DEPRECATED;
      }

      if (response.statusCode == 401) {
        return HTTPError.NOT_AUTHORIZED;
      } else if (response.statusCode == 502 || response.statusCode == 504) {
        return HTTPError.PROXY_ERROR;
      } else if (response.statusCode >= 500) {
        return HTTPError.SERVER_ERROR;
      } else if (response.statusCode >= 400) {
        return HTTPError.CLIENT_ERROR;
      } else if (response.statusCode != resource.expectedStatus) {
        return HTTPError.DEPRECATED;
      }

      if (!resource.responseData) return "";

      if (response.headers["content-type"] == "application/json") {
        return json.decoder.convert(response.body);
      }
      return response.body;
    } on http.ClientException catch (e) {
      log(e.toString());
      log("${e.message} | ${e.uri}");
      return HTTPError.CONNECTION_ERROR;
    }
  }

  static dynamic fetchNative(RestResource resource) async {
    try {
      HttpClientRequest req;

      // parse uri
      Uri uri = Uri.parse(resource.toString());

      // open request based on http method
      switch (resource.method) {
        case HTTPMethod.GET:
          req = await httpClient!.getUrl(uri);
          break;
        case HTTPMethod.POST:
          req = await httpClient!.postUrl(uri);
          break;
        case HTTPMethod.PUT:
          req = await httpClient!.putUrl(uri);
          break;
        case HTTPMethod.PATCH:
          req = await httpClient!.patchUrl(uri);
          break;
        case HTTPMethod.DELETE:
          req = await httpClient!.deleteUrl(uri);
          break;
        default:
          return HTTPError.DEPRECATED;
      }

      // send token
      if (resource.useToken) {
        req.headers.add(
          "smarthome-session",
          (store.state.sessionID ?? "").toString(),
        );
      }

      // send request body
      if (resource.requestString != null) {
        req.headers.contentType = ContentType.text;
        req.headers.contentLength = resource.requestString!.length;

        req.write(resource.requestString!);
      } else if (resource.requestData != null) {
        String encoded = json.encoder.convert(resource.requestData);
        req.headers.contentType = ContentType.json;
        req.headers.contentLength = encoded.length;

        req.write(encoded);
      }

      // complete request
      HttpClientResponse res = await req.close();

      // handle http statuscodes
      if (res.statusCode == 401) {
        return HTTPError.NOT_AUTHORIZED;
      } else if (res.statusCode == 502 || res.statusCode == 504) {
        return HTTPError.PROXY_ERROR;
      } else if (res.statusCode >= 500) {
        return HTTPError.SERVER_ERROR;
      } else if (res.statusCode >= 400) {
        return HTTPError.CLIENT_ERROR;
      } else if (res.statusCode != resource.expectedStatus) {
        return HTTPError.DEPRECATED;
      }

      // read response data if wanted
      if (!resource.responseData) return "";

      final completer = Completer<String>();
      final contents = StringBuffer();
      res.transform(utf8.decoder).listen((data) {
        contents.write(data);
      }, onDone: () => completer.complete(contents.toString()));

      // parse json
      if (res.headers.contentType!.mimeType == "application/json") {
        return json.decoder.convert(await completer.future);
      }

      return await completer.future;
    } on TimeoutException catch (e) {
      log(e.message ?? "");
      return HTTPError.CONNECTION_ERROR;
    } on SocketException catch (e) {
      log(e.message);
      return HTTPError.CONNECTION_ERROR;
    } on FormatException catch (_) {
      return HTTPError.CLIENT_ERROR;
    } catch (e) {
      if (IS_DEBUGGING) {
        log(e.toString());
      }
      return HTTPError.UNKNOWN;
    }
  }
}
