import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:store/src/features/request/states.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../bloc.dart';
import '../provider.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({Key? key}) : super(key: key);

  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  late final RequestBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = RequestProvider.of(context)!.bloc;
    super.didChangeDependencies();
  }

  bool tapped = false;

  onRequestDelivery() async {
    setState(() {
      tapped = true;
    });
    final Address address = bloc.address;
    bloc.client = ClientModel(
      name: nameController.text,
      phone: phoneController.text,
      address: address,
    );

    await bloc.requestDelivery();

    bloc.add(RequestState.sucess);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: tapped,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dados do cliente'),
          centerTitle: true,
        ),
        bottomNavigationBar:
            BottomNavButton('Solicitar entrega', onRequestDelivery),
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFieldWidget(
                labelText: 'Nome',
                controller: nameController,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                labelText: 'Tefone',
                controller: phoneController,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
