import 'dart:convert';
import 'dart:developer';

import 'package:reddog_mobile_app/models/get_Notificatio_model.dart';
import 'package:reddog_mobile_app/models/logout_model.dart';
import 'package:reddog_mobile_app/models/search_list_model.dart';

import '../models/registred_website_model.dart';
import '../utilities/api_helpers.dart';

Resource<RegisteredWebsiteModel> getRegisteredWebsiteApi(dynamic googleId) {
  return Resource(
      url:
          'https://app.reddog.live/api/signup/getRegisteredProperties?gid=$googleId',
      parse: (response) {
        Map<String, dynamic> getRegisteredWebsiteDataMap =
            jsonDecode(response.body);
        RegisteredWebsiteModel registeredWebsiteResult =
            RegisteredWebsiteModel.fromJson(getRegisteredWebsiteDataMap);
        return registeredWebsiteResult;
      });
}

Resource<GetNotificationModel> getNotificationListApi(dynamic email) {
  return Resource(
      url: 'https://app.reddog.live/api/property/getNotification/$email',
      parse: (response) {
        Map<String, dynamic> getNotificationListDataMap =
            jsonDecode(response.body);
        GetNotificationModel notificationListResult =
            GetNotificationModel.fromJson(getNotificationListDataMap);
        return notificationListResult;
      });
}

Resource<LogoutModel> logoutApi(
  dynamic email,
  dynamic firebaseToken,
) {
  return Resource(
      url: 'https://app.reddog.live/api/auth/logout',
      body: json.encode({
        "email": email,
        "firId": firebaseToken,
      }),
      parse: (response) {
        Map<String, dynamic> logoutResultMap = json.decode(response.body);
        var logoutResult = LogoutModel.fromJson(logoutResultMap);
        return logoutResult;
      });
}

Resource<SearchResultModel> searchApi(dynamic keyword) {
  return Resource(
      url: 'https://app.reddog.live/api/leads/search/$keyword',
      parse: (response) {
        Map<String, dynamic> getSearchResultDataMap = jsonDecode(response.body);
        SearchResultModel searchResult =
            SearchResultModel.fromJson(getSearchResultDataMap);
        return searchResult;
      });
}

Resource deleteAccountApi(
  String googleId,
) {
  return Resource(
    url: 'https://app.reddog.live/api/auth/delete',
    body: json.encode({
      "googleId": googleId,
    }),
    parse: (response) {
      Map<String, dynamic> logoutResultMap = json.decode(response.body);
      log("Delete Account response" + response.body);
      // var logoutResult = LogoutModel.fromJson(logoutResultMap);
      // return logoutResult;
    },
  );
}
