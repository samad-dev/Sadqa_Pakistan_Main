import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:provider/provider.dart';
import 'package:sadqapak/screens/login_screen.dart';
import 'package:sadqapak/utils/routes.dart';

import '../api_service/api_service.dart';
import '../controllers/login_controller.dart';
import '../models/user_detail_model.dart';
import '../services/navigation_service.dart';
import '../utils/service_locator.dart';
import '../widgets/button_widget.dart';

class SelectAccountScreen extends StatefulWidget {
  @override
  State<SelectAccountScreen> createState() => _SelectAccountScreenState();
}

class _SelectAccountScreenState extends State<SelectAccountScreen> {
  var navigationService = locator<NavigationService>();
  final fb = FacebookLogin();
  UserDetail? userDetail;
  APIService apiService = new APIService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
          ChangeNotifierProvider(create: (context)=>LoginController(),
          builder: (context,child){
            return Scaffold(

              backgroundColor: Colors.white,
              body: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    /*Text(
                      "“O believers give of what \n We have provided for \n you.” \n [Qur’an 2:254]",
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
                    ),*/
                    Image.asset(
                      "assets/images/logo.png",
                      width: 200,
                      // height: 200,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Let’s you in",
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
                    Column(
                      children: [
                        GestureDetector(child: getSocialButton("assets/images/google.png", "Google"),
                          onTap: () {
                            print("tapped on google button");
                            Provider.of<LoginController>(context, listen: false)
                                .googlelogin();
                          },),
                        GestureDetector(child: getSocialButton("assets/images/facebook.png", "Facebook"),
                            onTap: () async{
                              print('samad');
                              Provider.of<LoginController>(context, listen: false)
                                  .facebookLogin();
                            }
                        ),
                        // getSocialButton("assets/images/iphone.png", "Iphone"),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Or",
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        height: 1.6,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
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
                              color: Colors.transparent ?? Colors.white,
                            ),
                            minimumSize:
                            Size.fromHeight(MediaQuery.of(context).size.height * 0.052),
                            primary: Color.fromRGBO(36, 124, 38, 1) ?? Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15 ??
                                  MediaQuery.of(context).size.width * 0.02),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) => loginScreen(),
                              ),
                                  (route) => false,//if you want to disable back feature set to false
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.022,
                                bottom: MediaQuery.of(context).size.height * 0.022),
                            child: Text(
                              "Sign In with Password",
                              style: TextStyle(
                                color: Colors.white ?? Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: MediaQuery.of(context).size.width * 0.035,
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have an account?",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            navigationService.navigateTo(signupScreenRoute);
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                              color: Color.fromRGBO(36, 124, 38, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          )],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "“O believers give of what \n We have provided for \n you.” \n [Qur’an 2:254]",
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
                "Let’s you in",
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
              Column(
                children: [
                  GestureDetector(child: getSocialButton("assets/images/google.png", "Google"),
                    onTap: () {
                      print("tapped on google button");
                      Provider.of<LoginController>(context, listen: false)
                          .googlelogin();
                    },),
                  GestureDetector(child: getSocialButton("assets/images/facebook.png", "Facebook"),
                      onTap: () async{
                        print('samad');

                        print('somi');
/*
                        print('somi');
                        final res = await fb.logIn(permissions: [
                          FacebookPermission.publicProfile,
                          FacebookPermission.email,
                        ]);*/
                        /*if(res.status ==FacebookLoginStatus.success){
                          final requestData  = await FacebookAuth.i.getUserData(
                            fields: "email,name,picture",
                          );

                          final profile = await fb.getUserProfile();
                          final email = await fb.getUserEmail();
                          final imageUrl = await fb.getProfileImageUrl(width: 100);
                          this.userDetail = new UserDetail(
                            displayName: profile!.name ?? "",
                            email: email,
                            photoUrl: imageUrl ?? "",
                          );
                          await apiService.wooSocialLogin(this.userDetail!.email?? "");

                        }*/
                      }
                  ),
                  getSocialButton("assets/images/iphone.png", "Iphone"),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Or",
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
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
                        color: Colors.transparent ?? Colors.white,
                      ),
                      minimumSize:
                      Size.fromHeight(MediaQuery.of(context).size.height * 0.052),
                      primary: Color.fromRGBO(36, 124, 38, 1) ?? Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15 ??
                            MediaQuery.of(context).size.width * 0.02),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => loginScreen(),
                        ),
                            (route) => false,//if you want to disable back feature set to false
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.022,
                          bottom: MediaQuery.of(context).size.height * 0.022),
                      child: Text(
                        "Sign In with Password",
                        style: TextStyle(
                          color: Colors.white ?? Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                        ),
                      ),
                    )),

              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account?",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      navigationService.navigateTo(signupScreenRoute);
                    },
                    child: Text(
                      "SIGNUP",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                        color: Color.fromRGBO(36, 124, 38, 1),
                      ),
                    ),
                  ),
                ],
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
