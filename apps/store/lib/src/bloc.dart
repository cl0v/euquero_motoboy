import 'package:core/core.dart';
import 'package:store/src/repository.dart';


// O frete vai ter que ter um bloc próprio para exibir as alterações de preço
// Bloc nada mais é do que as alterações que acontecem na página

class Bloc {

  Bloc(String uid) {
    _init(uid);
  }
  
  late final StoreOrderInfo store;
  late final Frete frete;

  final repository = Repository();

  final totalValueBloc = SimpleBloc<double>();

  _init(String uid) async {
    store = await repository.get(uid);
    frete = await repository.fetchFreteValue();
    totalValueBloc.add(0);
  }

  onChanged(String p1) {
    if (p1 == '') p1 = '0';
    totalValueBloc.add(double.parse(p1) + frete.valorTotal(0));
  }

  void dispose() {
    totalValueBloc.dispose();
  }
}
