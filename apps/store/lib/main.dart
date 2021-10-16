import 'package:authenticator/authenticator.dart';
import 'package:dependences/dependences.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:store/src/features/request/bloc.dart';
import 'package:store/src/features/request/provider.dart';

import 'src/features/request/repository.dart';
import 'src/features/request/view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motoboy',
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      theme: lightTheme,
      home: AuthenticationPage(onLogin: (String id) async {

        final RequestRepository repository = RequestRepository();
        final store = await repository.get(id);
        
        return RequestProvider(
          child: const RequestPage(),
          bloc: RequestBloc(
            store: store,
            repository: repository,
          ),
        );
      }),
    );
  }
}
