import 'package:flutter/material.dart';

class Provider<T> extends InheritedWidget {
  const Provider({
    Key? key,
    required Widget child,
    required this.bloc,
  }) : super(key: key, child: child);

  final T bloc;

  static Provider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>();
  }

  @override
  bool updateShouldNotify(Provider<T> oldWidget) {
    return oldWidget.bloc != bloc;
  }
}

class BlocProvider<T> extends StatefulWidget {
  const BlocProvider({
    Key? key,
    required this.child,
    required this.builder,
    required this.onDispose,
  }) : super(key: key);

  final void Function(BuildContext context, T bloc) onDispose;
  final T Function(BuildContext context, T bloc) builder;
  final Widget child;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();
}

class _BlocProviderState<T> extends State<BlocProvider<T>> {
  late T bloc;

  @override
  void initState() {
    bloc = widget.builder(context, bloc);
    super.initState();
  }

  @override
  void dispose() {
    widget.onDispose(context, bloc);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      bloc: bloc,
      child: widget.child,
    );
  }
}
