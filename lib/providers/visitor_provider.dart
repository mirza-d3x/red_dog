// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/models/user_by_age_group_model.dart';
import 'package:reddog_mobile_app/models/user_by_city_model.dart';
import 'package:reddog_mobile_app/models/user_by_country_model.dart';
import 'package:reddog_mobile_app/models/user_by_gender_model.dart';
import 'package:reddog_mobile_app/models/user_by_lang_model.dart';
import 'package:reddog_mobile_app/models/user_by_newturned_model.dart';
import 'package:reddog_mobile_app/models/visitor_trending_time_model.dart';
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

  // user by country
  var userByCountryModel = UserByCountryModel();
  LiveData<UIState<UserByCountryModel>> userByCountryData = LiveData<UIState<UserByCountryModel>>();

  LiveData<UIState<UserByCountryModel>> userByCountryLiveData() {
    return userByCountryData;
  }

  // user by city
  var userByCityModel = UserByCityModel();
  LiveData<UIState<UserByCityModel>> userByCityData = LiveData<UIState<UserByCityModel>>();

  LiveData<UIState<UserByCityModel>> userByCityLiveData() {
    return userByCityData;
  }

  // user by gender
  var userByGenderModel = UserByGenderModel();
  LiveData<UIState<UserByGenderModel>> userByGenderData = LiveData<UIState<UserByGenderModel>>();

  LiveData<UIState<UserByGenderModel>> userByGenderLiveData() {
    return userByGenderData;
  }

  // user by new returned
  var userByNewReturnedModel = UserByNewTurnedModel();
  LiveData<UIState<UserByNewTurnedModel>> userByNewReturnedData = LiveData<UIState<UserByNewTurnedModel>>();

  LiveData<UIState<UserByNewTurnedModel>> userByNewReturnedLiveData() {
    return userByNewReturnedData;
  }

  // user by age group
  var userByAgeGroupModel = UserByAgeGroupModel();
  LiveData<UIState<UserByAgeGroupModel>> userByAgeGroupData = LiveData<UIState<UserByAgeGroupModel>>();

  LiveData<UIState<UserByAgeGroupModel>> userByAgeGroupLiveData() {
    return userByAgeGroupData;
  }

  // user by visitors trending time
  var userByVisitorsTrendingTimeModel = VisitorsTrendingTimeModel();
  LiveData<UIState<VisitorsTrendingTimeModel>> userByVisitorsTrendingTimeData = LiveData<UIState<VisitorsTrendingTimeModel>>();

  LiveData<UIState<VisitorsTrendingTimeModel>> userByVisitorsTrendingTimeLiveData() {
    return userByVisitorsTrendingTimeData;
  }

  void initialState() {
    VisitorTileData.setValue(Initial());
    userByLangData.setValue(Initial());
    userByCountryData.setValue(Initial());
    userByCityData.setValue(Initial());
    userByGenderData.setValue(Initial());
    userByNewReturnedData.setValue(Initial());
    userByAgeGroupData.setValue(Initial());
    userByVisitorsTrendingTimeData.setValue(Initial());
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
      dynamic fromDate,
      dynamic toDate,
      ) async {
    try {
      userByLangData.setValue(IsLoading());
      var googleToken = await getValue('googleToken');
      var googleId = await getValue('googleId');
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      userByLangModel = await visitorRepository.getUserByLangData(
        googleId,googleToken,storedWebId.isEmpty ?
      initialWebId: storedWebId,fromDate,toDate);
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

  // user by country method
  getUserByCountryList(
      dynamic fromDate,
      dynamic toDate,
      ) async {
    try {
      userByCountryData.setValue(IsLoading());
      var googleToken = await getValue('googleToken');
      var googleId = await getValue('googleId');
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      userByCountryModel = await visitorRepository.getUserByCountryData(
        googleId,googleToken,
          storedWebId.isEmpty ?
          initialWebId: storedWebId,fromDate,toDate
      );
      if (userByCountryModel.code == 200) {
        userByCountryData.setValue(Success(userByCountryModel));
      } else {
        userByLangData.setValue(Failure(userByCountryModel.toString()));
      }
    } catch (ex) {
      userByCountryData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

  // user by city method
  getUserByCityList(
      dynamic fromDate,
      dynamic toDate,
      ) async {
    try {
      userByCityData.setValue(IsLoading());
      var googleToken = await getValue('googleToken');
      var googleId = await getValue('googleId');
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      userByCityModel = await visitorRepository.getUserByCityData(
          googleId,googleToken,
          storedWebId.isEmpty ?
          initialWebId: storedWebId,fromDate,toDate
      );
      if (userByCityModel.code == 200) {
        userByCityData.setValue(Success(userByCityModel));
      } else {
        userByCityData.setValue(Failure(userByCityModel.toString()));
      }
    } catch (ex) {
      userByCityData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

  // user by gender method
  getUserByGenderList(
      dynamic fromDate,
      dynamic toDate,
      ) async {
    try {
      userByGenderData.setValue(IsLoading());
      var googleToken = await getValue('googleToken');
      var googleId = await getValue('googleId');
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      userByGenderModel = await visitorRepository.getUserByGenderData(
          googleId,googleToken,
          storedWebId.isEmpty ?
          initialWebId: storedWebId,fromDate,toDate
      );
      if (userByGenderModel.code == 200) {
        userByGenderData.setValue(Success(userByGenderModel));
      } else {
        userByGenderData.setValue(Failure(userByGenderModel.toString()));
      }
    } catch (ex) {
      userByGenderData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

  // user by new-returned method
  getUserByNewReturnedList(
      dynamic fromDate,
      dynamic toDate,
      ) async {
    try {
      userByNewReturnedData.setValue(IsLoading());
      var googleToken = await getValue('googleToken');
      var googleId = await getValue('googleId');
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      userByNewReturnedModel = await visitorRepository.getUserByNewReturnedData(
          googleId,googleToken,
          storedWebId.isEmpty ?
          initialWebId: storedWebId,fromDate,toDate
      );
      if (userByNewReturnedModel.code == 200) {
        userByNewReturnedData.setValue(Success(userByNewReturnedModel));
      } else {
        userByNewReturnedData.setValue(Failure(userByNewReturnedModel.toString()));
      }
    } catch (ex) {
      userByNewReturnedData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

  // user by nee-returned method
  getUserByAgeList(
      dynamic fromDate,
      dynamic toDate,
      ) async {
    try {
      userByAgeGroupData.setValue(IsLoading());
      var googleToken = await getValue('googleToken');
      var googleId = await getValue('googleId');
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      userByAgeGroupModel = await visitorRepository.getUserByAgeData(
          googleId,googleToken,
          storedWebId.isEmpty ?
          initialWebId: storedWebId,fromDate,toDate
      );
      if (userByAgeGroupModel.code == 200) {
        userByAgeGroupData.setValue(Success(userByAgeGroupModel));
      } else {
        userByAgeGroupData.setValue(Failure(userByAgeGroupModel.toString()));
      }
    } catch (ex) {
      userByAgeGroupData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }

  // user by visitors trending time method
  getUserByTrendingTimeList(
      dynamic fromDate,
      dynamic toDate,
      ) async {
    try {
      userByVisitorsTrendingTimeData.setValue(IsLoading());
      var googleToken = await getValue('googleToken');
      var googleId = await getValue('googleId');
      var initialWebId = await getValue('initialWebId');
      var storedWebId = await getValue('websiteId');
      userByVisitorsTrendingTimeModel = await visitorRepository.getUserByTrendingTimeData(
          googleId,googleToken,
          storedWebId.isEmpty ?
          initialWebId: storedWebId,
          fromDate,toDate
      );
      if (userByVisitorsTrendingTimeModel.code == 200) {
        userByVisitorsTrendingTimeData.setValue(Success(userByVisitorsTrendingTimeModel));
      } else {
        userByVisitorsTrendingTimeData.setValue(Failure(userByVisitorsTrendingTimeModel.toString()));
      }
    } catch (ex) {
      userByVisitorsTrendingTimeData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }
}
