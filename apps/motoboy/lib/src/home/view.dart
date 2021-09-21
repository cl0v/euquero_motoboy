import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:motoboy/src/history/view.dart';

import 'bloc.dart';
import '../components/accepted_order_widget.dart';
import '../components/open_order_widget.dart';

class HomePage extends StatefulWidget {
  final String uid;

  const HomePage(
    this.uid, {
    Key? key,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc bloc;

  @override
  void initState() {
    bloc = HomeBloc(widget.uid);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            push(context, HistoryPage(widget.uid));
          }, child: Text('HISTORICO'))
        ],
      ),
      body: Column(
        children: [
          Text('Pedidos aceitos'),
          StreamBuilder<List<AcceptedOrder>>(
            stream: bloc.acceptedOrdersBloc.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              final list = snapshot.data ?? [];
              return Column(
                children: list
                    .map((e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: AcceptedOrderTileWidget(
                            total: e.total.toStringAsFixed(2),
                            clientTitle: e.client.name,
                            clientAddress: e.client.address.toString(),
                            storeTitle: e.store.name,
                            storeAddress: e.store.address.toString(),
                            onPressed: () => bloc.finishOrder(e),
                          ),
                        ))
                    .toList(),
              );
            },
          ),
          Text('Pedidos abertos'),
          StreamBuilder<List<OpenOrder>>(
            stream: bloc.openOrdersBloc.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              final list = snapshot.data ?? [];
              return Expanded(
                child: ListView(
                    children: list
                        .map(
                          (e) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: OpenOrderTileWidget(

                              e.store.name,
                              e.store.address.toString(),
                              e.total.toStringAsFixed(2),
                              () => bloc.acceptOrder(e),
                            ),
                          ),
                        )
                        .toList()),
              );
            },
          ),
        ],
      ),
    );
  }
}
