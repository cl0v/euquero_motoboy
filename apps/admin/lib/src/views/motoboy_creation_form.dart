import 'package:admin/src/repositories/motoboy_repository.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';


class FormularioCadastroMotoboy extends StatefulWidget {
  const FormularioCadastroMotoboy({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  _FormularioCadastroMotoboyState createState() =>
      _FormularioCadastroMotoboyState();
}

class _FormularioCadastroMotoboyState extends State<FormularioCadastroMotoboy> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController placaController = TextEditingController();
  final TextEditingController taxaController = TextEditingController();

  final TextEditingController chavePixController = TextEditingController();
  final TextEditingController bancoPixController = TextEditingController();
  final TextEditingController agenciaPixController = TextEditingController();
  final TextEditingController contaPixController = TextEditingController();

  MotoboyRepository repository = MotoboyRepository();

//Algum tipo de event notifier
  Motoboy get motoboy {
    return Motoboy(
      name: nameController.text,
      cpf: cpfController.text,
      franchiseId: widget.id,
      phone: phoneController.text,
      placaDaMoto: placaController.text,
      taxaCobrada: double.parse(taxaController.text),
      dadosBancarios: dadosBancarios,
    );
  }

  bool createDisbled = false;

  onCreatePressed() async {
    setState(() {
      createDisbled = true;
    });
    await repository.create(motoboy, emailController.text);
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
