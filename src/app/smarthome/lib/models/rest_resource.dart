import 'package:Smarthome/constants/api.dart';

class RestResource {
  String relativeURL;
  HTTPMethod method;
  Map<String, dynamic>? requestData;
  bool responseData;
  bool useToken;
  int expectedStatus;
  Map<String, String> parameters = {};

  RestResource(
    this.method,
    this.relativeURL, {
    this.requestData,
    this.responseData = false,
    this.useToken = true,
    this.expectedStatus = 200,
  });

  @override
  String toString() {
    String url = BASE_URL + relativeURL;

    this.parameters.forEach((key, value) {
      url = url.replaceAll("{" + key + "}", value);
    });

    return url;
  }
}
