import 'package:Smarthome/constants/api.dart';

class RestResource {
  String relativeURL;
  HTTPMethod method;
  Map<String, dynamic>? requestData;
  bool responseData;
  bool useToken;
  int expectedStatus;

  RestResource(
    this.method,
    this.relativeURL, {
    this.requestData,
    this.responseData = false,
    this.useToken = true,
    this.expectedStatus = 200,
  });

  void setParameter(String parameter, String value) {
    relativeURL = relativeURL.replaceAll("{" + parameter + "}", value);
  }

  @override
  String toString() {
    return BASE_URL + relativeURL;
  }
}
