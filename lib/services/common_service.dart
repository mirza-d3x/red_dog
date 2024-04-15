import 'dart:convert';

import '../models/registred_website_model.dart';
import '../utilities/api_helpers.dart';

Resource<RegisteredWebsiteModel> getRegisteredWebsiteApi() {
  return Resource(
      url:
      'https://app.reddog.live/api/signup/getRegisteredProperties?gid=103842196489734838365',
      parse: (response) {
        Map<String, dynamic> getRegisteredWebsiteDataMap = jsonDecode(response.body);
        RegisteredWebsiteModel registeredWebsiteResult = RegisteredWebsiteModel.fromJson(getRegisteredWebsiteDataMap);
        return registeredWebsiteResult;
      });
}