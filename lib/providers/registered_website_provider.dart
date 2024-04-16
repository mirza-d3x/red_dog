// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/models/registred_website_model.dart';
import 'package:reddog_mobile_app/repositories/common_repository.dart';
import '../core/live_data.dart';
import '../core/ui_state.dart';
import '../utilities/shared_prefernces.dart';

class RegisteredWebsiteProvider extends ChangeNotifier {
  CommonRepository commonRepository;

  RegisteredWebsiteProvider({required this.commonRepository});

  var websiteListModel = RegisteredWebsiteModel();
  LiveData<UIState<RegisteredWebsiteModel>> websiteListData = LiveData<UIState<RegisteredWebsiteModel>>();

  LiveData<UIState<RegisteredWebsiteModel>> websiteListLiveData() {
    return websiteListData;
  }

  void initialState() {
    websiteListData.setValue(Initial());
    notifyListeners();
  }

  getRegisteredWebsiteList() async {
    try {
      websiteListData.setValue(IsLoading());
      var googleId = await getValue("googleId");
      websiteListModel = await commonRepository.getRegisteredWebsite(googleId);
      if (websiteListModel.code == "200") {
        setValue('initialWebId', websiteListModel.data![0].datumId);
        websiteListData.setValue(Success(websiteListModel));
      } else {
        websiteListData.setValue(Failure(websiteListModel.toString()));
      }
    } catch (ex) {
      websiteListData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }
}
