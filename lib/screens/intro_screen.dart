import 'package:flutter/material.dart';
import 'package:sadqapak/screens/select_account_screen.dart';
import 'package:sadqapak/utils/routes.dart';
import '../models/walkthrought.dart';
import '../services/navigation_service.dart';
import '../services/storage_service.dart';
import '../utils/service_locator.dart';

// import 'package:nb_utils/nb_utils.dart';
// import 'package:wallet_flutter/model/WalletAppModel.dart';
// import 'package:wallet_flutter/screen/WALoginScreen.dart';
// import 'package:wallet_flutter/utils/WAColors.dart';
// import 'package:wallet_flutter/utils/WADataGenerator.dart';

class WAWalkThroughScreen extends StatefulWidget {
  static String tag = '/WAWalkThroughScreen';

  @override
  WAWalkThroughScreenState createState() => WAWalkThroughScreenState();
}

List<WAWalkThroughModel> waWalkThroughList() {
  List<WAWalkThroughModel> list = [];
  list.add(WAWalkThroughModel(
      title: "",
      description:
          "Our vision is to eliminate chronic malnutrition in Pakistan through innovative ways of social entrepreneurship",
      image: 'assets/images/intro1.png'));
  // list.add(WAWalkThroughModel(
  //     title: "",
  //     description:
  //         "Charity (Sadqa) extinguishes sin, just as water extinguishes fire",
  //     image: 'assets/images/intro2.png'));
  // list.add(WAWalkThroughModel(
  //     title: "",
  //     description:
  //         "\“The example of those who spend their wealth in the way of Allah is like seed of grain which grows seven spikes, in each spike is a hundred grains. And Allah multiplies His reward for whom He wills\”",
  //     image: 'assets/images/intro3.png'));

  return list;
}

class WAWalkThroughScreenState extends State<WAWalkThroughScreen> {
  PageController pageController = PageController();
  List<WAWalkThroughModel> list = waWalkThroughList();
  var navigationService = locator<NavigationService>();
  StorageService? storageService = locator<StorageService>();

  int currentPage = 0;

  @override
  void initState() {
    this.storageService!.setBoolData('isSeen', true);
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          // extendBodyBehindAppBar: true,
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          //   automaticallyImplyLeading: false,
          //   elevation: 0,
          //   actions: [
          //     InkWell(
          //         onTap: () {
          //           navigationService.navigateTo(loginScreenRoute);
          //         },
          //         child: Padding(
          //           padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
          //           child: Text(
          //             "Skip",
          //             style: TextStyle(
          //                 color: Theme.of(context).colorScheme.secondary,
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: width * 0.05),
          //           ),
          //         ))
          //   ],
          // ),
          backgroundColor: Colors.white,
          body: Container(
              // width: context.width(),
              // height: context.height(),
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.8,
                  width: double.infinity,
                  child: PageView(
                    controller: pageController,
                    children: list.map((e) {
                      return Container(
                        padding: EdgeInsets.only(
                            left: width * 0.01, right: width * 0.01),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                e.image!,
                                fit: BoxFit.cover,
                                // width: width * 0.2,
                                height: currentPage != 1
                                    ? height * 0.6
                                    : height * 0.5,
                              ),
                              Text(e.title!,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.03)),
                              SizedBox(
                                height: height * 0.02,
                              ),
                            ]),
                      );
                    }).toList(),
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                SizedBox(height: height * 0.02),
                InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) => SelectAccountScreen(),
                        ),
                            (route) => false,//if you want to disable back feature set to false
                      );
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.035),
                    )),
                SizedBox(height: height * 0.02),
                // InkWell(
                //     onTap: () {
                //       if (currentPage == 2) {
                //         navigationService.navigateTo(loginScreenRoute);
                //       } else {
                //         pageController.animateToPage(currentPage + 1,
                //             duration: Duration(milliseconds: 300),
                //             curve: Curves.linear);
                //       }
                //     },
                //     child:
                Padding(
                    padding:
                        EdgeInsets.only(left: width * 0.1, right: width * 0.1),
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
                          Navigator.pushAndRemoveUntil<dynamic>(
                            context,
                            MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) => SelectAccountScreen(),
                            ),
                                (route) => false,//if you want to disable back feature set to false
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.022,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.022),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                            ),
                          ),
                        ))

                    //  ButtonWidget(
                    //   text: 'Next',
                    //   textColor: Colors.white,
                    //   buttonColor: Theme.of(context).primaryColor,
                    //   onTap: () {
                    //     if (currentPage == 2) {
                    //       navigationService.navigateTo(loginScreenRoute);
                    //     } else {
                    //       pageController.animateToPage(currentPage + 1,
                    //           duration: Duration(milliseconds: 300),
                    //           curve: Curves.linear);
                    //     }
                    //   },
                    // ),
                    )

                // Container(
                //   height: 60,
                //   width: 60,
                //   padding: EdgeInsets.all(18),
                //   decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       color: Theme.of(context).colorScheme.secondary),
                //   child: Image.asset('assets/images/wa_navigate_next.png',
                //       color: Colors.white,
                //       height: 14,
                //       width: 14,
                //       fit: BoxFit.cover),
                // ))
              ],
            ),
          ))),
    );
  }

  Widget _indicator(bool isActive) {
    return Container(
      height: 10,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          boxShadow: [
            isActive
                ? BoxShadow(
                    color: Theme.of(context).primaryColor,
                    blurRadius: 2.0,
                    spreadRadius: 1.0,
                    offset: Offset(
                      0.0,
                      0.0,
                    ),
                  )
                : BoxShadow(
                    color: Theme.of(context).primaryColor,
                  )
          ],
          shape: BoxShape.circle,
          color: isActive ? Theme.of(context).primaryColor : Colors.grey,
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < 1; i++) {
      list.add(i == currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }
}
