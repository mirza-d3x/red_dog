import 'package:http/http.dart';
import 'package:reddog_mobile_app/utilities/base_urls.dart';
import 'package:reddog_mobile_app/utilities/constants.dart';
import 'package:reddog_mobile_app/utilities/shared_prefernces.dart';

class Resource<T> {
  String? url;
  // String? token;
  // // dynamic id;
  // dynamic phone;
  // dynamic addressId;
  dynamic body;
  T Function(Response response)? parse;

  Resource({this.url,this.body, this.parse});
}

Future<String> getToken() async {
  return await getValue(Constants.token);
}

Future<String> getGoogleToken() async {
  return await getValue(Constants.googleToken);
}

Map<String, String> getHeaders(String token) {
  return {"x-auth-token": token};
}

Map<String, String> getLoginHeaders() {
  return {"Content-Type": 'application/json',"Cookie": 'XSRF-TOKEN=lKOxlvkl-xVu6HxGoXAmWnkrxNh2zeKwmVrs; _csrf=u6nDX375ziajaxXhsC92GwHi'};
}

Map<String, String> getHeadersWithApplicationJson() {
  return {"Content-Type": 'application/json'};
}

Map<String, String> getJsonHeader(String token) {
  return {"x-auth-token": token,"Content-Type": 'application/json'};
}

Map<String, String> getAuthHeaders(String token) {
  return {"Authorization": 'Basic ' + token};
}

Uri getUrl(String component) {
  var url= Uri.parse(BaseUrls.devApiBaseUrl + component);
  return url;
}

Map<String, String> getJsonContent() {
  return {"Content-Type": 'application/json'};
}

Future<String> getFireBaseToken() async {
  return await getValue(Constants.fireBaseToken);
}

