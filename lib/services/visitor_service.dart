import 'dart:convert';

import 'package:reddog_mobile_app/models/registred_website_model.dart';
import 'package:reddog_mobile_app/models/user_by_age_group_model.dart';
import 'package:reddog_mobile_app/models/user_by_city_model.dart';
import 'package:reddog_mobile_app/models/user_by_country_model.dart';
import 'package:reddog_mobile_app/models/user_by_lang_model.dart';
import 'package:reddog_mobile_app/models/user_by_newturned_model.dart';
import 'package:reddog_mobile_app/models/visitor_trending_time_model.dart';
import 'package:reddog_mobile_app/models/visitors_tiles_model.dart';

import '../models/user_by_gender_model.dart';
import '../utilities/api_helpers.dart';

Resource<VisitorsTileDataModel> getVisitorsTileDataApi(
    dynamic googleId,
    dynamic googleToken,
    dynamic viewId,
    dynamic fromDate,
    dynamic toDate,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/ga/singleGa/$googleId/$googleToken/ $viewId/$fromDate/$toDate',
      parse: (response) {
        print(response.body);
        Map<String, dynamic> getVisitorsTileDataMap = jsonDecode(response.body);
        VisitorsTileDataModel visitorsTileResult = VisitorsTileDataModel.fromJson(getVisitorsTileDataMap);
        return visitorsTileResult;
      });
}

Resource<UserByLangModel> getUserByLangApi(
    dynamic googleId,
    dynamic googleToken,
    dynamic viewId,
    dynamic fromDate,
    dynamic toDate,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/ga/userbylang/$googleId/$googleToken/ $viewId/$fromDate/$toDate/1/true',
      parse: (response) {
        Map<String, dynamic> getUserByLangDataMap = jsonDecode(response.body);
        UserByLangModel userByLangResult = UserByLangModel.fromJson(getUserByLangDataMap);
        return userByLangResult;
      });
}

Resource<UserByCountryModel> getUserByCountryApi(
    dynamic googleId,
    dynamic googleToken,
    dynamic viewId,
    dynamic fromDate,
    dynamic toDate,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/ga/userbycountry/$googleId/$googleToken/ $viewId/$fromDate/$toDate/1/true',
      parse: (response) {
        Map<String, dynamic> getUserByCountryDataMap = jsonDecode(response.body);
        UserByCountryModel userByCountryResult = UserByCountryModel.fromJson(getUserByCountryDataMap);
        return userByCountryResult;
      });
}

Resource<UserByCityModel> getUserByCityApi(
    dynamic googleId,
    dynamic googleToken,
    dynamic viewId,
    dynamic fromDate,
    dynamic toDate,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/ga/userbycity/$googleId/$googleToken/ $viewId/$fromDate/$toDate/1/true',
      parse: (response) {
        Map<String, dynamic> getUserByCityDataMap = jsonDecode(response.body);
        UserByCityModel userByCityResult = UserByCityModel.fromJson(getUserByCityDataMap);
        return userByCityResult;
      });
}

Resource<UserByGenderModel> getUserByGenderApi(
    dynamic googleId,
    dynamic googleToken,
    dynamic viewId,
    dynamic fromDate,
    dynamic toDate,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/ga/userbygender/$googleId/$googleToken/ $viewId/$fromDate/$toDate/true',
      parse: (response) {
        Map<String, dynamic> getUserByGenderDataMap = jsonDecode(response.body);
        UserByGenderModel userByGenderResult = UserByGenderModel.fromJson(getUserByGenderDataMap);
        return userByGenderResult;
      });
}

Resource<UserByNewTurnedModel> getUserByNewReturnedApi(
    dynamic googleId,
    dynamic googleToken,
    dynamic viewId,
    dynamic fromDate,
    dynamic toDate,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/ga/newretained/$googleId/$googleToken/ $viewId/$fromDate/$toDate/true',
      parse: (response) {
        Map<String, dynamic> getUserByNewReturnedDataMap = jsonDecode(response.body);
        UserByNewTurnedModel userByNewReturnedResult = UserByNewTurnedModel.fromJson(getUserByNewReturnedDataMap);
        return userByNewReturnedResult;
      });
}

Resource<UserByAgeGroupModel> getUserByAgeApi(
    dynamic googleId,
    dynamic googleToken,
    dynamic viewId,
    dynamic fromDate,
    dynamic toDate,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/ga/userbyage/$googleId/$googleToken/ $viewId/$fromDate/$toDate/true',
      parse: (response) {
        Map<String, dynamic> getUserByAgeDataMap = jsonDecode(response.body);
        UserByAgeGroupModel userByAgeResult = UserByAgeGroupModel.fromJson(getUserByAgeDataMap);
        return userByAgeResult;
      });
}

Resource<VisitorsTrendingTimeModel> getVisitorTrendingTimeApi(
    dynamic googleId,
    dynamic googleToken,
    dynamic viewId,
    dynamic fromDate,
    dynamic toDate,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/ga/visitorbydate/$googleId/$googleToken/$viewId/$fromDate/$toDate/true',
      // 'https://app.reddog.live/api/ga/visitorbydate/$googleId/$googleToken/ 384272511/$fromDate/$toDate/true',
      parse: (response) {
        print(response.body);
        Map<String, dynamic> getUserByVisitorsTrendingTimeDataMap = jsonDecode(response.body);
        VisitorsTrendingTimeModel userByVisitorsTrendingTimeResult = VisitorsTrendingTimeModel.fromJson(getUserByVisitorsTrendingTimeDataMap);
        return userByVisitorsTrendingTimeResult;
      });
}