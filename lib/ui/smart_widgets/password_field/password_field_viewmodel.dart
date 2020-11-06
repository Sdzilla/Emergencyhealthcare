import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PasswordFieldViewModel extends BaseViewModel {
  bool _isVisible = true;
  bool get isVisible => _isVisible;

  IconData _icon = Icons.visibility;
  IconData get icon => _icon;

  void toggleVisibility() {
    _isVisible = !_isVisible;
    _isVisible ? _icon = Icons.visibility : _icon = Icons.visibility_off;
    notifyListeners();
  }
}
