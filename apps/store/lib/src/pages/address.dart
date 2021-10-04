import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:store/src/pages/price.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final TextEditingController addressNumberController = TextEditingController();

  final TextEditingController addressStreetController = TextEditingController();

  final TextEditingController addressBairroController = TextEditingController();

  final TextEditingController addressReferenceController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Para onde?'),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavButton(
          'Próximo',
          () {
            push(context, const PricesPage());
          },
        ),
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFieldWidget(
                        labelText: 'Rua',
                        controller: addressStreetController,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFieldWidget(
                        labelText: 'Número',
                        controller: addressNumberController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFieldWidget(
                    labelText: 'Bairro', controller: addressBairroController),
                const SizedBox(
                  height: 8,
                ),
                TextFieldWidget(
                    labelText: 'Referência (Opcional)',
                    controller: addressReferenceController),
              ],
            ),
          ),
        ));
  }
}
