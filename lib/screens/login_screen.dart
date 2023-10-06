import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sadqapak/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/navigation_service.dart';
import '../utils/service_locator.dart';
import '../widgets/button_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'forgot-password_screen.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  var navigationService = locator<NavigationService>();


  Future<void> login() async{
    showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': 'mailpoet_page_view=%7B%22timestamp%22%3A1661795477%7D; mailpoet_subscriber=%7B%22subscriber_id%22%3A12%7D'
    };
    var request = http.Request('POST', Uri.parse('https://sadqapakistan.org/wp-json/jwt-auth/v1/token'));
    request.bodyFields = {
      'username': emailcontroller.text.toString(),
      'password': passwordcontroller.text.toString()
    };
    request.headers.addAll(headers);


    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      String data = await response.stream.bytesToString();
      final token =  json.decode(data);
      // print(token);
      print(token['data']['email']);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('id',token['data']['id'].toString() );
      await prefs.setString('email',token['data']['email'] );
      await prefs.setString('username',token['data']['displayName']);
      print(prefs.getString('id'));
      print(prefs.getString('id'));
      Navigator.of(context).pop();
      navigationService.navigateTo(homeScreenRoute);
      // Fluttertoast.showToast(msg: "Incorrect Password, Please Try Again");
    }
    else if(response.statusCode == 403){
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: "Incorrect email or password, please try again");
    }
    else {
      Navigator.of(context).pop();
      print(response.stream.bytesToString());
    }

  }
  bool IsPassword = true;
  bool ShowPassword = true;
  bool value = false;
  bool _isObscure = true;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "",
                style: TextStyle(
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                  height: 1.6,
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(247, 185, 26, 1),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/images/logo.png",
                width: 200,
                // height: 200,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.normal,
                  height: 1.6,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailcontroller,
                            autocorrect: true,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 20.0,
                              ),
                              hintText: 'Email Address',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Password",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: passwordcontroller,
                            autocorrect: true,
                            obscureText: _isObscure,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure ? Icons.visibility : Icons.visibility_off,
                                ),
                                color: Colors.green,
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                              ),
                              /*suffixIcon: GestureDetector(
                                onTap: () {
                                  ShowPassword = !ShowPassword;
                                },
                                child: IsPassword == "true"
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Color.fromRGBO(138, 158, 184, 1),
                                        size: 20,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: Color.fromRGBO(138, 158, 184, 1),
                                        size: 20,
                                      ),
                              ),*/
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 20.0,
                              ),
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Checkbox(
                    value: this.value,
                    checkColor: Colors.white,
                    focusColor: Color.fromRGBO(36, 124, 38, 1),
                    activeColor: Color.fromRGBO(36, 124, 38, 1),
                    onChanged: (bool? value) {
                      setState(() {
                        this.value = value!;
                      });
                    },
                  ),
                  Text(
                    "Remember me",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          // width: 5.0,
                          color: Colors.white,
                        ),
                        minimumSize: Size.fromHeight(
                            MediaQuery.of(context).size.height * 0.052),
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.02),
                        ),
                      ),
                      onPressed: () {
                        login();
                        // navigationService.navigateTo(homeScreenRoute);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.022,
                            bottom: MediaQuery.of(context).size.height * 0.022),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                          ),
                        ),
                      ))),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder:
                                  (BuildContext context) =>
                                      ForgotPasswordScreen()),
                        );
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getSocialButton(String image, String text) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black,
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 26,
          ),
        ],
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(
              image,
            ),
            width: 30,
            height: 30,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
