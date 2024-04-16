// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
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

  void initialState() {
    VisitorTileData.setValue(Initial());
    notifyListeners();
  }

  getVisitorTileData(
      dynamic viewId,
      dynamic fromDate,
      dynamic toDate,
      ) async {
    try {
      VisitorTileData.setValue(IsLoading());
      var googleToken = await getValue('googleToken');
      var googleId = await getValue('googleId');
      tileDataModel = await visitorRepository.getVisitorTile(googleId, googleToken,viewId,fromDate,toDate);
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
}
