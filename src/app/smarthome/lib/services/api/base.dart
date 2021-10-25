import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:Smarthome/constants/api.dart';
import 'package:Smarthome/constants/constants.dart';
import 'package:Smarthome/core/certificates.dart';
import 'package:Smarthome/models/rest_resource.dart';
import 'package:Smarthome/redux/actions.dart';
import 'package:Smarthome/redux/store.dart';

class HTTP {
  static HttpClient httpClient = HttpClient()
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
    ..connectionTimeout = const Duration(seconds: 3);

  static dynamic fetch(RestResource resource) async {
    try {
      HttpClientRequest req;

      // parse uri
      Uri uri = Uri.parse(resource.toString());

      // open request based on http method
      switch (resource.method) {
        case HTTPMethod.GET:
          req = await httpClient.getUrl(uri);
          break;
        case HTTPMethod.POST:
          req = await httpClient.postUrl(uri);
          break;
        case HTTPMethod.PUT:
          req = await httpClient.putUrl(uri);
          break;
        case HTTPMethod.PATCH:
          req = await httpClient.patchUrl(uri);
          break;
        case HTTPMethod.DELETE:
          req = await httpClient.deleteUrl(uri);
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
      if (resource.requestData != null) {
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
      } else if (res.statusCode >= 500) {
        return HTTPError.SERVER_ERROR;
      } else if (res.statusCode >= 400) {
        return HTTPError.CLIENT_ERROR;
      } else if (res.statusCode != resource.expectedStatus) {
        return HTTPError.DEPRECATED;
      }

      // read response data if wanted
      if (resource.responseData) {
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
      }

      return "";
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
