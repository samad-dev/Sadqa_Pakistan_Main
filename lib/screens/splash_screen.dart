import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/routes.dart';
import '../services/storage_service.dart';
import '../services/navigation_service.dart';
import '../utils/service_locator.dart';
// import '../widgets/exit_alert_dialog.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var navigationService = locator<NavigationService>();
  var storageService = locator<StorageService>();

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () async {
      try {
// Obtain shared preferences.
        final prefs = await SharedPreferences.getInstance();
        // await Provider.of<ContentProvider>(context, listen: false).getContentByPosition();
        String? id = await prefs.getString('id');
        print(id);
        if(id != null)
          {
            navigationService.navigateTo(homeScreenRoute);
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
          }
        else {
          navigationService.navigateTo(walkThroughScreenRoute);
        }
      } catch (err) {
        navigationService.navigateTo(optionsDetailScreenRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Future<bool> _onBackPressed() {
    //   return showDialog(
    //         context: context,
    //         builder: (context) => ExitAlertDialog(),
    //       ) ??
    //       false;
    // }

    return WillPopScope(
      onWillPop: null,
      child: Stack(
          // fit: StackFit.expand,
          children: <Widget>[
            // Container(
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage('assets/images/01a-Splash.jpg'),
            //         fit: BoxFit.cover),0
            //   ),
            // ),
            Positioned(
                child: Align(
              alignment: FractionalOffset.center,
              child: Image.asset(
                'assets/images/logo.png',
                scale: 2,
              ),
            )),
          ]),
    );
  }
}
