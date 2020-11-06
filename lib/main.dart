import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:emergencyhealthcare/app/locator.dart';
import 'package:emergencyhealthcare/constants.dart';
import 'package:emergencyhealthcare/ui/views/splash/splash_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/router.gr.dart' as r;

Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Emergency Healthcare',
      theme: ThemeData(
        // primarySwatch: kPrimaryColor,
        primaryColor: kPrimaryColor,
        accentColor: kAccentColor,
      ),
      home: SplashView(),
      builder: ExtendedNavigator.builder(
        router: r.Router(),
        initialRoute: r.Routes.splashView,
        navigatorKey: locator<NavigationService>().navigatorKey,
      ),
    );
  }
}
