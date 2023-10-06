import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sadqapak/controllers/login_controller.dart';
import 'package:sadqapak/screens/change_password.dart';
import 'package:sadqapak/screens/contact_info_screen.dart';
import 'package:sadqapak/screens/home_screen.dart';
import 'package:sadqapak/screens/my_order_screen.dart';
import 'package:sadqapak/screens/privacy.dart';
import 'package:sadqapak/screens/signup_screen.dart';
import 'package:sadqapak/utils/routes.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/cart.dart';
import '../services/navigation_service.dart';
import '../utils/service_locator.dart';
import 'Contact_us.dart';
import 'billing_adress_screen.dart';
import 'login_screen.dart';

class MainDrawerScreen extends StatefulWidget {
   MainDrawerScreen({Key? key, required this.items}) : super(key: key);
  final Map<String, CartItem> items;
  @override
  State<MainDrawerScreen> createState() => _MainDrawerScreenState(items);
}

class _MainDrawerScreenState extends State<MainDrawerScreen> {
  final Map<String, CartItem> items;
  final Uri _url = Uri.parse('https://sadqapakistan.org/contact');
  GoogleSignInAccount? googleAccount;
  var _googleSignIn = GoogleSignIn();
  var navigationService = locator<NavigationService>();
  _MainDrawerScreenState(this.items);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.08),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          bottomOpacity: 0,
          automaticallyImplyLeading: false,

          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: height * 0.065,
                fit: BoxFit.cover,
              ),
            ],
          ),

          actions: [
            IconButton(
                onPressed: () {
                 Navigator.pop(context,items);
                },
                icon: Image.asset(
                  "assets/images/cross.png",
                  height: height * 0.03,
                ))
          ],
          // leading: IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.arrow_back_ios,
          //       color: Colors.black,
          //       size: width * 0.04,
          //     ))
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: width * 0.1, right: width * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            GestureDetector(
              onTap: (){
                print(items.length);
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder:
                          (BuildContext context) =>
                          HomeScreen(items)),
                );
              },
              child: Text(
                'Home',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.black,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder:
                          (BuildContext context) =>
                          MyOrderScreen()),
                );
              },
              child: Text(
                'My Orders',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.black,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder:
                          (BuildContext context) =>
                          ChangePasswordScreen()),
                );
              },
              child: Text(
                'Change Password',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.black,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            GestureDetector(
              onTap: (){

                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder:
                          (BuildContext context) =>
                          ContactInfoScrreen()),
                );
              },
              child: Text(
                'My Contact Information',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.black,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder:
                          (BuildContext context) =>
                          BillingAddressScreen()),
                );
              },
              child: Text(
                'My Billing Address',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.black,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            GestureDetector(
              onTap: (){
                Share.share('Hi, I recommend SadqaPakistan.pk for supporting social uplift and reducing malnutrition in Pakistan. You can download their app using the following link   https://play.google.com/store/apps/details?id=com.example.sadqapakistan');
              },
              child: Text(
                'Invite Friends',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.black,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder:
                          (BuildContext context) =>
                          Privacy()),
                );
              },
              child: Text(
                'Privacy Policy',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.black,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            GestureDetector(
              onTap: _launchUrl,
              // onTap: () async {
              //   var url = "https://www.sadqapakistan.pk/";
              //   await launchUrl(Uri.parse(url));
              // },
              child: Text(
                'Contact Us',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.black,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            GestureDetector(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('id');
                await prefs.remove('email');
                await prefs.remove('username');
                googleAccount = await _googleSignIn.signOut();
                Navigator.pushAndRemoveUntil<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => loginScreen(),
                  ),
                      (route) => false,//if you want to disable back feature set to false
                );


                // Provider.of<LoginController>(context, listen: false)
                //     .logOut();
              },
              child: Text(
                'Logout',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
