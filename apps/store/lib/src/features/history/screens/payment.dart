import 'package:flutter/material.dart';
import 'package:core/core.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({Key? key, required this.itens}) : super(key: key);
  final List<Payment> itens;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: itens
          .map((e) => ListTile(
                title: Text('R\$${e.valor.toStringAsFixed(2).replaceAll('.', ',')}'),
                trailing: Text(e.paid ? 'Pago' : 'Processando'),
              ))
          .toList(),
    );
  }
}
