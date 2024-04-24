import 'dart:convert';

import 'package:reddog_mobile_app/models/get_Notificatio_model.dart';

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

Resource<GetNotificationModel> getNotificationListApi(dynamic email) {
  return Resource(
      url:
      'https://app.reddog.live/api/property/getNotification/$email',
      parse: (response) {
        Map<String, dynamic> getNotificationListDataMap = jsonDecode(response.body);
        GetNotificationModel notificationListResult = GetNotificationModel.fromJson(getNotificationListDataMap);
        return notificationListResult;
      });
}