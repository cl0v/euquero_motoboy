import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'controller.dart';

class HomePage extends StatefulWidget {
  final String uid;

  const HomePage(this.uid,{Key? key, }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final MotoboyOrderController bloc;

  @override
  void initState() {
    bloc = MotoboyOrderController(widget.uid);
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
              return Column(
                  children: list
                      .map(
                        (e) => _AcceptedOrderTileWidget(
                          e.client.address.toString(),
                          e.client.name,
                          () => bloc.finishOrder(e),
                        ),
                      )
                      .toList());
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
                        (e) => _OpenOrderTileWidget(
                          e.store.name,
                          e.store.address.toString(),
                          () => bloc.acceptOrder(e),
                        ),
                      )
                      .toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AcceptedOrderTileWidget extends StatelessWidget {
  const _AcceptedOrderTileWidget(this.title, this.subtitle, this.onPressed,
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

class _OpenOrderTileWidget extends StatelessWidget {
  const _OpenOrderTileWidget(this.title, this.subtitle, this.onPressed,
      {Key? key})
      : super(key: key);
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
