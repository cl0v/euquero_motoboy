import 'package:flutter/material.dart';

class OpenOrderTileWidget extends StatelessWidget {
  const OpenOrderTileWidget(this.title, this.subtitle, this.onPressed,
      {Key? key})
      : super(key: key);
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.white,
      title: Text('Buscar em: $title'),
      subtitle: Text(subtitle),
      trailing: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder()),
            textStyle: MaterialStateProperty.all(TextStyle(
              color: Colors.white,
            ))),
        onPressed: onPressed,
        child: Text('Aceitar'),
      ),
    );
  }
}