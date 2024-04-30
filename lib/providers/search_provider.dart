// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:reddog_mobile_app/models/search_list_model.dart';
import 'package:reddog_mobile_app/repositories/common_repository.dart';
import '../core/live_data.dart';
import '../core/ui_state.dart';
import '../utilities/shared_prefernces.dart';

class SearchProvider extends ChangeNotifier {
  CommonRepository commonRepository;

  SearchProvider({required this.commonRepository});

  var searchModel = SearchResultModel();
  LiveData<UIState<SearchResultModel>> searchListData = LiveData<UIState<SearchResultModel>>();

  LiveData<UIState<SearchResultModel>> searchListLiveData() {
    return searchListData;
  }

  void initialState() {
    searchListData.setValue(Initial());
    notifyListeners();
  }

  fetchSearchList(dynamic keyword) async {
    try {
      searchListData.setValue(IsLoading());
      searchModel = await commonRepository.getSearchResult(keyword);
      if (searchModel.code == 200) {
        searchListData.setValue(Success(searchModel));
      } else {
        searchListData.setValue(Failure(searchModel.toString()));
      }
    } catch (ex) {
      searchListData.setValue(Failure(ex.toString()));
    } finally {
      notifyListeners();
    }
  }
}
