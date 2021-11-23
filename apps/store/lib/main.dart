import 'package:authenticator/authenticator.dart';
import 'package:core/core.dart';
import 'package:dependences/dependences.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:store/src/features/request/bloc.dart';
import 'package:store/src/features/request/provider.dart';

import 'src/features/request/repository.dart';
import 'src/features/request/view.dart';
import 'src/pages/register/view.dart';

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
      home: AuthenticationPage(
          onCreate: () async => const FormularioCadastroLoja(),
          onLogin: (String id) async {
            try {
              final StoreOrderInfo store = await RequestRepository.get(id);
              //TODO: Tratar possíveis erros

              final RequestRepository repository = RequestRepository(
                uid: store.id,
              );

              return RequestProvider(
                child: const RequestPage(),
                bloc: RequestBloc(
                  store: store,
                  repository: repository,
                ),
              );
            } catch (e) {
              return Scaffold(
                backgroundColor: Colors.green[300],
                body: const Center(
                  child: Text('Cadastro criado..\nEsperando aprovação.',
                      style: TextStyle(fontSize: 32)),
                ),
              );
            }
          }),
    );
  }
}
