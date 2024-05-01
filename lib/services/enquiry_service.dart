import 'dart:convert';
import 'package:reddog_mobile_app/models/enquiry_count_model.dart';
import 'package:reddog_mobile_app/models/enquiry_lead_details_model.dart';
import 'package:reddog_mobile_app/models/filter_model.dart';
import 'package:reddog_mobile_app/models/get_comments_model.dart';
import 'package:reddog_mobile_app/models/post_comment_model.dart';
import 'package:reddog_mobile_app/models/unread_enquiry_model.dart';
import 'package:reddog_mobile_app/models/update_comment_model.dart';
import 'package:reddog_mobile_app/models/update_read_status_model.dart';
import 'package:http/http.dart' as http;
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
        Map<String, dynamic> updateReadStatusMap = jsonDecode(response.body);
        UpdateReadStatusModel updateReadStatusResult = UpdateReadStatusModel.fromJson(updateReadStatusMap);
        return updateReadStatusResult;
      });
}

Resource<PostCommentModel> postCommentApi(
    dynamic enquiryId,
    dynamic comment,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/leads/addComment/$enquiryId',
      body: json.encode({
        "comment": comment,
      }),
      parse: (response) {
        Map<String, dynamic> postCommentMap = json.decode(response.body);
        var postCommentResult = PostCommentModel.fromJson(postCommentMap);
        return postCommentResult;
      });
}

Resource<GetCommentsModel> getCommentsApi(
    dynamic leadId,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/leads/viewComment/$leadId',
      parse: (response) {
        Map<String, dynamic> getCommentsListMap = jsonDecode(response.body);
        GetCommentsModel getCommentsListResult = GetCommentsModel.fromJson(getCommentsListMap);
        return getCommentsListResult;
      });
}

Future<Object> deleteCommentApi(dynamic enquiryId,dynamic commentId) async {
  String token = await getToken();
  final http.Response response = await http.put(
    Uri.parse(
        'https://app.reddog.live/api/leads/removeComment/$enquiryId/$commentId'
    ),
  );
  if (response.statusCode == 200) {
    return GetCommentsModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to delete Comment.');
  }
  return response;
}

Resource<UnReadEnquiryModel> getUnreadEnquiriesApi(
    dynamic viewId,
    dynamic fromDate,
    dynamic toDate,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/leads/getUnreadData/$viewId/$fromDate/$toDate',
      parse: (response) {
        Map<String, dynamic> getUnreadEnquiriesMap = jsonDecode(response.body);
        UnReadEnquiryModel unreadEnquiryResult = UnReadEnquiryModel.fromJson(getUnreadEnquiriesMap);
        return unreadEnquiryResult;
      });
}

Resource<UpdateCommentModel> updateCommentApi(
    dynamic commentId,
    dynamic comment,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/leads/editComment/$commentId',
      body: json.encode({
        "comment": comment,
      }),
      parse: (response) {
        Map<String, dynamic> updateCommentMap = json.decode(response.body);
        var updateCommentResult = UpdateCommentModel.fromJson(updateCommentMap);
        return updateCommentResult;
      });
}

Resource<FilterModel> enquiryFilterApi(
    dynamic timeFrame,
    dynamic sortBy,
    dynamic readStatus,
    ) {
  return Resource(
      url:
      'https://app.reddog.live/api/leads/filter',
      body: json.encode({
        "timeFrame": timeFrame,
        "sortBy": sortBy,
        "status": readStatus
      }),
      parse: (response) {
        Map<String, dynamic> getFilterDataMap = json.decode(response.body);
        var filterResult = FilterModel.fromJson(getFilterDataMap);
        return filterResult;
      });
}
