import 'package:emergencyhealthcare/app/locator.dart';
import 'package:emergencyhealthcare/app/router.gr.dart';
import 'package:emergencyhealthcare/app/services/authentication_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  String _password;
  set password(value) {
    _password = value;
  }

  String _email;
  set email(value) {
    _email = value;
  }

  Future login() async {
    setBusy(true);
    var result = await _authenticationService.loginWithEmail(
        email: _email, password: _password);
    setBusy(false);
    if (result is bool) {
      if (result) {
        onNavigateToHomeView();
      } else {
        await _dialogService.showDialog(
          title: 'Login Failure',
          description: 'General Login failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: result,
      );
    }
  }

  onNavigateToHomeView() async {
    await _navigationService.clearStackAndShow(Routes.homeView);
  }

  onNavigateToSignupView() async {
    await _navigationService.replaceWith(Routes.signupView);
  }
}
