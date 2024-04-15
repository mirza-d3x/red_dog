
import 'package:reddog_mobile_app/services/common_service.dart';
import 'package:reddog_mobile_app/services/visitor_service.dart';

import '../services/web_service.dart';

class CommonRepository {
  var webService;

  CommonRepository() {
    this.webService = Webservice();
  }

  Future getRegisteredWebsite() => webService?.get(getRegisteredWebsiteApi());

}