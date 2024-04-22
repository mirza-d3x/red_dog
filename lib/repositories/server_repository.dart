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

}
