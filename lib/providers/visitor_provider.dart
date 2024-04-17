// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/models/user_by_lang_model.dart';
import 'package:reddog_mobile_app/models/visitors_tiles_model.dart';
import 'package:reddog_mobile_app/repositories/visitor_repository.dart';
import 'package:reddog_mobile_app/utilities/shared_prefernces.dart';
import '../core/live_data.dart';
import '../core/ui_state.dart';

class VisitorProvider extends ChangeNotifier {
  VisitorRepository visitorRepository;

  VisitorProvider({required this.visitorRepository});

  //Tile Data
  var tileDataModel = VisitorsTileDataModel();
  LiveData<UIState<VisitorsTileDataModel>> VisitorTileData = LiveData<UIState<VisitorsTileDataModel>>();

  LiveData<UIState<VisitorsTileDataModel>> visitorTileLiveData() {
    return VisitorTileData;
  }

  // user by language

  var userByLangModel = UserByLangModel();
  LiveData<UIState<UserByLangModel>> userByLangData = LiveData<UIState<UserByLangModel>>();

  LiveData<UIState<UserByLangModel>> userByLangLiveData() {
    return userByLangData;
  }

  void initialState() {
    VisitorTileData.setValue(Initial());
    userByLangData.setValue(Initial());
    notifyListeners();
  }


  // user Tile info method
  getVisitorTileData(
      dynamic fromDate,
      dynamic toDate,
      ) async {
    try {
      VisitorTileData.setValue(IsLoading());
      var googleToken = await getValue('googleToken');
      var googleId = await getValue('googleId');
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      tileDataModel = await visitorRepository.getVisitorTile(googleId, googleToken,
          storedWebId.isEmpty ?
          initialWebId: storedWebId,
          fromDate,toDate);
      if (tileDataModel.code == 200) {
        VisitorTileData.setValue(Success(tileDataModel));
      } else {
        VisitorTileData.setValue(Failure(tileDataModel.toString()));
      }
    } catch (ex) {
      VisitorTileData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

  // user by lang method
  getUserByLangList(
      ) async {
    try {
      userByLangData.setValue(IsLoading());
      var googleToken = await getValue('googleToken');
      var googleId = await getValue('googleId');
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      userByLangModel = await visitorRepository.getUserByLangData();
      if (userByLangModel.code == 200) {
        userByLangData.setValue(Success(userByLangModel));
      } else {
        userByLangData.setValue(Failure(userByLangModel.toString()));
      }
    } catch (ex) {
      userByLangData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }
}
