import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';

import 'global_configs.dart';
import 'motoboy_creation_form.dart';
import 'store_creation_form.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage(
    this.uid, {
    Key? key,
  }) : super(key: key);
  final String uid;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Dashboard'),
      ),
      body: GridButton(
        onPressed: (v) {
          if (v != null) push(context, v);
        },
        items: const [
          [
            GridButtonItem(
                child:
                    Text('Cadastrar Motoboy', style: TextStyle(fontSize: 22)),
                value: FormularioCadastroMotoboy()),
            GridButtonItem(
                child: Text('Cadastrar Loja', style: TextStyle(fontSize: 22)),
                value: FormularioCadastroLoja()),
          ],
          // [
          //   GridButtonItem(
          //     value: AdminPanelPage(),
          //     child: Text("Painel Financeiro", style: TextStyle(fontSize: 22)),
          //   ),
          //   GridButtonItem(
          //     value: GlobalConfigsPage(),
          //     child: Text("Configurações", style: TextStyle(fontSize: 22)),
          //   )
          // ],
        ],
      ),
    );
  }
}

class AdminPanelPage extends StatelessWidget {
  const AdminPanelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Funcionalidade ainda não implementada'),
      ),
    );
  }
}
