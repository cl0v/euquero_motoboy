import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'repository.dart';

class FormularioCadastroLoja extends StatefulWidget {
  const FormularioCadastroLoja({Key? key}) : super(key: key);

  @override
  _FormularioCadastroLojaState createState() => _FormularioCadastroLojaState();
}

class _FormularioCadastroLojaState extends State<FormularioCadastroLoja> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
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
      ? DadosBancarios.pix(chavePixController.text)
      : DadosBancarios.conta(bancoPixController.text, agenciaPixController.text,
          contaPixController.text);

  Store get store => Store(
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

  Repository repository = Repository();

  onCreatePressed() async {
    await repository.createStore(store, emailController.text);
    pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final userFields = [
      TextFieldWidget(labelText: 'Nome', controller: nameController),
      TextFieldWidget(labelText: 'Email', controller: emailController),
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
        title: Text('Cadastrar Loja'),
      ),
      bottomNavigationBar: BottomNavButton('Cadastrar', onCreatePressed),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...userFields
                .map((e) => Padding(
                    child: e, padding: EdgeInsets.symmetric(vertical: 4)))
                .toList(),
            Divider(),
            Center(
              child: Title(
                color: Colors.blue,
                child: Text('Endereço'),
              ),
            ),
            ...addressFields
                .map((e) => Padding(
                    child: e, padding: EdgeInsets.symmetric(vertical: 4)))
                .toList(),

            Divider(),
            Center(
              child: Title(
                color: Colors.blue,
                child: Text('Dados bancarios'),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                      title: Text('Pix'),
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
                      title: Text('Conta'),
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
                            padding: EdgeInsets.symmetric(vertical: 4)))
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
