import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emergencyhealthcare/constants.dart';
import 'package:emergencyhealthcare/ui/views/splash/splash_viewmodel.dart';
import 'package:emergencyhealthcare/ui/widgets/rounded_button.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<SplashViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        body: Container(
          height: size.height,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_top.png",
                  width: size.width * 0.3,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_bottom.png",
                  width: size.width * 0.2,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "WELCOME TO\nEMERGENCY HEALTHCARE",
                      textAlign: TextAlign.center,
                      style: kFont(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.05),
                    SvgPicture.asset(
                      "assets/icons/chat.svg",
                      height: size.height * 0.45,
                    ),
                    SizedBox(height: size.height * 0.05),
                    RoundedButton(
                      text: "LOGIN",
                      press: model.onNavigateToLoginView,
                    ),
                    RoundedButton(
                      text: "SIGN UP",
                      color: kPrimaryLightColor,
                      textColor: Colors.black,
                      press: model.onNavigateToSignupView,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onModelReady: (model) {
        model.initializeLocalNotification();
        model.autoLogin();
      },
      viewModelBuilder: () => SplashViewModel(),
    );
  }
}
