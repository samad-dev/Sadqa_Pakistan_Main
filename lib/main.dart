// import 'package:device_preview/device_preview.dart';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sadqapak/providers/group_sadqa_provider.dart';
import 'package:sadqapak/providers/theme_provider.dart';
import 'package:sadqapak/screens/login_screen.dart';

import './services/navigation_service.dart';
import './utils/service_locator.dart';
import 'firebase_options.dart';
import 'utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('Initialized default app $app');
  HttpOverrides.global = MyHttpOverrides();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  setupLocator();
  runApp(
    // DevicePreview(
    // enabled: !kReleaseMode,
    // builder: (context) =>

    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => GroupSadkaProvider()),
    ], child: const MyApp()),
    // )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(480, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
      title: 'Sadqa Pakistan',

      // color: Theme.of(context).backgroundColor,
      debugShowCheckedModeBanner: false,
      // locale: DevicePreview.locale(context),

      navigatorKey: locator<NavigationService>().navigatorKey,
      color: const Color.fromRGBO(36, 124, 38, 1),
      darkTheme: MyThemes.darkTheme,
      theme: MyThemes.lightTheme,
      onGenerateRoute: onGenerateRoute,
      initialRoute: splashScreenRoute,
    );
  }
}
