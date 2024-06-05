// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/models/latency_model.dart';
import 'package:reddog_mobile_app/models/server_tile_model.dart';
import 'package:reddog_mobile_app/models/ssl_health_model.dart';
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

  //SSL Health
  var sslModel = SslHealthModel();
  LiveData<UIState<SslHealthModel>> sslData = LiveData<UIState<SslHealthModel>>();

  LiveData<UIState<SslHealthModel>> sslLiveData() {
    return this.sslData;
  }

  // Site uptime, domain status, domain expiry
  var serverTileModel = ServerTileModel();
  LiveData<UIState<ServerTileModel>> serverTileData = LiveData<UIState<ServerTileModel>>();

  LiveData<UIState<ServerTileModel>> serverTileLiveData() {
    return this.serverTileData;
  }


  void initialState() {
    latencyData.setValue(Initial());
    uptimeData.setValue(Initial());
    sslData.setValue(Initial());
    serverTileData.setValue(Initial());
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
      var storedWebViewId = await getValue('storedWebSiteViewId');
      latencyModel = await serverRepository.getLatency(
          googleId, googleToken,
          storedWebViewId.isEmpty ?
          initialWebId: storedWebViewId,
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
      var storedWebViewId = await getValue('storedWebSiteViewId');
      uptimeModel = await serverRepository.getUptime(
          storedWebViewId.isEmpty ?
          initialWebId: storedWebViewId,
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

  getSSLStatus(
      ) async {
    try {
      sslData.setValue(IsLoading());
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      var storedWebViewId = await getValue('storedWebSiteViewId');
      sslModel = await serverRepository.getSSLHealthData(
        storedWebViewId.isEmpty ?
          initialWebId: storedWebViewId,
      );
      if (sslModel.code == 200) {
        sslData.setValue(Success(sslModel));
      } else {
        sslData.setValue(Failure(sslModel.toString()));
      }
    } catch (ex) {
      sslData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

  getServerTileItems(
      dynamic fromDate,
      dynamic toDate,
      ) async {
    try {
      serverTileData.setValue(IsLoading());
      var email = await getValue('email');
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      var storedWebViewId = await getValue('storedWebSiteViewId');
      serverTileModel = await serverRepository.getSServerTileData(
          storedWebViewId.isEmpty ?
          initialWebId: storedWebViewId,
          email,
          fromDate,toDate
      );
      if (serverTileModel.code == 200) {
        serverTileData.setValue(Success(serverTileModel));
      } else {
        serverTileData.setValue(Failure(serverTileModel.toString()));
      }
    } catch (ex) {
      serverTileData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }
}
