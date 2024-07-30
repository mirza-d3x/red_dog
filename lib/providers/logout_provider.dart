// ignore_for_file: unrelated_type_equality_checks

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/models/logout_model.dart';
import 'package:reddog_mobile_app/repositories/common_repository.dart';
import '../core/live_data.dart';
import '../core/ui_state.dart';
import '../utilities/shared_prefernces.dart';

class LogoutProvider extends ChangeNotifier {
  CommonRepository commonRepository;

  LogoutProvider({required this.commonRepository});

  var logoutModel = LogoutModel();
  LiveData<UIState<LogoutModel>> logoutData = LiveData<UIState<LogoutModel>>();

  LiveData<UIState<LogoutModel>> logoutLiveData() {
    return this.logoutData;
  }

  void initialState() {
    logoutData.setValue(Initial());
    notifyListeners();
  }

  logoutFromDevice() async {
    try {
      logoutData.setValue(IsLoading());
      var email = await getValue('email');
      var fireId = await getValue("fireBaseToken");
      logoutModel = await commonRepository.putLogout(email, fireId);
      if (logoutModel.code == '200') {
        logoutData.setValue(Success(logoutModel));
      } else {
        logoutData.setValue(Failure(logoutModel.toString()));
      }
    } catch (ex) {
      logoutData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

  deleteAccount() async {
    try {
      logoutData.setValue(IsLoading());
      var googleId = await getValue('googleId');
      logoutModel = await commonRepository.deleteAccount(googleId);
      if (logoutModel.code == '200') {
        logoutData.setValue(Success(logoutModel));
      } else {
        logoutData.setValue(Failure(logoutModel.toString()));
      }
    } catch (ex, stackTrace) {
      log("Error while deleting account", error: ex, stackTrace: stackTrace);
      logoutData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }
}
