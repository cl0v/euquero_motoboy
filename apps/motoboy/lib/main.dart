import 'package:authenticator/authenticator.dart';
import 'package:design_system/design_system.dart';
import 'package:dependences/dependences.dart';
import 'package:flutter/material.dart';
import 'package:motoboy/src/home/bloc.dart';
import 'package:motoboy/src/repository.dart';

import 'src/home/view.dart';

//TODO: (BUGFIX) Se entrar com email de loja voce pode ter acesso aos pedidos abertos...
// TODO: Validar formulário

//TODO: Tratativa de erros quando o login está incorreto

//TODO(BUGFIX): Usuário não existente sempre fica em tela de carregamento (Possibilidade de entrar com email que não seja motoboy)
///
var phone = "553584633939";
/*
https://medium.com/@sarimk80/flutter-segmented-control-and-tab-bar-in-android-and-ios-a4e227d9fa0a
https://gallery.flutter.dev/#/
*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motoboy',
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      theme: lightTheme,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthenticationPage(
      onTap: (id) async {
        MotoboyRepository repository = MotoboyRepository();
        final motoboy = await repository.get(id);

        return HomePage(
          bloc: HomeBloc(motoboy: motoboy, repository: repository),
        );
      },
    );
  }
}
