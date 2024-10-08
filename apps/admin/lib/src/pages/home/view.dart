import 'package:admin/src/pages/pendent_registrations/motoboy.dart';
import 'package:admin/src/pages/pendent_registrations/store.dart';
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
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Text('Cambuquira'),
                  Text('Marcelo Fernandes')
                ],
              ),
            ),
            ListTile(
              title: const Text('Motoboys pendentes'),
              onTap: () {
                push(
                  context,
                  PendentMotoboyRegistrationsPage(id: widget.repository.id),
                );
              },
            ),
            ListTile(
              title: const Text('Lojas pendentes'),
              onTap: () {
                push(
                  context,
                  PendentStoreRegistrationsPage(id: widget.repository.id),
                );
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
            onPressed: () async {},
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
                  future: Future.value([]),
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
