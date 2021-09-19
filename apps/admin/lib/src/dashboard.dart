import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grid_button/flutter_grid_button.dart';

import 'motoboy_creation_form.dart';
import 'store_creation_form.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({Key? key}) : super(key: key);

  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
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
        items: [
          [
            GridButtonItem(
                child:
                    const Text('Cadastrar Motoboy', style: TextStyle(fontSize: 22)),
                value: FormularioCadastroMotoboy()),
            GridButtonItem(
                child: const Text('Cadastrar Loja', style: TextStyle(fontSize: 22)),
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
    return Scaffold(
      body: Center(
        child: Text('Funcionalidade ainda não implementada'),
      ),
    );
  }
}
