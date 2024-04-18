// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/models/user_profile_model.dart';
import 'package:reddog_mobile_app/repositories/user_repository.dart';
import '../core/live_data.dart';
import '../core/ui_state.dart';
import '../utilities/shared_prefernces.dart';

class UserProfileProvider extends ChangeNotifier {
  UserRepository userRepository;

  UserProfileProvider({required this.userRepository});

  var profileModel = UserProfileModel();
  LiveData<UIState<UserProfileModel>> profileData = LiveData<UIState<UserProfileModel>>();

  LiveData<UIState<UserProfileModel>> profileLiveData() {
    return this.profileData;
  }
  void initialState() {
    profileData.setValue(Initial());
    notifyListeners();
  }

  getProfile() async {
    try {
      profileData.setValue(IsLoading());
      var googleId = await getValue('googleId');
      profileModel = await userRepository.getUserProfileData(googleId);
      if (profileModel.status == 'success') {
        profileData.setValue(Success(profileModel));
      } else {
        profileData.setValue(Failure(profileModel.toString()));
      }
    } catch (ex) {
      profileData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

}
