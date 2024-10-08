import 'dart:convert';

import 'package:reddog_mobile_app/models/latency_model.dart';
import 'package:reddog_mobile_app/models/ssl_health_model.dart';
import 'package:reddog_mobile_app/models/uptime_model.dart';

import '../models/server_tile_model.dart';
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

Resource<UptimeModel> getUptimeDataApi(
    dynamic viewId,
    dynamic email,
    dynamic fromDate,
    dynamic toDate,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/serverstats/uptime/$viewId/$email/$fromDate/$toDate',
      parse: (response) {
        print(response.body);
        Map<String, dynamic> getUptimeDataMap = jsonDecode(response.body);
        UptimeModel uptimeResult = UptimeModel.fromJson(getUptimeDataMap);
        return uptimeResult;
      });
}

Resource<SslHealthModel> getSSLHealthApi(
    dynamic viewId,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/serverstats/sslHelp/$viewId',
      parse: (response) {
        print(response.body);
        Map<String, dynamic> getSslHealthDataMap = jsonDecode(response.body);
        SslHealthModel sslResult = SslHealthModel.fromJson(getSslHealthDataMap);
        return sslResult;
      });
}

Resource<ServerTileModel> getServerTileApi(
    dynamic viewId,
    dynamic email,
    dynamic fromDate,
    dynamic toDate,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/serverstats/siteuptime/$viewId/$email/$fromDate/$toDate',
      parse: (response) {
        print(response.body);
        Map<String, dynamic> getServerTileDataMap = jsonDecode(response.body);
        ServerTileModel serverTileResult = ServerTileModel.fromJson(getServerTileDataMap);
        return serverTileResult;
      });
}