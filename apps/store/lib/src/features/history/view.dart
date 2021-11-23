
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'controller.dart';
import 'provider.dart';
import 'screens/payment.dart';
import 'screens/recents.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late final HistoryController controller;

  @override
  void didChangeDependencies() {
    controller = HistoryProvider.of(context)!.controller;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pedidos'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Histórico',),
              Tab(text: 'Pagamento'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StreamBuilder<List<Order>>(
                stream: controller.repository.orders,
                builder: (context, snapshot) {
                  final itens = snapshot.data ?? [];
                  return RecentOrdersScreen(itens: itens);
                }),
            FutureBuilder<List<Payment>>(
                future: controller.repository.payments,
                builder: (context, snapshot) {
                  final itens = snapshot.data ?? [];
                  return PaymentsScreen(itens: itens);
                }),
          ],
        ),
      ),
    );
  }
}
