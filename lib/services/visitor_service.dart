import 'dart:convert';

import 'package:reddog_mobile_app/models/registred_website_model.dart';
import 'package:reddog_mobile_app/models/user_by_country_model.dart';
import 'package:reddog_mobile_app/models/user_by_lang_model.dart';
import 'package:reddog_mobile_app/models/visitors_tiles_model.dart';

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