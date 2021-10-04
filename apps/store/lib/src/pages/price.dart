import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:store/src/pages/total.dart';

class PricesPage extends StatefulWidget {
  const PricesPage({Key? key}) : super(key: key);

  @override
  _PricesPageState createState() => _PricesPageState();
}

class _PricesPageState extends State<PricesPage> {
  final TextEditingController valorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quanto cobrar?'),
        centerTitle: true,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: TextFieldWidget(
            labelText: 'Valor',
            controller: valorController,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavButton('Próximo', () {
        push(context, const TotalPage());
      }),
    );
  }
}
