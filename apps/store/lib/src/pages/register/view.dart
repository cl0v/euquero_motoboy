import 'package:authenticator/authenticator.dart';
import 'package:core/core.dart';
import 'package:dependences/dependences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final franchiseId = kDebugMode
    ? 'SQP3sTEhmDYSLoHPyyrZCKfO0Vc2'
    : 'Yr9vJcaEu8NDDxTD4vRlR2DqLxR2';

class FormularioCadastroLoja extends StatefulWidget {
  const FormularioCadastroLoja({Key? key}) : super(key: key);

  @override
  _FormularioCadastroLojaState createState() => _FormularioCadastroLojaState();
}

class _FormularioCadastroLojaState extends State<FormularioCadastroLoja> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cnpjController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController taxaController = TextEditingController();
  final TextEditingController addressNumberController = TextEditingController();
  final TextEditingController addressStreetController = TextEditingController();
  final TextEditingController addressBairroController = TextEditingController();

  final TextEditingController chavePixController = TextEditingController();
  final TextEditingController bancoPixController = TextEditingController();
  final TextEditingController agenciaPixController = TextEditingController();
  final TextEditingController contaPixController = TextEditingController();

  bool isPix = true;

  DadosBancarios get dadosBancarios => isPix
      ? Pix(chavePixController.text)
      : Conta(
          bancoPixController.text,
          agenciaPixController.text,
          contaPixController.text,
        );

  Store get store => Store(
        authorized: false,
        name: nameController.text,
        cnpj: cnpjController.text,
        phone: phoneController.text,
        taxaCobrada: double.parse(taxaController.text),
        address: Address(
          numero: addressNumberController.text,
          rua: addressStreetController.text,
          bairro: addressBairroController.text,
        ),
        dadosBancarios: dadosBancarios,
      );

  bool createDisbled = false;

  final RegisterRepository repository = RegisterRepository();

  onCreatePressed() async {
    setState(() {
      createDisbled = true;
    });
    await repository.createStore(store, emailController.text, passwordController.text);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Criado com sucesso!')));
    pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final userFields = [
      TextFieldWidget(labelText: 'Nome', controller: nameController),
      TextFieldWidget(labelText: 'Email', controller: emailController),
      TextFieldWidget(labelText: 'Senha', controller: passwordController),
      TextFieldWidget(labelText: 'CNPJ', controller: cnpjController),
      TextFieldWidget(labelText: 'Telefone', controller: phoneController),
      TextFieldWidget(labelText: 'Taxa comissão', controller: taxaController),
    ];

    final addressFields = [
      TextFieldWidget(labelText: 'Número', controller: addressNumberController),
      TextFieldWidget(labelText: 'Rua', controller: addressStreetController),
      TextFieldWidget(labelText: 'Bairro', controller: addressBairroController),
    ];

    final dbFields = [
      TextFieldWidget(labelText: 'Banco', controller: bancoPixController),
      TextFieldWidget(labelText: 'Agencia', controller: agenciaPixController),
      TextFieldWidget(labelText: 'Conta', controller: contaPixController),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Loja'),
      ),
      bottomNavigationBar:
          BottomNavButton('Cadastrar', createDisbled ? null : onCreatePressed),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Form(
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...userFields
                .map((e) => Padding(
                    child: e, padding: const EdgeInsets.symmetric(vertical: 4)))
                .toList(),
            const Divider(),
            Center(
              child: Title(
                color: Colors.blue,
                child: const Text('Endereço'),
              ),
            ),
            ...addressFields
                .map((e) => Padding(
                    child: e, padding: const EdgeInsets.symmetric(vertical: 4)))
                .toList(),

            const Divider(),
            Center(
              child: Title(
                color: Colors.blue,
                child: const Text('Dados bancarios'),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                      title: const Text('Pix'),
                      value: true,
                      groupValue: isPix,
                      onChanged: (v) {
                        setState(() {
                          isPix = v ?? isPix;
                        });
                      }),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                      title: const Text('Conta'),
                      value: false,
                      groupValue: isPix,
                      onChanged: (v) {
                        setState(() {
                          isPix = v ?? isPix;
                        });
                      }),
                ),
              ],
            ),
            isPix
                ? Column(
                    children: [
                      TextFieldWidget(
                          labelText: 'Chave Pix',
                          controller: chavePixController),
                    ],
                  )
                : Column(
                    children: dbFields
                        .map((e) => Padding(
                            child: e,
                            padding: const EdgeInsets.symmetric(vertical: 4)))
                        .toList()),
            // TextFieldWidget(
            //     labelText: 'Referência',
            //     controller: addressReferenceController),
            // Expanded(
            //     child: Text(
            //   'R\$100,00',
            //   style: Theme.of(context).textTheme.headline4,
            // ))
          ],
        ),
      ),
    );
  }
}

class RegisterRepository {
  final ff = FirebaseFirestore.instance;

Future createStore(Store store, String email, String password) async {
    final storeId = await UserAuth().create(email, password);

    await ff
        .collection(Franchise.collection)
        .doc(franchiseId)
        .collection(Store.collection)
        .doc(storeId)
        .set(store.toMap());

   
  }
}
