import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:store/src/bloc.dart';

//TODO : Isolar alguns componentes nessa página

class HomePage extends StatefulWidget {
  const HomePage(this.uid, {Key? key}) : super(key: key);

  final String uid;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController addressNumberController = TextEditingController();

  final TextEditingController addressStreetController = TextEditingController();

  final TextEditingController addressBairroController = TextEditingController();

  final TextEditingController addressReferenceController =
      TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController valorController = TextEditingController();

  late final Bloc bloc;

  @override
  void initState() {
    bloc = Bloc(widget.uid);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  ClientModel get client => ClientModel(
        name: nameController.text,
        phone: phoneController.text,
        address: Address(
          numero: addressNumberController.text,
          rua: addressStreetController.text,
          bairro: addressBairroController.text,
        ),
      );

  double get valor =>
      valorController.text == '' ? 0 : double.parse(valorController.text);

  Order get order => Order(
        valor: valor,
        frete: bloc.frete.valorTotal(0),
        client: client,
        store: bloc.store,
      );

  bool tapped = false;

  onOrder() async {
    setState(() {
      tapped = true;
    });
    await bloc.repository.requestMotoboy(order);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Enviado com sucesso!')));
    _clearFields();
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      tapped = false;
    });
  }

  _clearFields() {
    nameController.clear();
    addressController.clear();
    addressNumberController.clear();
    addressStreetController.clear();
    addressBairroController.clear();
    addressReferenceController.clear();
    phoneController.clear();
    valorController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final fields = [
      TextFieldWidget(labelText: 'Nome', controller: nameController),
      TextFieldWidget(labelText: 'Tefone', controller: phoneController),
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
      TextFieldWidget(labelText: 'Bairro', controller: addressBairroController),
      TextFieldWidget(
          labelText: 'Referência (Opcional)',
          controller: addressReferenceController),
    ];

    final valueFields = [
      TextFieldWidget(
        labelText: 'Valor',
        controller: valorController,
        onChanged: bloc.onChanged,
      ),
      Center(
        child: StreamBuilder<double>(
            stream: bloc.totalValueBloc.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const CircularProgressIndicator();
              }
              return Text('Valor total: ${snapshot.data?.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 22));
            }),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar:
          BottomNavButton('Solicitar entrega', tapped ? null : onOrder),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 8),
        child: Form(
          child: ListView(
            children: [
              ...fields.map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: e,
                ),
              ),
              const Divider(),
              Row(
                children: valueFields
                    .map((e) => Expanded(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: e),
                        ))
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
