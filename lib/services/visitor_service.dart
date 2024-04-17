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
    // dynamic googleId,
    // dynamic googleToken,
    // dynamic viewId,
    // dynamic fromDate,
    // dynamic toDate,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/ga/userbycountry/103842196489734838365/ya29.a0Ad52N3_o0egRvOjMKfH4eF65Y9kwWL7dRzDR4DTrS2_whmr-B-7LLwitd5cFm9MPsG7DNmktxNOSnLHZrN7unAQPtGKaUQBD5J0HtIWF9j1t7E4be9DASBCIiobfl4w7LBiBRIQgGjxlZxQpJmZbHM-ITvC5azl8oMdwaCgYKAUoSARESFQHGX2MiH5LUX79ee25HSg-bfSHrlQ0171/ 384272511/2024-03-06/2024-04-04/1/true',
      parse: (response) {
        Map<String, dynamic> getUserByCountryDataMap = jsonDecode(response.body);
        UserByCountryModel userByCountryResult = UserByCountryModel.fromJson(getUserByCountryDataMap);
        return userByCountryResult;
      });
}