import '../services/acquisiton_service.dart';
import '../services/auth_service.dart';
import '../services/web_service.dart';

class AcquisitionRepository {
  var webService;

  AcquisitionRepository() {
    this.webService = Webservice();
  }
  Future getTopChannelData(
      dynamic googleId,
      dynamic googleToken,
      dynamic viewId,
      dynamic fromDate,
      dynamic toDate
      ) =>
      webService?.get(getTopChannelApi(googleId,googleToken,viewId,fromDate,toDate));

  Future getTrafficSourceData(
      dynamic googleId,
      dynamic googleToken,
      dynamic viewId,
      dynamic fromDate,
      dynamic toDate
      ) =>
      webService?.get(getTrafficSourceApi(googleId,googleToken,viewId,fromDate,toDate));

  Future getMostVisitedPageData(
      dynamic googleId,
      dynamic googleToken,
      dynamic viewId,
      dynamic fromDate,
      dynamic toDate
      ) =>
      webService?.get(getMostVisitedPageApi(googleId,googleToken,viewId,fromDate,toDate));

  Future getDeviceCategoryData(
      dynamic googleId,
      dynamic googleToken,
      dynamic viewId,
      dynamic fromDate,
      dynamic toDate
      ) =>
      webService?.get(getDeviceCategoryApi(googleId,googleToken,viewId,fromDate,toDate));

}
