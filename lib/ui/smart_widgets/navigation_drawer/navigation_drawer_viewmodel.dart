import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergencyhealthcare/app/locator.dart';
import 'package:emergencyhealthcare/app/router.gr.dart';
import 'package:emergencyhealthcare/app/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NavigationDrawerViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  String _name;
  String get name => _name;
  String _email;
  String get email => _email;

  logout() async {
    await _authenticationService
        .logout()
        .then((value) => _navigationService.navigateTo(Routes.splashView));
  }

  getCurrentUser() async {
    User user = await _authenticationService.getCurrentUser();

    DocumentReference reference =
        FirebaseFirestore.instance.collection('users').doc(user.phoneNumber);
    reference.get().then((value) {
      _email = value.data()['email'];
      _name = value.data()['name'];
      notifyListeners();
    }).catchError((error) => print(error));
  }
}
