import 'package:flutter/material.dart';

class HistoryListTile extends StatelessWidget {
  const HistoryListTile(this.value, this.clientName,{Key? key}) : super(key: key);
  final String clientName;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(color: Colors.black45, child: ListTile(title: Text(clientName), trailing: Text(value),),);
  }
}
