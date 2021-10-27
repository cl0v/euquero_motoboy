import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:store/src/features/request/states.dart';
import '../bloc.dart';
import '../provider.dart';
import 'total.dart';

class PricesPage extends StatefulWidget {
  const PricesPage({Key? key}) : super(key: key);

  @override
  _PricesPageState createState() => _PricesPageState();
}

class _PricesPageState extends State<PricesPage> {
  final TextEditingController valorController = TextEditingController();

  late final RequestBloc bloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    bloc = RequestProvider.of(context)!.bloc;
    super.didChangeDependencies();
  }

  onNext() {
    
    bloc.value = double.parse(valorController.text.replaceAll(',', '.'));
    bloc.add(RequestState.total);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quanto cobrar?'),
        centerTitle: true,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: TextFieldWidget(
            labelText: 'Valor',
            controller: valorController,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavButton('Próximo', onNext),
    );
  }
}
