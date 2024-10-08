import 'dart:convert';

import 'package:reddog_mobile_app/models/acquisition_top_channels_model.dart';
import 'package:reddog_mobile_app/models/device_category_model.dart';
import 'package:reddog_mobile_app/models/most_visited_page_model.dart';
import 'package:reddog_mobile_app/models/traffic_source_by_date_model.dart';
import 'package:reddog_mobile_app/models/traffic_source_model.dart';
import 'package:reddog_mobile_app/models/user_profile_model.dart';

import '../models/search_keyword_model.dart';
import '../models/top_channels_by_date_model.dart';
import '../utilities/api_helpers.dart';

Resource<AcquisitionTopChannelsModel> getTopChannelApi(
    dynamic googleId,
    dynamic googleToken,
    dynamic viewId,
    dynamic fromDate,
    dynamic toDate
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/aquasition/channels/$googleId/$googleToken/$viewId/$fromDate/$toDate/true',
      parse: (response) {
        Map<String, dynamic> topChannelResultMap = jsonDecode(response.body);
        AcquisitionTopChannelsModel topChannelResult = AcquisitionTopChannelsModel.fromJson(topChannelResultMap);
        return topChannelResult;
      });
}

Resource<TrafficSourceModel> getTrafficSourceApi(
    dynamic googleId,
    dynamic googleToken,
    dynamic viewId,
    dynamic fromDate,
    dynamic toDate
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/aquasition/traffic/$googleId/$googleToken/ $viewId/$fromDate/$toDate/true',
      parse: (response) {
        Map<String, dynamic> trafficSourceResultMap = jsonDecode(response.body);
        TrafficSourceModel trafficSourceResult = TrafficSourceModel.fromJson(trafficSourceResultMap);
        return trafficSourceResult;
      });
}

Resource<MostVisitedPageModel> getMostVisitedPageApi(
    dynamic googleId,
    dynamic googleToken,
    dynamic viewId,
    dynamic fromDate,
    dynamic toDate
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/aquasition/viewByPage/$googleId/$googleToken/$viewId/$fromDate/$toDate/true',
      parse: (response) {
        Map<String, dynamic> mostVisitedPageDataMap = jsonDecode(response.body);
        MostVisitedPageModel mostVisitedPageResult = MostVisitedPageModel.fromJson(mostVisitedPageDataMap);
        return mostVisitedPageResult;
      });
}

Resource<DeviceCategoryModel> getDeviceCategoryApi(
    dynamic googleId,
    dynamic googleToken,
    dynamic viewId,
    dynamic fromDate,
    dynamic toDate
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/aquasition/deviceCategory/$googleId/$googleToken/$viewId/$fromDate/$toDate/true',
      parse: (response) {
        Map<String, dynamic> deviceCategoryDataMap = jsonDecode(response.body);
        DeviceCategoryModel deviceCategoryResult = DeviceCategoryModel.fromJson(deviceCategoryDataMap);
        return deviceCategoryResult;
      });
}

Resource<ChannelsByDateModel> getTopChannelsByDateApi(
    dynamic googleId,
    dynamic googleToken,
    dynamic viewId,
    dynamic fromDate,
    dynamic toDate
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/aquasition/channelsbydate/$googleId/$googleToken/$viewId/$fromDate/$toDate/true',
      parse: (response) {
        Map<String, dynamic> topChannelsByDateDataMap = jsonDecode(response.body);
        ChannelsByDateModel topChannelsByDateResult = ChannelsByDateModel.fromJson(topChannelsByDateDataMap);
        return topChannelsByDateResult;
      });
}

Resource<TrafficSourceByDateModel> getTrafficSourceByDateApi(
    dynamic googleId,
    dynamic googleToken,
    dynamic viewId,
    dynamic fromDate,
    dynamic toDate
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/aquasition/trafficByDate/$googleId/$googleToken/$viewId/$fromDate/$toDate/true',
      parse: (response) {
        Map<String, dynamic> trafficSourcesByDateDataMap = jsonDecode(response.body);
        TrafficSourceByDateModel trafficSourcesByDateResult = TrafficSourceByDateModel.fromJson(trafficSourcesByDateDataMap);
        return trafficSourcesByDateResult;
      });
}

Resource<SearchKeywordModel> getSearchKeywordListApi(
    dynamic googleId,
    dynamic googleToken,
    dynamic viewId,
    dynamic fromDate,
    dynamic toDate
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/aquasition/searchPhrases/$googleId/$googleToken/$viewId/$fromDate/$toDate/true',
      parse: (response) {
        Map<String, dynamic> searchKeywordDataMap = jsonDecode(response.body);
        SearchKeywordModel searchKeywordDateResult = SearchKeywordModel.fromJson(searchKeywordDataMap);
        return searchKeywordDateResult;
      });
}