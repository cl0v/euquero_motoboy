import 'package:dependences/dependences.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

import 'src/view.dart';

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
      home: const HomePage('XEkD1g7x17bFc2M4JULq6UlwTQl1'),
    );
  }
}
