// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import '../core/live_data.dart';
import '../core/ui_state.dart';
import '../models/login_model.dart';
import '../repositories/auth_repository.dart';
import '../utilities/shared_prefernces.dart';

class LoginProvider extends ChangeNotifier {
  AuthRepository authRepository;

  LoginProvider({required this.authRepository});

  var loginModel = LoginModel();
  LiveData<UIState<LoginModel>> loginData = LiveData<UIState<LoginModel>>();

  LiveData<UIState<LoginModel>> loginLiveData() {
    return this.loginData;
  }
  void initialState() {
    loginData.setValue(Initial());
    notifyListeners();
  }

  checkLogin(
      dynamic email,
      dynamic firebaseToken,
      dynamic googleToken,
      dynamic analytics,
      ) async {
    try {
      loginData.setValue(IsLoading());
      loginModel = await authRepository.postLogin(email,firebaseToken,googleToken, analytics);
      if (loginModel.status == 'success') {
        setValue('token', loginModel.userData!.jToken);
        setValue('profilePic', loginModel.userData!.picture);
        setValue('googleToken', loginModel.token);
        loginData.setValue(Success(loginModel));
      } else {
        loginData.setValue(Failure(loginModel.toString()));
      }
    } catch (ex) {
      loginData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

}
