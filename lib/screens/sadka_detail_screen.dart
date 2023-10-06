import 'package:flutter/material.dart';

import '../services/navigation_service.dart';
import '../utils/routes.dart';
import '../utils/service_locator.dart';

class SadkaDetailScreen extends StatefulWidget {
  const SadkaDetailScreen({Key? key}) : super(key: key);

  @override
  State<SadkaDetailScreen> createState() => _SadkaDetailScreenState();
}

class _SadkaDetailScreenState extends State<SadkaDetailScreen> {
  var navigationService = locator<NavigationService>();
  Color themeColor = const Color.fromRGBO(36, 124, 38, 1);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: themeColor,
        appBar: AppBar(
            // toolbarHeight: 0,
            // systemOverlayStyle: const SystemUiOverlayStyle(
            //   // Status bar color
            //   statusBarColor: Colors.transparent,

            //   // Status bar brightness (optional)
            //   statusBarIconBrightness:
            //       Brightness.dark, // For Android (dark icons)
            //   statusBarBrightness: Brightness.light, // For iOS (dark icons)
            // ),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            bottomOpacity: 0,
            title: Text(
              "Details",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.w700),
            ),
            leading: Padding(
              padding: EdgeInsets.only(left: width * 0.03),
              child: IconButton(
                  onPressed: () {
                    navigationService.navigateTo(homeScreenRoute);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: width * 0.035,
                  )),
            )),
        body: Padding(
          padding: EdgeInsets.only(
              left: width * 0.05, right: width * 0.05, top: height * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(width * 0.02)),
                    color: Colors.white),
                width: width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: width * 0.1),
                        child: Image.asset(
                          "assets/images/buffalo.png",
                          fit: BoxFit.cover,
                          height: height * 0.18,
                          // width: width * 0.2,
                        ),
                      ),
                      Text(
                        "Medium Katta",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.007, bottom: height * 0.01),
                        child: Text(
                          "Rs. 58,500",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: width * 0.035,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        "70-85 kg meat",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.032,
                          // fontWeight: FontWeight.w700
                        ),
                      ),
                      Text(
                        "Fees around 110 families",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.032,
                          // fontWeight: FontWeight.w700
                        ),
                      ),
                      Text(
                        "Great value for money",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.032,
                          // fontWeight: FontWeight.w700
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                    ]),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      // width: 5.0,
                      color: Colors.white,
                    ),
                    minimumSize: Size.fromHeight(
                        MediaQuery.of(context).size.height * 0.052),
                    primary: const Color.fromRGBO(247, 185, 20, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.02),
                    ),
                  ),
                  onPressed: () {
                    navigationService.navigateTo(viewCartScreenRoute);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.022,
                        bottom: MediaQuery.of(context).size.height * 0.022),
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                      ),
                    ),
                  ))

              // ButtonWidget(
              //   onTap: () {
              //     navigationService.navigateTo(viewCartScreenRoute);
              //   },
              //   borderColor: const Color.fromRGBO(247, 185, 20, 1),
              //   text: "Add to Cart",
              //   textColor: Colors.white,
              //   buttonColor: const Color.fromRGBO(247, 185, 20, 1),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
