import 'package:emergencyhealthcare/app/locator.dart';
import 'package:emergencyhealthcare/app/router.gr.dart';
import 'package:emergencyhealthcare/app/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  onNavigateToLoginView() async {
    await _navigationService.navigateTo(Routes.loginView);
  }

  onNavigateToSignupView() async {
    await _navigationService.navigateTo(Routes.signupView);
  }

  onNavigateToMainView() async {
    await _navigationService.clearStackAndShow(Routes.homeView);
  }

  initializeLocalNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  autoLogin() async {
    var user = await _authenticationService.getCurrentUser();
    if (user != null) {
      onNavigateToMainView();
    }
  }
}
