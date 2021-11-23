import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:store/src/features/request/states.dart';

import '../bloc.dart';
import '../provider.dart';
import 'client.dart';

class TotalPage extends StatefulWidget {
  const TotalPage({Key? key}) : super(key: key);

  @override
  _TotalPageState createState() => _TotalPageState();
}

class _TotalPageState extends State<TotalPage> {
  late RequestBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = RequestProvider.of(context)!.bloc;
    super.didChangeDependencies();
  }

  onNext() {
    bloc.add(RequestState.client);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Total'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavButton('Confirmar', onNext),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Valor do produto'),
                Text('R\$${bloc.value.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Valor do frete'),
                Text('+ R\$${bloc.valorFrete.toStringAsFixed(2)}'),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Valor final'),
                Text(
                  'R\$${bloc.total.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
