// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/models/enquiry_count_model.dart';
import 'package:reddog_mobile_app/models/enquiry_lead_details_model.dart';
import 'package:reddog_mobile_app/models/lead_details_with_filter_tile_model.dart';
import 'package:reddog_mobile_app/models/post_comment_model.dart';
import 'package:reddog_mobile_app/models/update_read_status_model.dart';
import 'package:reddog_mobile_app/repositories/enquiry_repository.dart';
import '../core/live_data.dart';
import '../core/ui_state.dart';
import '../utilities/shared_prefernces.dart';

class EnquiryProvider extends ChangeNotifier {
  EnquiryRepository enquiryRepository;

  EnquiryProvider({required this.enquiryRepository});

  //Enquiry Count
  var enquiryCountModel = EnquiryCountModel();
  LiveData<UIState<EnquiryCountModel>> enquiryCountData = LiveData<UIState<EnquiryCountModel>>();

  LiveData<UIState<EnquiryCountModel>> enquiryCountLiveData() {
    return this.enquiryCountData;
  }

  //Enquiry lead Details
  var enquiryLeadDetailsModel = EnquiryLeadDetailsModel();
  LiveData<UIState<EnquiryLeadDetailsModel>> enquiryLeadDetailsData = LiveData<UIState<EnquiryLeadDetailsModel>>();

  LiveData<UIState<EnquiryLeadDetailsModel>> enquiryLeadDetailsLiveData() {
    return this.enquiryLeadDetailsData;
  }

  //Enquiry lead Details with filter tile
  var leadDetailsWithTileFilterModel = LeadDetailsWithFilterTileModel();
  LiveData<UIState<LeadDetailsWithFilterTileModel>> leadDetailsWithTileFilterData = LiveData<UIState<LeadDetailsWithFilterTileModel>>();

  LiveData<UIState<LeadDetailsWithFilterTileModel>> leadDetailsWithTileFilterLiveData() {
    return this.leadDetailsWithTileFilterData;
  }

  //update Read status
  var updateReadStatusModel = UpdateReadStatusModel();
  LiveData<UIState<UpdateReadStatusModel>> updateReadStatusData = LiveData<UIState<UpdateReadStatusModel>>();

  LiveData<UIState<UpdateReadStatusModel>> updateReadStatusLiveData() {
    return this.updateReadStatusData;
  }

  //post comment
  var postCommentModel = PostCommentModel();
  LiveData<UIState<PostCommentModel>> postCommentsData = LiveData<UIState<PostCommentModel>>();

  LiveData<UIState<PostCommentModel>> postCommentsLiveData() {
    return this.postCommentsData;
  }

  void initialState() {
    enquiryCountData.setValue(Initial());
    enquiryLeadDetailsData.setValue(Initial());
    leadDetailsWithTileFilterData.setValue(Initial());
    updateReadStatusData.setValue(Initial());
    postCommentsData.setValue(Initial());
    notifyListeners();
  }


  getEnquiryList(
      dynamic fromDate,
      dynamic toDate,
      ) async {
    try {
      enquiryCountData.setValue(IsLoading());
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      enquiryCountModel = await enquiryRepository.getEnquiry(
          storedWebId.isEmpty ?
          initialWebId: storedWebId,
          fromDate,toDate
      );
      if (enquiryCountModel.code == 200) {
        enquiryCountData.setValue(Success(enquiryCountModel));
      } else {
        enquiryCountData.setValue(Failure(enquiryCountModel.toString()));
      }
    } catch (ex) {
      enquiryCountData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

  getEnquiryLeadDetailsList(
      dynamic fromDate,
      dynamic toDate,
      ) async {
    try {
      enquiryLeadDetailsData.setValue(IsLoading());
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      enquiryLeadDetailsModel = await enquiryRepository.getEnquiryLeadDetails(
          storedWebId.isEmpty ?
          initialWebId: storedWebId,
          fromDate,toDate
      );
      if (enquiryLeadDetailsModel.code == 200) {
        enquiryLeadDetailsData.setValue(Success(enquiryLeadDetailsModel));
      } else {
        enquiryLeadDetailsData.setValue(Failure(enquiryLeadDetailsModel.toString()));
      }
    } catch (ex) {
      enquiryLeadDetailsData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }


  getEnquiryLeadDetailsWithTileList(
      dynamic fromDate,
      dynamic toDate,
      dynamic categoryName,
      ) async {
    try {
      leadDetailsWithTileFilterData.setValue(IsLoading());
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      leadDetailsWithTileFilterModel = await enquiryRepository.getEnquiryLeadDetailsWithTileFilterData(
          storedWebId.isEmpty ?
          initialWebId: storedWebId,
          fromDate,toDate,
        categoryName
      );
      if (leadDetailsWithTileFilterModel.code == 200) {
        leadDetailsWithTileFilterData.setValue(Success(leadDetailsWithTileFilterModel));
      } else {
        leadDetailsWithTileFilterData.setValue(Failure(leadDetailsWithTileFilterModel.toString()));
      }
    } catch (ex) {
      leadDetailsWithTileFilterData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

  updateEnquiryStatus(
      dynamic enquiryId,
      ) async {
    try {
      updateReadStatusData.setValue(IsLoading());
      updateReadStatusModel = await enquiryRepository.updateReadStatus(
          enquiryId
      );
      if (updateReadStatusModel.code == 200) {
        updateReadStatusData.setValue(Success(updateReadStatusModel));
      } else {
        updateReadStatusData.setValue(Failure(updateReadStatusModel.toString()));
      }
    } catch (ex) {
      updateReadStatusData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

  postComment(
      dynamic enquiryId,
      dynamic comment
      ) async {
    try {
      postCommentsData.setValue(IsLoading());
      postCommentModel = await enquiryRepository.postCommentData(
          enquiryId,comment
      );
      if (postCommentModel.code == 200) {
        postCommentsData.setValue(Success(postCommentModel));
      } else {
        postCommentsData.setValue(Failure(postCommentModel.toString()));
      }
    } catch (ex) {
      postCommentsData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }
}
