import 'package:flutter/material.dart';
import 'package:store/src/features/request/bloc.dart';

class RequestProvider extends InheritedWidget {
  const RequestProvider({
    Key? key,
    required Widget child,
    required this.bloc,
  }) : super(key: key, child: child);

  final RequestBloc bloc;

  static RequestProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RequestProvider>();
  }

  @override
  bool updateShouldNotify(RequestProvider oldWidget) {
    return bloc != oldWidget.bloc;
  }
}
