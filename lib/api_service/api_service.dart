import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  static var client = http.Client();

  Future<bool> wooSocialLogin(String userName) async {
    var headers = {
      'Cookie': 'mailpoet_page_view=%7B%22timestamp%22%3A1699136400%7D'
    };
    var request = http.Request('GET', Uri.parse('https://sadqapakistan.org/wp-json/wc/v3/customers?email=${userName}&consumer_key=ck_601c0f9d8807130f6148382d09dcb300b5af7ca3&consumer_secret=cs_40f25c5b67bb55efba1c64a1a9f44efac859c8a5'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if(response.statusCode == 200){
      String data = await response.stream.bytesToString();
      List token =  json.decode(data);
      if(token.length > 0)
        {
          return true;
        }
      else
        {
          return false;
        }

      }
      else{
      print(response.reasonPhrase);
        return false;
      }
  }


  Future<bool> wooSocialRegister(String userName,String email,String pass) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic Y2tfNjAxYzBmOWQ4ODA3MTMwZjYxNDgzODJkMDlkY2IzMDBiNWFmN2NhMzpjc180MGYyNWM1YjY3YmI1NWVmYmExYzY0YTFhOWY0NGVmYWM4NTljOGE1',
      'Cookie': 'mailpoet_page_view=%7B%22timestamp%22%3A1699134912%7D'
    };
    var request = http.Request('POST', Uri.parse('https://sadqapakistan.org/wp-json/wc/v3/customers'));
    request.body = json.encode({
      "username": userName,
      "email": email,
      "password": pass
    });

    print(request);
    print(email.toString());
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 201) {
      String data = await response.stream.bytesToString();
      var token =  json.decode(data);
      print(token['id']);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('id',token['id'].toString());
      await prefs.setString('email',email );
      await prefs.setString('username',userName);
      print(prefs.getString('id'));
      Fluttertoast.showToast(msg: "User Created Successfully");
      return true;

    }
    else
    {
      String data = await response.stream.bytesToString();
      final token =  json.decode(data);
      print(token);
      Fluttertoast.showToast(msg: token["message"]);
      return false;

    }
  }
}