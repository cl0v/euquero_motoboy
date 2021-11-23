import 'package:admin/src/pages/registration/controller.dart';
import 'package:flutter/material.dart';

class RegistrationProvider extends InheritedWidget {
  const RegistrationProvider(
      {Key? key, required Widget child, required this.controller})
      : super(key: key, child: child);

  final RegistrationController controller;

  static RegistrationProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RegistrationProvider>();
  }

  @override
  bool updateShouldNotify(RegistrationProvider oldWidget) {
    return true;
  }
}
