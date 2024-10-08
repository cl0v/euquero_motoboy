import 'package:authenticator/authenticator.dart';
import 'package:core/core.dart';
import 'package:dependences/dependences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/constants.dart';

final franchiseId = kDebugMode
    ? 'SQP3sTEhmDYSLoHPyyrZCKfO0Vc2'
    : 'Yr9vJcaEu8NDDxTD4vRlR2DqLxR2';

class FormularioCadastroMotoboy extends StatefulWidget {
  const FormularioCadastroMotoboy({Key? key}) : super(key: key);

  @override
  _FormularioCadastroMotoboyState createState() =>
      _FormularioCadastroMotoboyState();
}

class _FormularioCadastroMotoboyState extends State<FormularioCadastroMotoboy> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController placaController = TextEditingController();
  final TextEditingController taxaController = TextEditingController();

  final TextEditingController chavePixController = TextEditingController();
  final TextEditingController bancoPixController = TextEditingController();
  final TextEditingController agenciaPixController = TextEditingController();
  final TextEditingController contaPixController = TextEditingController();

  late final RegisterRepository repository = RegisterRepository();

//Algum tipo de event notifier
  Motoboy get motoboy {
    return Motoboy(
      name: nameController.text,
      cpf: cpfController.text,
      phone: phoneController.text,
      placaDaMoto: placaController.text,
      taxaCobrada: double.parse(taxaController.text),
      dadosBancarios: dadosBancarios,
      authorized: false,
    );
  }

  bool createDisbled = false;

  onCreatePressed() async {
    setState(() {
      createDisbled = true;
    });
    await repository.createMotoboy(
        motoboy, emailController.text, passwordController.text);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Criado com sucesso!')));
    pop(context);
  }

  bool isPix = true;

  DadosBancarios get dadosBancarios => isPix
      ? Pix(chavePixController.text)
      : Conta(bancoPixController.text, agenciaPixController.text,
          contaPixController.text);

  @override
  Widget build(BuildContext context) {
    final fields = [
      TextFieldWidget(labelText: 'Nome', controller: nameController),
      TextFieldWidget(labelText: 'Email', controller: emailController),
      TextFieldWidget(labelText: 'Senha', controller: passwordController),
      TextFieldWidget(labelText: 'CPF', controller: cpfController),
      TextFieldWidget(labelText: 'Telefone', controller: phoneController),
      TextFieldWidget(labelText: 'Taxa comissão', controller: taxaController),
      TextFieldWidget(labelText: 'Placa da Moto', controller: placaController),
    ];

    final dbFields = [
      TextFieldWidget(labelText: 'Banco', controller: bancoPixController),
      TextFieldWidget(labelText: 'Agencia', controller: agenciaPixController),
      TextFieldWidget(labelText: 'Conta', controller: contaPixController),
    ];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Motoboy'),
      ),
      bottomNavigationBar: BottomNavButton(
        'Cadastrar',
        createDisbled ? null : onCreatePressed,
      ),
      body: Form(
        child: ListView(
          children: [
            ...fields
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
                ? TextFieldWidget(
                    labelText: 'Chave Pix', controller: chavePixController)
                : Column(
                    children: dbFields
                        .map((e) => Padding(
                            child: e,
                            padding: const EdgeInsets.symmetric(vertical: 4)))
                        .toList()),
          ],
        ),
      ),
    );
  }
}

class RegisterRepository {
  final ff = FirebaseFirestore.instance;

  Future createMotoboy(Motoboy motoboy, String email, String password) async {
    final id = await UserAuth().create(email, password);

    await ff
        .collection(Franchise.collection)
        .doc(franchiseId)
        .collection(Motoboy.collection)
        .doc(id)
        .set(motoboy.toMap());
  }
}
