import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergencyhealthcare/app/locator.dart';
import 'package:emergencyhealthcare/app/router.gr.dart';
import 'package:emergencyhealthcare/app/services/authentication_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  TextEditingController _codeControlelr = TextEditingController();
  TextEditingController get codeController => _codeControlelr;

  String _name;
  String get name => _name;
  set name(value) {
    _name = value;
  }

  String _address;
  set address(value) {
    _address = value;
  }

  String _phone;
  String get phone => _phone;
  set phone(value) {
    _phone = value;
  }

  String _password;
  set password(value) {
    _password = value;
  }

  String _email;
  String get email => _email;
  set email(value) {
    _email = value;
  }

  Future signUpWithEmail() async {
    setBusy(true);
    var result = await _authenticationService.signUpWithEmail(
        email: _email, password: _password);
    setBusy(false);
    if (result is bool) {
      if (result) {
        onNavigateToHomeView();
      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failure',
          description: 'General sign up failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: 'result',
      );
    }
  }

  void addToUserDatabase() {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('users');
    reference
        .doc(_phone)
        .set({
          'name': _name,
          'email': _email,
          'address': _address,
          'phone': _phone,
          'timestamp': DateTime.now(),
        })
        .then((value) => print('item added'))
        .catchError((error) => print(error));
  }

  onNavigateToHomeView() async {
    await _navigationService.clearStackAndShow(Routes.homeView);
  }

  onNavigateToLoginView() async {
    await _navigationService.replaceWith(Routes.loginView);
  }
}
