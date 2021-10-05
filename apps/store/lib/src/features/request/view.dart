import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:store/src/features/request/provider.dart';
import 'package:store/src/features/request/screens/address.dart';
import 'package:store/src/features/request/screens/client.dart';
import 'package:store/src/features/request/screens/price.dart';
import 'package:store/src/features/request/screens/sucess.dart';
import 'package:store/src/features/request/screens/total.dart';
import 'package:store/src/features/request/states.dart';

import 'bloc.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  late final RequestBloc bloc;
  @override
  void didChangeDependencies() {
    bloc = RequestProvider.of(context)!.bloc..init();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RequestState>(
        stream: bloc.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            switch (snapshot.data!) {
              case RequestState.address:
                return const AddressPage();
              case RequestState.client:
                return const ClientPage();
              case RequestState.price:
                return const PricesPage();
              case RequestState.total:
                return const TotalPage();
              case RequestState.sucess:
                return SucessScreen(
                  text: 'Pedido efetuado com sucesso!',
                  onPressed: () {
                    // pop(context);
                    bloc.add(RequestState.address);
                  },
                );
              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
