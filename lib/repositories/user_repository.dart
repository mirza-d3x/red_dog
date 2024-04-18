import 'package:reddog_mobile_app/services/user_service.dart';

import '../services/auth_service.dart';
import '../services/web_service.dart';

class UserRepository {
  var webService;

  UserRepository() {
    this.webService = Webservice();
  }
  Future getUserProfileData(dynamic googleId) =>
      webService?.postWithGoogleToken(getUserProfileApi(googleId));

}
