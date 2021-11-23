import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:motoboy/src/history/controller.dart';
import 'package:motoboy/src/history/provider.dart';

//TODO: Sair da tela depois do loading completo

class RecentOrdersScreen extends StatefulWidget {
  const RecentOrdersScreen({Key? key, required this.itens}) : super(key: key);
  final List<Order> itens;

  @override
  State<RecentOrdersScreen> createState() => _RecentOrdersScreenState();
}

class _RecentOrdersScreenState extends State<RecentOrdersScreen> {
  bool isLoading = false;

  late HistoryController controller;

  @override
  void didChangeDependencies() {
    controller = HistoryProvider.of(context)!.controller;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double total =
        widget.itens.map((e) => e.valorFrete).fold(0, (a, b) => a + b);
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        floatingActionButton: Visibility(
          visible: total >= 100,
          child: FloatingActionButton.extended(
            label: Text('Solicitar pagamento'),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });

              await controller.requestPayment(widget.itens);

              setState(() {
                isLoading = false;
              });
            },
          ),
        ),
        body: ListView(children: [
          Center(
            child: Text(
              'R\$${total.toStringAsFixed(2).replaceAll('.', ',')} / R\$100,00',
              style: TextStyle(fontSize: 32),
            ),
          ),
          ...widget.itens.map((e) {
            final time = e.deliveredAt != null
                ? DateTime.fromMillisecondsSinceEpoch(e.deliveredAt!)
                : DateTime.now();
            return Card(
              child: ListTile(
                title:
                    Text(e.valorFrete.toStringAsFixed(2).replaceAll('.', ',')),
                trailing: Text('${time.day}/${time.month}'),
              ),
            );
          }).toList(),
        ]),
      ),
    );
  }
}
