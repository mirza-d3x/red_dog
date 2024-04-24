import 'dart:convert';
import 'package:reddog_mobile_app/models/enquiry_count_model.dart';

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