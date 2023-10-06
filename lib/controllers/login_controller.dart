import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api_service/api_service.dart';
import '../models/user_detail_model.dart';
import '../services/navigation_service.dart';
import '../utils/routes.dart';
import '../utils/service_locator.dart';
// import 'package:flutter_woo_social_login/cupertino.dart';

class LoginController with ChangeNotifier {
  var _googleSignIn = GoogleSignIn();
  var navigationService = locator<NavigationService>();


  GoogleSignInAccount? _googleAccount;
  UserDetail? userDetail;
  final fb = FacebookLogin();

  APIService apiService = new APIService();

  googlelogin() async {
    this._googleAccount = await _googleSignIn.signIn();
    this.userDetail = new UserDetail(
      displayName: this._googleAccount!.displayName,
      email: this._googleAccount!.email,
      photoUrl: this._googleAccount!.photoUrl
      
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id',this._googleAccount!.id.toString() );
    await prefs.setString('email',this._googleAccount!.email );
    await prefs.setString('username',this._googleAccount!.displayName.toString());
    navigationService.navigateTo(homeScreenRoute);
    // bool response  = await apiService.wooSocialLogin(this.userDetail!.email ?? "");
    // print(response);
    // if (response) {
    //   final prefs = await SharedPreferences.getInstance();
    //   await prefs.setString('id',this._googleAccount!.id.toString() );
    //   await prefs.setString('email',this._googleAccount!.email );
    //   await prefs.setString('username',this._googleAccount!.displayName.toString());
    //   print(prefs.getString('id'));
    //   print(prefs.getString('id'));
    //   navigationService.navigateTo(homeScreenRoute);
    // }
    // else {
    //   Fluttertoast.showToast(
    //       msg: "Sign In Failed",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 12.0
    //   );
    // }
    notifyListeners();
  }



  facebookLogin() async {
    print("hamza");
    var result = await FacebookAuth.instance.login(
      permissions: ["public_profile", "email"],
    );

    if (result.status == LoginStatus.success) {
      final requestData = await FacebookAuth.instance.getUserData(
        fields: "email, name, picture",
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('id', this.userDetail!.email.toString());
      await prefs.setString('email', this.userDetail!.email.toString());
      await prefs.setString(
          'username', this.userDetail!.displayName.toString());
      print(prefs.getString('id'));
      print(prefs.getString('id'));

      this.userDetail = new UserDetail(
        displayName: requestData["name"],
        email: requestData["email"],
        photoUrl: requestData["picture"]["data"]["url"] ?? "",
      );
      navigationService.navigateTo(homeScreenRoute);
      // await apiService.wooSocialLogin(this.userDetail!.email ?? "");
      // bool response =
      // await apiService.wooSocialLogin(this.userDetail!.email ?? "");
      // print(response);
      // if (response) {
      //   final prefs = await SharedPreferences.getInstance();
      //   await prefs.setString('id', this.userDetail!.email.toString());
      //   await prefs.setString('email', this.userDetail!.email.toString());
      //   await prefs.setString(
      //       'username', this.userDetail!.displayName.toString());
      //   print(prefs.getString('id'));
      //   print(prefs.getString('id'));
      //   navigationService.navigateTo(homeScreenRoute);
      // } else {
      //   Fluttertoast.showToast(
      //       msg: "Sign In Failed",
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.BOTTOM,
      //       timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.red,
      //       textColor: Colors.white,
      //       fontSize: 12.0);
      // }
      notifyListeners();
    }
  }




  logOut() async {
    this._googleAccount = await _googleSignIn.signOut();
    // await FacebookAuth.i.logOut();
    userDetail = null;
    notifyListeners();
  }
}
