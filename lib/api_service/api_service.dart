import 'package:http/http.dart' as http;

class APIService {
  static var client = http.Client();

  Future<bool> wooSocialLogin(String userName) async {
    Map<String, String> requestHeader = {
      'Content-Type' :  'application/x-www-form-urlencoded'
    };

    var url = new Uri.https(
      "sadqapakistan.org", 
      "/wp-json/jwt-auth/v1/token"
      );

      var response = await client.post(
        url,
        headers: requestHeader,
        body: {
          "username": userName,
          "social_login": "true"
        }
      );

      if(response.statusCode == 200){
        print(response.body);
        return true;
      }
      else{
        return false;
      }
  }
}