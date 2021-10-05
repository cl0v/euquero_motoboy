import 'package:core/core.dart';
import 'package:store/src/features/request/repository.dart';
import 'package:store/src/features/request/states.dart';

// O frete vai ter que ter um bloc próprio para exibir as alterações de preço
// Bloc nada mais é do que as alterações que acontecem na página

class RequestBloc extends SimpleBloc<RequestState> {
  RequestBloc(
    String uid, {
    required this.repository,
  }) {
    _init(uid);
  }

  late final RequestRepository repository;

  late final StoreOrderInfo store;
  late final Frete frete;

  late Address address;
  late double value;
  late ClientModel client;

  double get valorFrete => frete.valorTotal(0);
  double get total => frete.valorTotal(0) + value;

  _init(String uid) async {
    //TODO: Refazer
    store = await repository.get(uid);
    frete = await repository.fetchFreteValue();
  }

  requestDelivery() async {
      await repository.requestMotoboy(
        Order(
          valorPedido: value,
          valorFrete: valorFrete,
          store: store,
          client: client,
        ),
      );
  }

  init() {
    add(RequestState.address);
  }
}
