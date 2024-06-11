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

  Future postAppleLogin(
      dynamic email,
      dynamic firebaseToken,
      dynamic googleToken,
      dynamic analytics,
      dynamic appleId,
      ) =>
      webService?.postLogin(appleLoginApi(email,firebaseToken,googleToken,analytics,appleId));

  Future postSignIn(
      dynamic email,
      dynamic password,
      dynamic firebaseToken,
      ) =>
      webService?.postLogin(signInApi(email,password,firebaseToken));

  Future forgotPasswordEmailData(
      dynamic email,
      ) => webService?.postWithoutToken(forgotPasswordEmailApi(email));

  Future forgotPasswordData(
      dynamic email,
      dynamic otp,
      dynamic password,
      ) => webService?.postWithoutToken(forgotPasswordApi(email,otp,password));
}
