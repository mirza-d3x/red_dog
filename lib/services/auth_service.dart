import 'dart:convert';

import 'package:reddog_mobile_app/models/apple_login_model.dart';

import '../models/login_model.dart';
import '../utilities/api_helpers.dart';

Resource<LoginModel> loginApi(
    dynamic email,
    dynamic firebaseToken,
    dynamic googleToken,
    dynamic analytics,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/auth/checkMobileUser',
      body: json.encode({
        "email": email,
        "firId": firebaseToken,
        "token": googleToken,
        "analytics": analytics,
      }),
      parse: (response) {
        Map<String, dynamic> loginResultMap = json.decode(response.body);
        var loginResult = LoginModel.fromJson(loginResultMap);
        return loginResult;
      });
}

Resource<AppleLoginModel> appleLoginApi(
    dynamic email,
    dynamic firebaseToken,
    dynamic googleToken,
    dynamic analytics,
    dynamic appleId,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/auth/checkMobileUser',
      body: json.encode({
        "email": email,
        "firId": firebaseToken,
        "token": googleToken,
        "analytics": analytics,
        "appleId": appleId,
      }),
      parse: (response) {
        Map<String, dynamic> appleLoginResultMap = json.decode(response.body);
        var appleLoginResult = AppleLoginModel.fromJson(appleLoginResultMap);
        return appleLoginResult;
      });
}