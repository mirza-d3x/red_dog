import 'package:reddog_mobile_app/services/enquiry_service.dart';
import 'package:reddog_mobile_app/services/server_service.dart';

import '../services/auth_service.dart';
import '../services/web_service.dart';

class EnquiryRepository {
  var webService;

  EnquiryRepository() {
    this.webService = Webservice();
  }

  Future getEnquiry(
      dynamic viewId,
      dynamic fromDate,
      dynamic toDate,
      ) =>
      webService?.get(getEnquiryCountApi(viewId,fromDate,toDate));

}
