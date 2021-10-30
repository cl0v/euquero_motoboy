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

    final opens = repository
        .openOrders()
        .map((event) => event.map((e) => Order.fromMap(e)).toList());
    openOrdersBloc.subscribe(opens);

    final accepteds =
        repository.acceptedOrders(motoboy.id).map((event) => event.map((e) {
              return Order.fromMap(e);
            }).toList());

    acceptedOrdersBloc.subscribe(accepteds);
  }

  acceptOrder(Order order) {
    return repository.acceptOrder(order);
  }

  finishOrder(Order order) {
    return repository.deliverOrder(order.id);
  }

  dispose() {
    openOrdersBloc.dispose();
    acceptedOrdersBloc.dispose();
  }
}
