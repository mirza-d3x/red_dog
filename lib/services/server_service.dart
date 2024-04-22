import 'dart:convert';

import 'package:reddog_mobile_app/models/latency_model.dart';

import '../utilities/api_helpers.dart';

Resource<LatencyModel> getLatencyDataApi(
    dynamic googleId,
    dynamic googleToken,
    dynamic viewId,
    dynamic fromDate,
    dynamic toDate,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/serverstats/latencytm/$googleId/$googleToken/$viewId/$fromDate/$toDate',
      parse: (response) {
        print(response.body);
        Map<String, dynamic> getLatencyDataMap = jsonDecode(response.body);
        LatencyModel latencyResult = LatencyModel.fromJson(getLatencyDataMap);
        return latencyResult;
      });
}