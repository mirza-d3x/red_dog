import '../services/auth_service.dart';
import '../services/web_service.dart';

class AuthRepository {
  var webService;

  AuthRepository() {
    this.webService = Webservice();
  }
  Future postLogin(
      dynamic email,
      dynamic firebaseToken,
      dynamic googleToken,
      dynamic analytics,
      ) =>
      webService?.postLogin(loginApi(email,firebaseToken,googleToken,analytics));

}
