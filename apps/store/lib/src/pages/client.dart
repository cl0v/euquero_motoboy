import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({Key? key}) : super(key: key);

  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados do cliente'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavButton('Solicitar entrega', () {
         // TODO: Implementar
      }),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFieldWidget(labelText: 'Nome', controller: nameController),
            const SizedBox(height: 8,),
            TextFieldWidget(labelText: 'Tefone', controller: phoneController),
          ],
        ),
      ),
    );
  }
}
