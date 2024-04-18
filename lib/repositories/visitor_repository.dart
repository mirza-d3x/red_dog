
import 'package:reddog_mobile_app/services/user_service.dart';
import 'package:reddog_mobile_app/services/visitor_service.dart';

import '../services/web_service.dart';

class VisitorRepository {
  var webService;

  VisitorRepository() {
    this.webService = Webservice();
  }

  Future getVisitorTile(
      dynamic googleId,
      dynamic googleToken,
      dynamic viewId,
      dynamic fromDate,
      dynamic toDate,
      ) => webService?.get(getVisitorsTileDataApi(googleId, googleToken,viewId,fromDate,toDate));

  Future getUserByLangData(
      dynamic googleId,
      dynamic googleToken,
      dynamic viewId,
      dynamic fromDate,
      dynamic toDate,
      ) => webService?.get(getUserByLangApi(googleId,googleToken,viewId,fromDate,toDate));

  Future getUserByCountryData(
      dynamic googleId,
      dynamic googleToken,
      dynamic viewId,
      dynamic fromDate,
      dynamic toDate,
      ) => webService?.get(getUserByCountryApi(googleId,googleToken,viewId,fromDate,toDate));

  Future getUserByCityData(
      dynamic googleId,
      dynamic googleToken,
      dynamic viewId,
      dynamic fromDate,
      dynamic toDate,
      ) => webService?.get(getUserByCityApi(googleId,googleToken,viewId,fromDate,toDate));

  Future getUserByGenderData(
      dynamic googleId,
      dynamic googleToken,
      dynamic viewId,
      dynamic fromDate,
      dynamic toDate,
      ) => webService?.get(getUserByGenderApi(googleId,googleToken,viewId,fromDate,toDate));

  Future getUserByNewReturnedData(
      dynamic googleId,
      dynamic googleToken,
      dynamic viewId,
      dynamic fromDate,
      dynamic toDate,
      ) => webService?.get(getUserByNewReturnedApi(googleId,googleToken,viewId,fromDate,toDate));

}