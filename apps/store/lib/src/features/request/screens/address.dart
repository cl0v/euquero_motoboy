import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:store/src/features/history/controller.dart';
import 'package:store/src/features/history/provider.dart';
import 'package:store/src/features/history/view.dart';
import 'package:store/src/features/request/bloc.dart';
import 'package:store/src/features/request/provider.dart';
import 'package:store/src/features/request/states.dart';

//TODO: Validar os campos garantindo que não possa daixá-los vazio.
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
          actions: [
            TextButton.icon(
                onPressed: () {
                  push(
                      context,
                      HistoryProvider(
                          child: HistoryPage(),
                          controller: HistoryController(
                            repository: bloc.repository,
                          )));
                },
                icon: Icon(Icons.payment),
                label: Text('Histórico'))
          ],
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
                        textInputAction: TextInputAction.next,
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
                        textInputAction: TextInputAction.next,
                        controller: addressNumberController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFieldWidget(
                  labelText: 'Bairro',
                  controller: addressBairroController,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFieldWidget(
                  labelText: 'Referência (Opcional)',
                  textInputAction: TextInputAction.done,
                  controller: addressReferenceController,
                ),
              ],
            ),
          ),
        ));
  }
}
