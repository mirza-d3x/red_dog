import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/repositories/auth_repository.dart';

import '../core/live_data.dart';
import '../core/ui_state.dart';
import '../models/forgot_password_model.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  AuthRepository authRepository;
  ForgotPasswordProvider({required this.authRepository});

  var forgotPasswordModel = ForgotPasswordModel();
  LiveData<UIState<ForgotPasswordModel>> forgotPasswordLiveData =
  LiveData<UIState<ForgotPasswordModel>>();

  LiveData<UIState<ForgotPasswordModel>> updatePasswordLiveData() {
    return this.forgotPasswordLiveData;
  }

  void initialState() {
    forgotPasswordLiveData.setValue(Initial());
    notifyListeners();
  }


  Future<bool> updatePassword(
      dynamic email,
      dynamic otp,
      dynamic password,
      ) async {
    try {
      forgotPasswordLiveData.setValue(IsLoading());
      forgotPasswordModel = await authRepository.forgotPasswordData(
          email,otp,password
      );
      if (forgotPasswordModel.statusCode == 200 ) {
        forgotPasswordLiveData.setValue(Success(forgotPasswordModel));
        return true;
      } else {
        forgotPasswordLiveData.setValue(Failure(forgotPasswordModel.message));
        return false;
      }
    } catch (ex) {
      forgotPasswordLiveData.setValue(Failure(ex.toString()));
      return false;
    } finally {
      notifyListeners();
    }
  }
}

