// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/models/acquisition_top_channels_model.dart';
import 'package:reddog_mobile_app/models/traffic_source_model.dart';
import 'package:reddog_mobile_app/repositories/acquisition_repository.dart';
import '../core/live_data.dart';
import '../core/ui_state.dart';
import '../utilities/shared_prefernces.dart';

class AcquisitionProvider extends ChangeNotifier {
  AcquisitionRepository acquisitionRepository;

  AcquisitionProvider({required this.acquisitionRepository});

  // top channels
  var topChannelsModel = AcquisitionTopChannelsModel();
  LiveData<UIState<AcquisitionTopChannelsModel>> topChannelsData = LiveData<UIState<AcquisitionTopChannelsModel>>();

  LiveData<UIState<AcquisitionTopChannelsModel>> topChannelsLiveData() {
    return this.topChannelsData;
  }

  // traffic source
  var trafficSourceModel = TrafficSourceModel();
  LiveData<UIState<TrafficSourceModel>> trafficSourceData = LiveData<UIState<TrafficSourceModel>>();

  LiveData<UIState<TrafficSourceModel>> trafficSourceLiveData() {
    return this.trafficSourceData;
  }

  void initialState() {
    topChannelsData.setValue(Initial());
    trafficSourceData.setValue(Initial());
    notifyListeners();
  }


  // get top channels
  getTopChannels(
      dynamic fromDate,
      dynamic toDate
      ) async {
    try {
      topChannelsData.setValue(IsLoading());
      var googleToken = await getValue('googleToken');
      var googleId = await getValue('googleId');
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      topChannelsModel = await acquisitionRepository.getTopChannelData(
          googleId,googleToken,
          storedWebId.isEmpty ?
          initialWebId: storedWebId,
          fromDate,toDate
      );
      if (topChannelsModel.code == 200) {
        topChannelsData.setValue(Success(topChannelsModel));
      } else {
        topChannelsData.setValue(Failure(topChannelsModel.toString()));
      }
    } catch (ex) {
      topChannelsData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

  // get top channels
  getTrafficSource(
      dynamic fromDate,
      dynamic toDate
      ) async {
    try {
      trafficSourceData.setValue(IsLoading());
      var googleToken = await getValue('googleToken');
      var googleId = await getValue('googleId');
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      trafficSourceModel = await acquisitionRepository.getTrafficSourceData(
          googleId,googleToken,
          storedWebId.isEmpty ?
          initialWebId: storedWebId,
          fromDate,toDate
      );
      if (trafficSourceModel.code == 200) {
        trafficSourceData.setValue(Success(trafficSourceModel));
      } else {
        trafficSourceData.setValue(Failure(trafficSourceModel.toString()));
      }
    } catch (ex) {
      trafficSourceData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

}
