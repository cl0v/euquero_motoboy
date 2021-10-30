import 'package:authenticator/authenticator.dart';
import 'package:design_system/design_system.dart';
import 'package:dependences/dependences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:motoboy/src/home/bloc.dart';
import 'package:motoboy/src/repository.dart';

import 'src/home/view.dart';

//TODO: (BUGFIX) Se entrar com email de loja voce pode ter acesso aos pedidos abertos...
//TODO: Tratativa de erros quando o login está incorreto
// TODO: Validar formulário

var phone = "553584633939";
/*
https://medium.com/@sarimk80/flutter-segmented-control-and-tab-bar-in-android-and-ios-a4e227d9fa0a
https://gallery.flutter.dev/#/
*/

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  FirebaseMessaging.instance.subscribeToTopic('order').then((value) => print('Deu certo'));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


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
      onLogin: (id) async {
        final motoboy = await MotoboyRepository.get(id);
        MotoboyRepository repository = MotoboyRepository(
          uid: motoboy.id,
          franchiseId: motoboy.franchiseId,
        );
        return HomePage(
          bloc: HomeBloc(motoboy: motoboy, repository: repository),
        );
      },
    );
  }
}
