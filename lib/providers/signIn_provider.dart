// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/models/signIn_model.dart';
import '../core/live_data.dart';
import '../core/ui_state.dart';
import '../repositories/auth_repository.dart';
import '../utilities/shared_prefernces.dart';

class SignInProvider extends ChangeNotifier {
  AuthRepository authRepository;

  SignInProvider({required this.authRepository});

  var signInModel = SignInModel();
  LiveData<UIState<SignInModel>> signInData = LiveData<UIState<SignInModel>>();

  LiveData<UIState<SignInModel>> signInLiveData() {
    return this.signInData;
  }
  void initialState() {
    signInData.setValue(Initial());
    notifyListeners();
  }

  checkSignIn(
      dynamic email,
      dynamic password,
      dynamic firebaseToken,
      ) async {
    try {
      signInData.setValue(IsLoading());
      signInModel = await authRepository.postSignIn(email,password,firebaseToken);
      if (signInModel.status == 'success') {
        setValue('token', signInModel.userData!.jToken);
        setValue('profilePic', signInModel.userData!.picture);
        setValue('googleToken', signInModel.token);
        setValue('googleId', signInModel.userData!.googleId);
        // setValue('analytics', loginModel.isAnalytic);
        setValue('email', signInModel.userData!.email);
        signInData.setValue(Success(signInModel));
      } else {
        signInData.setValue(Failure(signInModel.toString()));
      }
    } catch (ex) {
      signInData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

}
