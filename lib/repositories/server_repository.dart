import 'package:reddog_mobile_app/services/server_service.dart';

import '../services/auth_service.dart';
import '../services/web_service.dart';

class ServerRepository {
  var webService;

  ServerRepository() {
    this.webService = Webservice();
  }
  Future getLatency(
      dynamic googleId,
      dynamic googleToken,
      dynamic viewId,
      dynamic fromDate,
      dynamic toDate,
      ) =>
      webService?.get(getLatencyDataApi(googleId,googleToken,viewId,fromDate,toDate));

  Future getUptime(
      dynamic viewId,
      dynamic email,
      dynamic fromDate,
      dynamic toDate,
      ) =>
      webService?.get(getUptimeDataApi(viewId,email,fromDate,toDate));

  Future getSSLHealthData(
      dynamic viewId,
      ) =>
      webService?.get(getSSLHealthApi(viewId));

  Future getSServerTileData(
      dynamic viewId,
      dynamic email,
      dynamic fromDate,
      dynamic toDate,
      ) =>
      webService?.get(getServerTileApi(viewId,email,fromDate,toDate));

}
