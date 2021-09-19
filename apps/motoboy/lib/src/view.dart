import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'bloc.dart';
import 'components/request.dart';

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
  late final Bloc bloc;

  @override
  void initState() {
    bloc = Bloc(widget.uid);
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
      appBar: AppBar(),
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
              return Column(children: list.map((e) => AcceptedField()).toList()
                  //  list
                  //     .map(
                  //       (e) => AcceptedOrderTileWidget(
                  //         e.client.address.toString(),
                  //         e.client.name,
                  //         () => bloc.finishOrder(e),
                  //       ),
                  //     )
                  //     .toList(),
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
                          (e) => RequestField(),
                        )
                        .toList()
                    // list
                    //     .map(
                    //       (e) => OpenOrderTileWidget(
                    //         e.store.name,
                    //         e.store.address.toString(),
                    //         () => bloc.acceptOrder(e),
                    //       ),
                    //     )
                    //     .toList(),
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _OrderTileWidget extends StatelessWidget {
  const _OrderTileWidget(this.title, this.btnText, this.onPressed, {Key? key})
      : super(key: key);
  final String title;
  final String btnText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: ElevatedButton(
        onPressed: onPressed,
        child: Text(btnText),
      ),
    );
  }
}
