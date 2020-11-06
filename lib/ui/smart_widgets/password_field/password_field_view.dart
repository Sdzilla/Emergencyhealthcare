import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:emergencyhealthcare/constants.dart';
import 'package:emergencyhealthcare/ui/smart_widgets/password_field/password_field_viewmodel.dart';
import 'package:emergencyhealthcare/ui/widgets/text_field_container.dart';
import 'package:stacked/stacked.dart';

class PasswordFieldView extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const PasswordFieldView({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PasswordFieldViewModel>.reactive(
      builder: (context, model, child) => TextFieldContainer(
        child: TextField(
          obscureText: model.isVisible,
          onChanged: onChanged,
          cursorColor: kPrimaryColor,
          style: GoogleFonts.lato(),
          decoration: InputDecoration(
            hintText: "Password",
            hintStyle: GoogleFonts.lato(),
            icon: Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            suffixIcon: GestureDetector(
              child: Icon(
                model.icon,
                color: kPrimaryColor,
              ),
              onTap: () => model.toggleVisibility(),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
      viewModelBuilder: () => PasswordFieldViewModel(),
    );
  }
}
