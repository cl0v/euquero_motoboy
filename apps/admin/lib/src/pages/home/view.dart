import 'package:admin/src/pages/registration/controller.dart';
import 'package:admin/src/pages/registration/provider.dart';
import 'package:admin/src/pages/registration/state.dart';
import 'package:admin/src/pages/registration/view.dart';
import 'package:admin/src/repository.dart';
import 'package:authenticator/authenticator.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Repository repository;
  const HomePage({
    Key? key,
    required this.repository,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Bem vindo'),
            ),
            ListTile(
              title: const Text('Cadastrar Motoboy'),
              onTap: () {
                push(
                  context,
                  RegistrationProvider(
                    child: const RegistrationPage(),
                    controller: RegistrationController(
                      repository: widget.repository,
                      state: RegistrationState.motoboy,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Cadastrar Loja'),
              onTap: () {
                push(context, RegistrationProvider(
                    child: const RegistrationPage(),
                    controller: RegistrationController(
                      repository: widget.repository,
                      state: RegistrationState.store,
                    ),
                  ),);
              },
            ),
            ListTile(
              title: const Text('Sair'),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.red,
            height: 100,
            width: 200,
            child: Center(
              child: FutureBuilder<List<Order>>(
                  future:  Future.value([]),
                  // /widget.repository.orders(index)
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text('${snapshot.data?.length}');
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
