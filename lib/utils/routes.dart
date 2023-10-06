import 'package:flutter/material.dart';

import '../screens/checkout_screen.dart';
import '../screens/contact_info_screen.dart';

import '../screens/intro_screen.dart';
import '../screens/jazakAllah_screen.dart';
import '../screens/login_screen.dart';
import '../screens/main_drawer_scree.dart';
import '../screens/payment_method_screen.dart';

import '../screens/sadka_detail_screen.dart';
import '../screens/select_account_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/group_sadka_detail_screen.dart';
import '../screens/view_cart_screen.dart';

const homeScreenRoute = '/home-screen';
const splashScreenRoute = '/splash-screen';
const optionsDetailScreenRoute = '/options-detail-screen';
const viewCartScreenRoute = '/view-cart-screen';
const contactInfoScreenRoute = '/contact-info-screen';
const checkOutScreenRoute = '/checkout-screen';
const jazakAllahScreenRoute = '/jazak-allah-screen';
const paymentMethodScreenRoute = '/payment-method-screen';
const loginScreenRoute = '/login-screen';
const walkThroughScreenRoute = '/walk-through-screen';
const signupScreenRoute = '/signup-screen';
const sadkaDetailScreenRoute = '/sadka-detail-screen';
const selectAccountScreenRoute = '/select-acccount-screen';
const mainDrawerScreenRoute = '/main-drawer-screen';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case loginScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const loginScreen());
    case signupScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const SignupScreen());
    case selectAccountScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => SelectAccountScreen());

    case walkThroughScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => WAWalkThroughScreen());
    case sadkaDetailScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const SadkaDetailScreen());
    // case viewCartScreenRoute:
    //   return MaterialPageRoute(
    //       builder: (BuildContext context) => const ViewCartScreen());
    // case homeScreenRoute:
    //   return MaterialPageRoute(
    //       builder: (BuildContext context) => const HomeScreen());
    // case mainDrawerScreenRoute:
    //   return MaterialPageRoute(
    //       builder: (BuildContext context) => const MainDrawerScreen());
    // case checkOutScreenRoute:
    //   return MaterialPageRoute(
    //       builder: (BuildContext context) => const CheckOutScreen());
    case contactInfoScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const ContactInfoScrreen());
    // case viewCartScreenRoute:
    //   return MaterialPageRoute(
    //       builder: (BuildContext context) => const ViewCartScreen());
    case splashScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => const SplashScreen());
    // case optionsDetailScreenRoute:
      // return MaterialPageRoute(
      //     builder: (BuildContext context) => const OptionsDetailScreen());

    // case jazakAllahScreenRoute:
    //   return MaterialPageRoute(
    //       builder: (BuildContext context) => const JazakAllahScreen());
    // case paymentMethodScreenRoute:
    //   return MaterialPageRoute(
    //       builder: (BuildContext context) => const PaymentMethodScreen());

    default:
      return MaterialPageRoute(
          builder: (BuildContext context) =>  HomeScreen({}));
  }
}
