// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/models/acquisition_top_channels_model.dart';
import 'package:reddog_mobile_app/models/device_category_model.dart';
import 'package:reddog_mobile_app/models/most_visited_page_model.dart';
import 'package:reddog_mobile_app/models/search_keyword_model.dart';
import 'package:reddog_mobile_app/models/top_channels_by_date_model.dart';
import 'package:reddog_mobile_app/models/traffic_source_by_date_model.dart';
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

  // top channels by date
  var topChannelsByDateModel = ChannelsByDateModel();
  LiveData<UIState<ChannelsByDateModel>> topChannelsByDateData = LiveData<UIState<ChannelsByDateModel>>();

  LiveData<UIState<ChannelsByDateModel>> topChannelsByDateLiveData() {
    return this.topChannelsByDateData;
  }

  // traffic source by date
  var trafficSourceByDateModel = TrafficSourceByDateModel();
  LiveData<UIState<TrafficSourceByDateModel>> trafficSourceByDateData =
  LiveData<UIState<TrafficSourceByDateModel>>();

  LiveData<UIState<TrafficSourceByDateModel>> trafficSourceByDateLiveData() {
    return this.trafficSourceByDateData;
  }

  // traffic source
  var trafficSourceModel = TrafficSourceModel();
  LiveData<UIState<TrafficSourceModel>> trafficSourceData = LiveData<UIState<TrafficSourceModel>>();

  LiveData<UIState<TrafficSourceModel>> trafficSourceLiveData() {
    return this.trafficSourceData;
  }

  // most Visited page list
  var mostVisitedPageModel = MostVisitedPageModel();
  LiveData<UIState<MostVisitedPageModel>> mostVisitedPageData = LiveData<UIState<MostVisitedPageModel>>();

  LiveData<UIState<MostVisitedPageModel>> mostVisitedPageLiveData() {
    return this.mostVisitedPageData;
  }

  // device category
  var deviceCategoryModel = DeviceCategoryModel();
  LiveData<UIState<DeviceCategoryModel>> deviceCategoryData = LiveData<UIState<DeviceCategoryModel>>();

  LiveData<UIState<DeviceCategoryModel>> deviceCategoryLiveData() {
    return this.deviceCategoryData;
  }

  // search keyword
  var searchKeywordModel = SearchKeywordModel();
  LiveData<UIState<SearchKeywordModel>> searchKeywordData = LiveData<UIState<SearchKeywordModel>>();

  LiveData<UIState<SearchKeywordModel>> searchKeywordLiveData() {
    return this.searchKeywordData;
  }

  void initialState() {
    topChannelsData.setValue(Initial());
    trafficSourceData.setValue(Initial());
    mostVisitedPageData.setValue(Initial());
    deviceCategoryData.setValue(Initial());
    topChannelsByDateData.setValue(Initial());
    trafficSourceByDateData.setValue(Initial());
    searchKeywordData.setValue(Initial());
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
          fromDate,
          toDate
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

  // get top channels by date
  getTopChannelsByDate(
      dynamic fromDate,
      dynamic toDate
      ) async {
    try {
      topChannelsByDateData.setValue(IsLoading());
      var googleToken = await getValue('googleToken');
      var googleId = await getValue('googleId');
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      topChannelsByDateModel = await acquisitionRepository.getTopChannelsByDateData(
          googleId,googleToken,
          storedWebId.isEmpty ?
          initialWebId: storedWebId,
          fromDate,
          toDate
      );
      if (topChannelsByDateModel.code == 200) {
        topChannelsByDateData.setValue(Success(topChannelsByDateModel));
      } else {
        topChannelsByDateData.setValue(Failure(topChannelsByDateModel.toString()));
      }
    } catch (ex) {
      topChannelsByDateData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }


  // get traffic source by date
  getTrafficSourceByDate(
      dynamic fromDate,
      dynamic toDate
      ) async {
    try {
      trafficSourceByDateData.setValue(IsLoading());
      var googleToken = await getValue('googleToken');
      var googleId = await getValue('googleId');
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      trafficSourceByDateModel = await acquisitionRepository.getTrafficSourcesByDateData(
          googleId,googleToken,
          storedWebId.isEmpty ?
          initialWebId: storedWebId,
          fromDate,
          toDate
      );
      if (trafficSourceByDateModel.code == 200) {
        trafficSourceByDateData.setValue(Success(trafficSourceByDateModel));
      } else {
        trafficSourceByDateData.setValue(Failure(trafficSourceByDateModel.toString()));
      }
    } catch (ex) {
      trafficSourceByDateData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

  // get traffic sources
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
          fromDate,
          toDate
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

  // get most visited page list
  getMostVisitedPageList(
      dynamic fromDate,
      dynamic toDate
      ) async {
    try {
      mostVisitedPageData.setValue(IsLoading());
      var googleToken = await getValue('googleToken');
      var googleId = await getValue('googleId');
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      mostVisitedPageModel = await acquisitionRepository.getMostVisitedPageData(
          googleId,googleToken,
          storedWebId.isEmpty ?
          initialWebId: storedWebId,
          fromDate,
          toDate
      );
      if (mostVisitedPageModel.code == 200) {
        mostVisitedPageData.setValue(Success(mostVisitedPageModel));
      } else {
        mostVisitedPageData.setValue(Failure(mostVisitedPageModel.toString()));
      }
    } catch (ex) {
      mostVisitedPageData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

  // get device category
  getDeviceCategory(
      dynamic fromDate,
      dynamic toDate
      ) async {
    try {
      deviceCategoryData.setValue(IsLoading());
      var googleToken = await getValue('googleToken');
      var googleId = await getValue('googleId');
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      deviceCategoryModel = await acquisitionRepository.getDeviceCategoryData(
          googleId,googleToken,
          storedWebId.isEmpty ?
          initialWebId: storedWebId,
          fromDate,
          toDate
      );
      if (deviceCategoryModel.code == 200) {
        deviceCategoryData.setValue(Success(deviceCategoryModel));
      } else {
        deviceCategoryData.setValue(Failure(deviceCategoryModel.toString()));
      }
    } catch (ex) {
      deviceCategoryData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

  // get search keyword list
  getSearchKeywordList(
      dynamic fromDate,
      dynamic toDate
      ) async {
    try {
      searchKeywordData.setValue(IsLoading());
      var googleToken = await getValue('googleToken');
      var googleId = await getValue('googleId');
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      searchKeywordModel = await acquisitionRepository.getSearchKeywordData(
          googleId,googleToken,
          storedWebId.isEmpty ?
          initialWebId: storedWebId,
          fromDate,
          toDate
      );
      if (searchKeywordModel.code == 200) {
        searchKeywordData.setValue(Success(searchKeywordModel));
      } else {
        searchKeywordData.setValue(Failure(searchKeywordModel.toString()));
      }
    } catch (ex) {
      searchKeywordData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }
}
