import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:emergencyhealthcare/constants.dart';
import 'package:emergencyhealthcare/ui/views/signup/signup_viewmodel.dart';
import 'package:emergencyhealthcare/ui/widgets/already_have_an_account_acheck.dart';
import 'package:emergencyhealthcare/ui/widgets/rounded_button.dart';
import 'package:emergencyhealthcare/ui/widgets/rounded_input_field.dart';
import 'package:emergencyhealthcare/ui/smart_widgets/password_field/password_field_view.dart';
import 'package:emergencyhealthcare/ui/widgets/social_icon.dart';
import 'package:stacked/stacked.dart';

class SignupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<SignUpViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Container(
          height: size.height,
          width: double.infinity,
          // Here i can use size.width but use double.infinity because both work as a same
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/signup_top.png",
                  width: size.width * 0.35,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  "assets/images/main_bottom.png",
                  width: size.width * 0.20,
                  color: kPrimaryColor.withOpacity(0.5),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 70),
                    Text(
                      "SIGNUP",
                      style: kFont(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.03),
                    SvgPicture.asset(
                      "assets/icons/signup.svg",
                      height: size.height * 0.35,
                    ),
                    RoundedInputField(
                      hintText: "Your Name",
                      onChanged: (value) {
                        model.name = value;
                      },
                    ),
                    RoundedInputField(
                      hintText: "Your Address",
                      icon: Icons.map,
                      onChanged: (value) {
                        model.address = value;
                      },
                    ),
                    RoundedInputField(
                      hintText: "Your Phone",
                      icon: Icons.phone,
                      onChanged: (value) {
                        model.phone = value;
                      },
                    ),
                    RoundedInputField(
                      hintText: "Your Email",
                      icon: Icons.email,
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
                      text: "SIGNUP",
                      press: () {
                        FirebaseAuth _auth = FirebaseAuth.instance;
                        _auth.verifyPhoneNumber(
                          phoneNumber: model.phone,
                          timeout: Duration(seconds: 60),
                          verificationCompleted: (credential) async {
                            Navigator.of(context).pop();
                            UserCredential result =
                                await _auth.signInWithCredential(credential);
                            User user = result.user;

                            if (user != null) {
                              model.onNavigateToHomeView();
                            }
                          },
                          verificationFailed: (exception) {
                            print(exception);
                          },
                          codeSent: (verificationId, forceResendingToken) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Give the code?'),
                                  content: TextField(
                                      controller: model.codeController),
                                  actions: [
                                    FlatButton(
                                      onPressed: () async {
                                        final code =
                                            model.codeController.text.trim();
                                        AuthCredential credential =
                                            PhoneAuthProvider.credential(
                                          verificationId: verificationId,
                                          smsCode: code,
                                        );
                                        var result = await _auth
                                            .signInWithCredential(credential);
                                        User user = result.user;
                                        if (user != null) {
                                          model.addToUserDatabase();
                                          model.onNavigateToHomeView();
                                        } else {
                                          print('error');
                                        }
                                      },
                                      child: Text('Confirm'),
                                      textColor: Colors.white,
                                      color: Colors.blue,
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          codeAutoRetrievalTimeout: (verificationId) {},
                        );
                      },
                    ),
                    SizedBox(height: size.height * 0.03),
                    AlreadyHaveAnAccountCheck(
                      login: false,
                      press: model.onNavigateToLoginView,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: size.height * 0.02),
                      width: size.width * 0.8,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Divider(
                              color: Color(0xFFD9D9D9),
                              height: 1.5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "OR",
                              style: kFont(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Color(0xFFD9D9D9),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SocalIcon(
                          iconSrc: "assets/icons/facebook.svg",
                          press: () {},
                        ),
                        SocalIcon(
                          iconSrc: "assets/icons/twitter.svg",
                          press: () {},
                        ),
                        SocalIcon(
                          iconSrc: "assets/icons/google-plus.svg",
                          press: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 70),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}
