// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/models/enquiry_count_model.dart';
import 'package:reddog_mobile_app/models/enquiry_lead_details_model.dart';
import 'package:reddog_mobile_app/models/lead_details_with_filter_tile_model.dart';
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

  void initialState() {
    enquiryCountData.setValue(Initial());
    enquiryLeadDetailsData.setValue(Initial());
    leadDetailsWithTileFilterData.setValue(Initial());
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


}
