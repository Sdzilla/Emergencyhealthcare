import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emergencyhealthcare/constants.dart';
import 'package:emergencyhealthcare/ui/smart_widgets/password_field/password_field_view.dart';
import 'package:emergencyhealthcare/ui/views/login/login_viewmodel.dart';
import 'package:emergencyhealthcare/ui/widgets/already_have_an_account_acheck.dart';
import 'package:emergencyhealthcare/ui/widgets/rounded_button.dart';
import 'package:emergencyhealthcare/ui/widgets/rounded_input_field.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Container(
          width: double.infinity,
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_top.png",
                  width: size.width * 0.35,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  "assets/images/login_bottom.png",
                  width: size.width * 0.4,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "LOGIN",
                      style: kFont(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.03),
                    SvgPicture.asset(
                      "assets/icons/login.svg",
                      height: size.height * 0.35,
                    ),
                    SizedBox(height: size.height * 0.03),
                    RoundedInputField(
                      hintText: "Your Email",
                      onChanged: (value) {
                        model.email = value;
                      },
                    ),
                    PasswordFieldView(
                      onChanged: (value) {
                        model.password = value;
                      },
                    ),
                    RoundedButton(
                      text: "LOGIN",
                      press: model.onNavigateToHomeView(),
                    ),
                    SizedBox(height: size.height * 0.03),
                    AlreadyHaveAnAccountCheck(
                      press: model.onNavigateToSignupView,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
