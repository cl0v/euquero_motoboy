import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:motoboy/src/history/controller.dart';
import 'package:motoboy/src/history/provider.dart';
import 'package:motoboy/src/history/view.dart';

import 'bloc.dart';
import 'components/accepted_order_widget.dart';
import 'components/open_order_widget.dart';

class HomePage extends StatefulWidget {
  final HomeBloc bloc;

  const HomePage({
    required this.bloc,
    Key? key,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc bloc;

  @override
  void initState() {
    bloc = widget.bloc;
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
          TextButton.icon(
              icon: Icon(Icons.payment),
              onPressed: () {
                push(
                  context,
                  HistoryProvider(
                    controller: HistoryController(
                      repository: bloc.repository,
                    ),
                    child: HistoryPage(),
                  ),
                );
              },
              label: Text('HISTORICO'))
        ],
      ),
      body: Column(
        children: [
          Text('Pedidos aceitos'),
          StreamBuilder<List<Order>>(
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
                            total: (e.valorFrete + e.valorPedido)
                                .toStringAsFixed(2),
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
          StreamBuilder<List<Order>>(
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
                              (e.valorFrete + e.valorPedido).toStringAsFixed(2),
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
