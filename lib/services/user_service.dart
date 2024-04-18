import 'dart:convert';

import 'package:reddog_mobile_app/models/user_profile_model.dart';

import '../utilities/api_helpers.dart';

Resource<UserProfileModel> getUserProfileApi(dynamic googleId) {
  return Resource(
      url:
      'https://app.reddog.live/api/auth/getUserDetails',
      body: json.encode({
        "googleId": googleId
      }),
      parse: (response) {
        Map<String, dynamic> userDataResultMap = jsonDecode(response.body);
        UserProfileModel userDataResult = UserProfileModel.fromJson(userDataResultMap);
        return userDataResult;
      });
}