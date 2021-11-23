import 'package:admin/src/pages/registration/controller.dart';
import 'package:admin/src/pages/registration/provider.dart';
import 'package:admin/src/pages/registration/state.dart';
import 'package:flutter/material.dart';

import 'screens/motoboy.dart';
import 'screens/store.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final RegistrationController controller;
  @override
  void didChangeDependencies() {
    controller = RegistrationProvider.of(context)!.controller;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RegistrationState>(
      stream: controller.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return _StateHandlerWidget(snapshot.data!, controller);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _StateHandlerWidget extends StatelessWidget {
  const _StateHandlerWidget(this.state, this.controller, {Key? key})
      : super(key: key);
  final RegistrationState state;
  final RegistrationController controller;
  @override
  Widget build(BuildContext context) {
    switch (state) {
      case RegistrationState.motoboy:
        return const FormularioCadastroMotoboy();
      case RegistrationState.store:
        return const FormularioCadastroLoja();
      case RegistrationState.sucess:
      //TODO: Implement Sucess Screen
      default:
        return const Scaffold(
            body: Center(
          child: Text('Error desconhecido!'),
        ));
    }
  }
}
