// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/models/latency_model.dart';
import 'package:reddog_mobile_app/repositories/server_repository.dart';
import '../core/live_data.dart';
import '../core/ui_state.dart';
import '../repositories/auth_repository.dart';
import '../utilities/shared_prefernces.dart';

class ServerProvider extends ChangeNotifier {
  ServerRepository serverRepository;

  ServerProvider({required this.serverRepository});

  var latencyModel = LatencyModel();
  LiveData<UIState<LatencyModel>> latencyData = LiveData<UIState<LatencyModel>>();

  LiveData<UIState<LatencyModel>> latencyLiveData() {
    return this.latencyData;
  }
  void initialState() {
    latencyData.setValue(Initial());
    notifyListeners();
  }

  getLatencyValue(
      dynamic fromDate,
      dynamic toDate,
      ) async {
    try {
      latencyData.setValue(IsLoading());
      var googleToken = await getValue('googleToken');
      var googleId = await getValue('googleId');
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      latencyModel = await serverRepository.getLatency(
          googleId, googleToken,
          storedWebId.isEmpty ?
          initialWebId: storedWebId,
          fromDate,toDate
      );
      if (latencyModel.code == 200) {
        latencyData.setValue(Success(latencyModel));
      } else {
        latencyData.setValue(Failure(latencyModel.toString()));
      }
    } catch (ex) {
      latencyData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

}
