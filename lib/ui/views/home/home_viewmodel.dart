import 'package:emergencyhealthcare/app/locator.dart';
import 'package:emergencyhealthcare/app/router.gr.dart';
import 'package:emergencyhealthcare/app/services/authentication_service.dart';
import 'package:emergencyhealthcare/ui/views/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  final NavigationService _navigationService = locator<NavigationService>();

  Position _currentPosition;
  Geolocator _geolocator = Geolocator()..forceAndroidLocationManager;

  MapController _controller = MapController(location: LatLng(35.68, 51.41));
  MapController get controller => _controller;

  void getCurrentLocation() {
    _geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      _currentPosition = position;
      _controller = MapController(
          location:
              LatLng(_currentPosition.latitude, _currentPosition.longitude));
      notifyListeners();
    }).catchError((e) {
      print(e);
    });
  }

  void gotoDefault() {
    _controller.center =
        LatLng(_currentPosition.latitude, _currentPosition.longitude);
    notifyListeners();
  }

  void onDoubleTap() {
    _controller.zoom += 0.5;
    notifyListeners();
  }

  Offset _dragStart;
  double _scaleStart = 1.0;
  void onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      controller.zoom += 0.02;
    } else if (scaleDiff < 0) {
      controller.zoom -= 0.02;
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart;
      _dragStart = now;
      controller.drag(diff.dx, diff.dy);
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await _authenticationService.logout();
    onNavigateToSplashView();
  }

  onNavigateToSplashView() async {
    await _navigationService.clearStackAndShow(Routes.splashView);
  }

  onNavigateToSearchView() async {
    await _navigationService.navigateWithTransition(
      SearchView(),
      transition: 'rightToLeft',
    );
  }
}
