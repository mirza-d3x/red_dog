// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/models/enquiry_count_model.dart';
import 'package:reddog_mobile_app/models/enquiry_lead_details_model.dart';
import 'package:reddog_mobile_app/models/filter_model.dart';
import 'package:reddog_mobile_app/models/get_comments_model.dart';
import 'package:reddog_mobile_app/models/lead_details_with_filter_tile_model.dart';
import 'package:reddog_mobile_app/models/post_comment_model.dart';
import 'package:reddog_mobile_app/models/unread_enquiry_model.dart';
import 'package:reddog_mobile_app/models/update_comment_model.dart';
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

  //get comments list
  var getCommentModel = GetCommentsModel();
  LiveData<UIState<GetCommentsModel>> getCommentsData = LiveData<UIState<GetCommentsModel>>();

  LiveData<UIState<GetCommentsModel>> getCommentsLiveData() {
    return this.getCommentsData;
  }

  //get unread enquiry list
  var unreadEnquiryModel = UnReadEnquiryModel();
  LiveData<UIState<UnReadEnquiryModel>> unreadEnquiryData = LiveData<UIState<UnReadEnquiryModel>>();

  LiveData<UIState<UnReadEnquiryModel>> getUnreadEnquiryLiveData() {
    return this.unreadEnquiryData;
  }

  //update comment
  var updateCommentModel = UpdateCommentModel();
  LiveData<UIState<UpdateCommentModel>> editCommentData = LiveData<UIState<UpdateCommentModel>>();

  LiveData<UIState<UpdateCommentModel>> editCommentLiveData() {
    return this.editCommentData;
  }

  //Filter
  var filterModel = FilterModel();
  LiveData<UIState<FilterModel>> enquiryFilterData = LiveData<UIState<FilterModel>>();

  LiveData<UIState<FilterModel>> enquiryFilterLiveData() {
    return this.enquiryFilterData;
  }

  void initialState() {
    enquiryCountData.setValue(Initial());
    enquiryLeadDetailsData.setValue(Initial());
    leadDetailsWithTileFilterData.setValue(Initial());
    updateReadStatusData.setValue(Initial());
    postCommentsData.setValue(Initial());
    getCommentsData.setValue(Initial());
    unreadEnquiryData.setValue(Initial());
    editCommentData.setValue(Initial());
    enquiryFilterData.setValue(Initial());
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
      var storedWebViewId = await getValue('storedWebSiteViewId');
      enquiryCountModel = await enquiryRepository.getEnquiry(
          storedWebViewId.isEmpty ?
          initialWebId: storedWebViewId,
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
      var storedWebViewId = await getValue('storedWebSiteViewId');
      enquiryLeadDetailsModel = await enquiryRepository.getEnquiryLeadDetails(
          storedWebViewId.isEmpty ?
          initialWebId: storedWebViewId,
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
      var storedWebViewId = await getValue('storedWebSiteViewId');
      leadDetailsWithTileFilterModel = await enquiryRepository.getEnquiryLeadDetailsWithTileFilterData(
          storedWebViewId.isEmpty ?
          initialWebId: storedWebViewId,
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

  getCommentsList(
      dynamic leadId,
      ) async {
    try {
      getCommentsData.setValue(IsLoading());
      getCommentModel = await enquiryRepository.getCommentData(leadId);
      if (getCommentModel.code == 200) {
        getCommentsData.setValue(Success(getCommentModel));
      } else {
        getCommentsData.setValue(Failure(getCommentModel.toString()));
      }
    } catch (ex) {
      getCommentsData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

  getUnreadEnquiryList(
      dynamic fromDate,
      dynamic toDate,
      ) async {
    try {
      unreadEnquiryData.setValue(IsLoading());
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      var storedWebViewId = await getValue('storedWebSiteViewId');
      unreadEnquiryModel = await enquiryRepository.getUnreadEnquiryData(
          storedWebViewId.isEmpty ?
          initialWebId: storedWebViewId,
          fromDate,toDate
      );
      if (unreadEnquiryModel.code == 200) {
        unreadEnquiryData.setValue(Success(unreadEnquiryModel));
      } else {
        unreadEnquiryData.setValue(Failure(unreadEnquiryModel.toString()));
      }
    } catch (ex) {
      unreadEnquiryData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

  editComment(
      dynamic enquiryId,
      dynamic comment
      ) async {
    try {
      editCommentData.setValue(IsLoading());
      updateCommentModel = await enquiryRepository.updateCommentData(
          enquiryId,comment
      );
      if (updateCommentModel.code == 200) {
        editCommentData.setValue(Success(updateCommentModel));
      } else {
        editCommentData.setValue(Failure(updateCommentModel.toString()));
      }
    } catch (ex) {
      editCommentData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

  getFilterList(
      dynamic timeFrame,
      dynamic sortBy,
      dynamic readStatus,
      ) async {
    try {
      enquiryFilterData.setValue(IsLoading());
      filterModel = await enquiryRepository.filterData(
          timeFrame,sortBy,readStatus
      );
      if (filterModel.code == 200) {
        enquiryFilterData.setValue(Success(filterModel));
      } else {
        enquiryFilterData.setValue(Failure(filterModel.toString()));
      }
    } catch (ex) {
      enquiryFilterData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }
}

