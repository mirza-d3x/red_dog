import 'dart:convert';

import '../models/registred_website_model.dart';
import '../utilities/api_helpers.dart';

Resource<RegisteredWebsiteModel> getRegisteredWebsiteApi(dynamic googleId) {
  return Resource(
      url:
      'https://app.reddog.live/api/signup/getRegisteredProperties?gid=$googleId',
      parse: (response) {
        Map<String, dynamic> getRegisteredWebsiteDataMap = jsonDecode(response.body);
        RegisteredWebsiteModel registeredWebsiteResult = RegisteredWebsiteModel.fromJson(getRegisteredWebsiteDataMap);
        return registeredWebsiteResult;
      });
}