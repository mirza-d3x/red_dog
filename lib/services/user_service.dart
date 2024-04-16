import 'dart:convert';

import 'package:reddog_mobile_app/models/user_profile_model.dart';

import '../utilities/api_helpers.dart';

Resource<UserProfileModel> getUserProfileApi() {
  return Resource(
      url:
      'https://app.reddog.live/api/auth/getUserDetails',
      body: {},
      parse: (response) {
        print('lllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll');
        print(response.body);
        print('////////////////////////////////////////////////////////////////');
        Map<String, dynamic> userDataResultMap = jsonDecode(response.body);
        UserProfileModel userDataResult = UserProfileModel.fromJson(userDataResultMap);
        return userDataResult;
      });
}