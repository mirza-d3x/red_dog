
import 'package:reddog_mobile_app/services/visitor_service.dart';

import '../services/web_service.dart';

class VisitorRepository {
  var webService;

  VisitorRepository() {
    this.webService = Webservice();
  }

  Future getVisitorTile() => webService?.get(getVisitorsTileDataApi());

}