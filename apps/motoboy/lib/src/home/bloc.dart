//TODO: Passar toda a lógica da página de pedidos que o motoboy tem que trabalhar para cá

import 'package:core/core.dart';
import 'package:motoboy/src/repository.dart';

class HomeBloc {
  HomeBloc({
    required this.motoboy,
    required this.repository,
  }) {
    _init();
  }

  final MotoboyRepository repository;
  final MotoboyOrderInfo motoboy;

  final openOrdersBloc = Bloc<List<Order>>();
  final acceptedOrdersBloc = Bloc<List<Order>>();

  _init() async {
    //TODO: Esse carinha pode dar error pois pode ser necessário antes de chegar (Posso passar por stream); Ver a necessidade dele...

    openOrdersBloc.subscribe(repository.openOrders());

    acceptedOrdersBloc.subscribe(repository.acceptedOrders(motoboy.id));
  }

  acceptOrder(Order order) {
    return repository.acceptOrder(order);
  }

  finishOrder(Order order) {
    return repository.deliverOrder(order);
  }

  dispose() {
    openOrdersBloc.dispose();
    acceptedOrdersBloc.dispose();
  }
}
