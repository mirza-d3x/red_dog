import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:reddog_mobile_app/utilities/api_helpers.dart';


class Webservice {
  Future<T> get<T>(Resource<T> resource) async {
    try {
      Response response;
      String token = await getToken();
      if (token.isNotEmpty) {
        response =
        await http.get(getUrl(resource.url!),
            headers: getHeaders(token)
        );
      } else {
        response = await http.get(getUrl(resource.url!));
      }
      return resource.parse!(response);
    } catch (e) {
      print('******webservice get******' + e.toString());
      throw e;
    }
  }

  Future<T> post<T>(Resource<T> resource) async {
    try {
      Response response;
      String token = await getToken();
      print(token);
      if (token.isNotEmpty) {
        response = await http.post(getUrl(resource.url!),
            body: resource.body, headers: getHeaders(token));
      } else {
        response = await http.post(
          getUrl(resource.url!),
          body: resource.body,
        );
      }
      return resource.parse!(response);
    } catch (e) {
      print('*******webservice post******' + e.toString());
      throw e;
    }
  }

  Future<T> postJson<T>(Resource<T> resource) async {
    try {
      Response response;
      String token = await getToken();
      print(token);
      if (token.isNotEmpty) {
        response = await http.post(getUrl(resource.url!),
            body: resource.body, headers: getJsonHeader(token));
      } else {
        response = await http.post(
          getUrl(resource.url!),
          body: resource.body,
        );
      }
      return resource.parse!(response);
    } catch (e) {
      print('*******webservice post******' + e.toString());
      throw e;
    }
  }

  Future<T> postLogin<T>(Resource<T> resource) async {
    try {
      Response response;
      response = await http.post(getUrl(resource.url!),
          body: resource.body,
          headers: getJsonContent());
      print(response.statusCode);
      return resource.parse!(response);
    } catch (e) {
      print('*******webservice post******' + e.toString());
      throw e;
    }
  }

  Future<T> put<T>(Resource<T> resource) async {
    try {
      Response response;
      String token = await getToken();
      if (token!= '') {
        response = await http.put(getUrl(resource.url!),
            body: resource.body, headers: getJsonHeader(token));
      } else {
        response = await http.put(
          getUrl(resource.url!),
          body: resource.body,
          // headers: getHeadersWithApplicationJson()
        );
      }
      return resource.parse!(response);
    } catch (e) {
      print('**webservice put***' + e.toString());
      throw e;
    }
  }

  Future<T> putToken<T>(Resource<T> resource) async {
    try {
      Response response;
      String token = await getToken();
      if (token!= '') {
        response = await http.put(getUrl(resource.url!),
            body: resource.body, headers: getHeaders(token));
      } else {
        response = await http.put(
          getUrl(resource.url!),
          body: resource.body,
          // headers: getHeadersWithApplicationJson()
        );
      }
      return resource.parse!(response);
    } catch (e) {
      print('**webservice put***' + e.toString());
      throw e;
    }
  }

  Future<T> delete<T>(Resource<T> resource) async {
    try {
      Response response;
      String token = await getToken();
      print(resource.url);
      if (token.isNotEmpty) {
        response = await http.get(getUrl(resource.url!),
            headers: getJsonHeader(token));
      } else {
        response = await http.get(getUrl(resource.url!));
      }
      return resource.parse!(response);
    } catch (e) {
      print('******webservice delete******' + e.toString());
      throw e;
    }
  }

  Future<T> getCookieLogin<T>(Resource<T> resource) async {
    try {
      Response response;
      response = await http.get(getUrl(resource.url!),
          // body: resource.body,
          headers: getLoginHeaders());
      print(response.statusCode);
      return resource.parse!(response);
    } catch (e) {
      print('*******webservice post******' + e.toString());
      throw e;
    }
  }

}
