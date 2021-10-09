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

  MotoboyRepository repository = MotoboyRepository();

  late MotoboyOrderInfo motoboy;

  final openOrdersBloc = SimpleBloc<List<OpenOrder>>();
  final acceptedOrdersBloc = SimpleBloc<List<AcceptedOrder>>();

  _init() async {
    //TODO: Esse carinha pode dar error pois pode ser necessário antes de chegar (Posso passar por stream); Ver a necessidade dele...

    final opens = repository
        .openOrders()
        .map((event) => event.map((e) => OpenOrder.fromMap(e)).toList());
    openOrdersBloc.subscribe(opens);

    final accepteds =
        repository.acceptedOrders(motoboy.id).map((event) => event.map((e) {
              return AcceptedOrder.fromMap(e);
            }).toList());

    acceptedOrdersBloc.subscribe(accepteds);
  }

  acceptOrder(OpenOrder order) {
    return repository.acceptOrder(order.id, order.toMap(motoboy));
  }

  finishOrder(AcceptedOrder order) {
    return repository.deliverOrder(order.id, order.delivered());
  }

  dispose() {
    openOrdersBloc.dispose();
    acceptedOrdersBloc.dispose();
  }
}
