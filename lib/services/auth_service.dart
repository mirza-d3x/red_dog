import 'dart:convert';

import 'package:reddog_mobile_app/models/apple_login_model.dart';
import 'package:reddog_mobile_app/models/email_verification_model.dart';
import 'package:reddog_mobile_app/models/signIn_model.dart';

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

Resource<SignInModel> signInApi(
    dynamic email,
    dynamic password,
    dynamic firebaseToken,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/auth/checkMobileUser',
      body: json.encode({
        "email": email,
        "password": password,
        "firId": firebaseToken,
        "token": "",
        "analytics": "false",
        "appleId":""
      }),
      parse: (response) {
        Map<String, dynamic> signInResultMap = json.decode(response.body);
        var signInResult = SignInModel.fromJson(signInResultMap);
        return signInResult;
      });
}

Resource<EmailVerificationModel> forgotPasswordEmailApi(
    dynamic email,
    ) {

  return Resource(
      url: 'https://app.reddog.live/api/auth/generate-token',
      body: json.encode({
        'email': email
      }),
      parse: (response) {
        print(response.body);
        Map<String, dynamic> forgotPasswordEmailResultMap =
        json.decode(response.body);
        var forgotPasswordEmailResult = EmailVerificationModel.fromJson(forgotPasswordEmailResultMap);
        return forgotPasswordEmailResult;
      });
}