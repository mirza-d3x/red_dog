// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/models/latency_model.dart';
import 'package:reddog_mobile_app/models/uptime_model.dart';
import 'package:reddog_mobile_app/repositories/server_repository.dart';
import '../core/live_data.dart';
import '../core/ui_state.dart';
import '../repositories/auth_repository.dart';
import '../utilities/shared_prefernces.dart';

class ServerProvider extends ChangeNotifier {
  ServerRepository serverRepository;

  ServerProvider({required this.serverRepository});


  // latency
  var latencyModel = LatencyModel();
  LiveData<UIState<LatencyModel>> latencyData = LiveData<UIState<LatencyModel>>();

  LiveData<UIState<LatencyModel>> latencyLiveData() {
    return this.latencyData;
  }


  //uptime
  var uptimeModel = UptimeModel();
  LiveData<UIState<UptimeModel>> uptimeData = LiveData<UIState<UptimeModel>>();

  LiveData<UIState<UptimeModel>> uptimeLiveData() {
    return this.uptimeData;
  }

  void initialState() {
    latencyData.setValue(Initial());
    uptimeData.setValue(Initial());
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

  getUptimeValue(
      dynamic fromDate,
      dynamic toDate,
      ) async {
    try {
      uptimeData.setValue(IsLoading());
      var email = await getValue('email');
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      uptimeModel = await serverRepository.getUptime(
          storedWebId.isEmpty ?
          initialWebId: storedWebId,
          email,
          fromDate,toDate
      );
      if (uptimeModel.code == 200) {
        uptimeData.setValue(Success(uptimeModel));
      } else {
        uptimeData.setValue(Failure(uptimeModel.toString()));
      }
    } catch (ex) {
      uptimeData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

}
