import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:store/src/features/request/bloc.dart';
import 'package:store/src/features/request/provider.dart';
import 'package:store/src/features/request/states.dart';
import 'price.dart';

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

  late RequestBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = RequestProvider.of(context)!.bloc;
    super.didChangeDependencies();
  }

  onNext() {
    bloc.address = Address(
      numero: addressNumberController.text,
      rua: addressStreetController.text,
      bairro: addressBairroController.text,
    );
    bloc.add(RequestState.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Para onde?'),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavButton('Próximo', onNext),
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
