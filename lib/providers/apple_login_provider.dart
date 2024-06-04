// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import '../core/live_data.dart';
import '../core/ui_state.dart';
import '../models/apple_login_model.dart';
import '../repositories/auth_repository.dart';
import '../utilities/shared_prefernces.dart';

class AppleLoginProvider extends ChangeNotifier {
  AuthRepository authRepository;

  AppleLoginProvider({required this.authRepository});

  var appleLoginModel = AppleLoginModel();
  LiveData<UIState<AppleLoginModel>> appleLoginData = LiveData<UIState<AppleLoginModel>>();

  LiveData<UIState<AppleLoginModel>> appleLoginLiveData() {
    return this.appleLoginData;
  }
  void initialState() {
    appleLoginData.setValue(Initial());
    notifyListeners();
  }

  checkAppleLogin(
      dynamic email,
      dynamic firebaseToken,
      dynamic googleToken,
      dynamic analytics,
      dynamic appleId,
      ) async {
    try {
      appleLoginData.setValue(IsLoading());
      appleLoginModel = await authRepository.postAppleLogin(email,firebaseToken,googleToken, analytics,appleId);
      if (appleLoginModel.status == 'success') {
        setValue('token', appleLoginModel.userData!.jToken);
        setValue('profilePic', appleLoginModel.userData!.picture);
        setValue('googleToken', appleLoginModel.token);
        setValue('googleId', appleLoginModel.userData!.googleId);
        setValue('analytics', appleLoginModel.isAnalytic);
        setValue('email', appleLoginModel.userData!.email);
        appleLoginData.setValue(Success(appleLoginModel));
      } else {
        appleLoginData.setValue(Failure(appleLoginModel.toString()));
      }
    } catch (ex) {
      appleLoginData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

}
