import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/core/ui_state.dart';
import 'package:reddog_mobile_app/models/email_verification_model.dart';

import '../core/live_data.dart';
import '../repositories/auth_repository.dart';

class ForgotPasswordEmailProvider extends ChangeNotifier {
  AuthRepository authRepository;

  ForgotPasswordEmailProvider({required this.authRepository});

  var forgotPasswordEmailModel = EmailVerificationModel();
  LiveData<UIState<EmailVerificationModel>> forgotPasswordEmailLiveData =
  LiveData<UIState<EmailVerificationModel>>();

  LiveData<UIState<EmailVerificationModel>> postForgotPasswordEmailLiveData() {
    return this.forgotPasswordEmailLiveData;
  }

  void initialState()
  {
    forgotPasswordEmailLiveData.setValue(Initial());
    notifyListeners();
  }

  checkForgotPasswordEmail(
      dynamic email,
      ) async {
    try {
      forgotPasswordEmailLiveData.setValue(IsLoading());
      forgotPasswordEmailModel = await authRepository.forgotPasswordEmailData(email);

      if (forgotPasswordEmailModel.status == 200) {
        forgotPasswordEmailLiveData.setValue(Success(forgotPasswordEmailModel));
      } else {
        forgotPasswordEmailLiveData.setValue(Failure(forgotPasswordEmailModel.message));
      }
    } catch (ex) {
      forgotPasswordEmailLiveData.setValue(Failure(forgotPasswordEmailModel.message));
    } finally {
      notifyListeners();
    }
  }
}
