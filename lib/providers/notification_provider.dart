// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/models/get_Notificatio_model.dart';
import 'package:reddog_mobile_app/repositories/common_repository.dart';
import '../core/live_data.dart';
import '../core/ui_state.dart';
import '../utilities/shared_prefernces.dart';

class NotificationProvider extends ChangeNotifier {
  CommonRepository commonRepository;

  NotificationProvider({required this.commonRepository});

  var getNotificationModel = GetNotificationModel();
  LiveData<UIState<GetNotificationModel>> notificationListData = LiveData<UIState<GetNotificationModel>>();

  LiveData<UIState<GetNotificationModel>> notificationListLiveData() {
    return notificationListData;
  }

  void initialState() {
    notificationListData.setValue(Initial());
    notifyListeners();
  }

  getNotifications() async {
    try {
      notificationListData.setValue(IsLoading());
      var email = await getValue("email");
      getNotificationModel = await commonRepository.getNotificationList(email);
      if (getNotificationModel.code == "200") {
        notificationListData.setValue(Success(getNotificationModel));
      } else {
        notificationListData.setValue(Failure(getNotificationModel.toString()));
      }
    } catch (ex) {
      notificationListData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }
}
