import 'dart:convert';
import 'package:reddog_mobile_app/models/enquiry_count_model.dart';
import 'package:reddog_mobile_app/models/enquiry_lead_details_model.dart';
import 'package:reddog_mobile_app/models/update_read_status_model.dart';

import '../models/lead_details_with_filter_tile_model.dart';
import '../utilities/api_helpers.dart';

Resource<EnquiryCountModel> getEnquiryCountApi(
    dynamic viewId,
    dynamic fromDate,
    dynamic toDate,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/leads/getleadsbycategory/$viewId/$fromDate/$toDate',
      parse: (response) {
        print(response.body);
        Map<String, dynamic> getCountMap = jsonDecode(response.body);
        EnquiryCountModel enquiryCountResult = EnquiryCountModel.fromJson(getCountMap);
        return enquiryCountResult;
      });
}

Resource<EnquiryLeadDetailsModel> getEnquiryLeadDetailApi(
    dynamic viewId,
    dynamic fromDate,
    dynamic toDate,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/leads/getsaveddata/$viewId/$fromDate/$toDate',
      parse: (response) {
        print(response.body);
        Map<String, dynamic> getLeadDetailsMap = jsonDecode(response.body);
        EnquiryLeadDetailsModel leadDetailsResult = EnquiryLeadDetailsModel.fromJson(getLeadDetailsMap);
        return leadDetailsResult;
      });
}

Resource<LeadDetailsWithFilterTileModel> getEnquiryLeadDetailWithTileFilterApi(
    dynamic viewId,
    dynamic fromDate,
    dynamic toDate,
    dynamic categoryName
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/leads/getfilteredData/$viewId/$fromDate/$toDate/$categoryName',
      parse: (response) {
        Map<String, dynamic> getLeadDetailsWithTileFilterMap = jsonDecode(response.body);
        LeadDetailsWithFilterTileModel leadDetailsWithTileFilterResult = LeadDetailsWithFilterTileModel.fromJson(getLeadDetailsWithTileFilterMap);
        return leadDetailsWithTileFilterResult;
      });
}

Resource<UpdateReadStatusModel> updateEnquiryReadStatusApi(
    dynamic enquiryId,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/leads/updateReadStatus/$enquiryId',
      parse: (response) {
        print('QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQqqqq');
        print(response.body);
        Map<String, dynamic> updateReadStatusMap = jsonDecode(response.body);
        UpdateReadStatusModel updateReadStatusResult = UpdateReadStatusModel.fromJson(updateReadStatusMap);
        return updateReadStatusResult;
      });
}