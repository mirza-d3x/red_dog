import 'dart:convert';

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
        print('lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll');
        print(response.body);
        var loginResult = LoginModel.fromJson(loginResultMap);
        return loginResult;
      });
}