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

  Future getEnquiryLeadDetails(
      dynamic viewId,
      dynamic fromDate,
      dynamic toDate,
      ) =>
      webService?.get(getEnquiryLeadDetailApi(viewId,fromDate,toDate));

  Future getEnquiryLeadDetailsWithTileFilterData(
      dynamic viewId,
      dynamic fromDate,
      dynamic toDate,
      dynamic categoryName
      ) =>
      webService?.get(getEnquiryLeadDetailWithTileFilterApi(viewId,fromDate,toDate,categoryName));

  Future updateReadStatus(
      dynamic enquiryId,
      ) =>
      webService?.put(updateEnquiryReadStatusApi(enquiryId));

  Future postCommentData(
      dynamic enquiryId,
      dynamic comment,
      ) =>
      webService?.put(postCommentApi(enquiryId,comment));

  Future getCommentData(
      dynamic leadId,
      ) =>
      webService?.get(getCommentsApi(leadId));

  Future getUnreadEnquiryData(
      dynamic viewId,
      dynamic fromDate,
      dynamic toDate,
      ) =>
      webService?.get(getUnreadEnquiriesApi(viewId,fromDate,toDate));

}
