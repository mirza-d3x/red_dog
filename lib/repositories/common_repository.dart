import 'package:reddog_mobile_app/services/common_service.dart';
import 'package:reddog_mobile_app/services/visitor_service.dart';

import '../services/web_service.dart';

class CommonRepository {
  var webService;

  CommonRepository() {
    this.webService = Webservice();
  }

  Future getRegisteredWebsite(dynamic googleId) =>
      webService?.get(getRegisteredWebsiteApi(googleId));

  Future getNotificationList(dynamic email) =>
      webService?.get(getNotificationListApi(email));

  Future putLogout(dynamic email, dynamic fireId) =>
      webService?.put(logoutApi(email, fireId));

  Future getSearchResult(dynamic keyword) =>
      webService?.get(searchApi(keyword));

  // this api is used for delete account by id
  Future deleteAccount(String googleId) =>
      webService?.get(deleteAccountApi(googleId));
}
