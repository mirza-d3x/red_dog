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

}