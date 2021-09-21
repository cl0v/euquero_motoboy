import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:motoboy/src/history/bloc.dart';

import 'components/listtile_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage(this.uid, {Key? key}) : super(key: key);
  final String uid;

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late final HistoryBloc bloc;

  @override
  void initState() {
    bloc = HistoryBloc(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<DeliveredOrder>>(
          stream: bloc.stream,
          builder: (c, snapshot) {
            if (snapshot.data != null)
              return ListView(
                children: snapshot.data?.map((e) => HistoryListTile(e.total.toStringAsFixed(2), e.client.name)).toList() ?? [],
              );
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
