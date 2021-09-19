
import 'package:flutter/material.dart';

class AcceptedOrderTileWidget extends StatelessWidget {
  const AcceptedOrderTileWidget(this.title, this.subtitle, this.onPressed,
      {Key? key})
      : super(key: key);
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Entregar em: $title'),
      subtitle: Text('Chamar por $subtitle'),
      trailing: ElevatedButton(
        onPressed: onPressed,
        child: Text('Entregue'),
      ),
    );
  }
}