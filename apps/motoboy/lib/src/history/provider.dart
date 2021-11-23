import 'package:flutter/material.dart';
import 'package:motoboy/src/history/controller.dart';

class HistoryProvider extends InheritedWidget {
  const HistoryProvider({
    Key? key,
    required Widget child,
    required this. controller,
  }) : super(key: key, child: child);

  final HistoryController controller;

  static HistoryProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<HistoryProvider>();
  }

  @override
  bool updateShouldNotify(HistoryProvider oldWidget) {
    return true;
  }
}
