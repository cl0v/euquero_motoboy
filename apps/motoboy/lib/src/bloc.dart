//TODO: Passar toda a lógica da página de pedidos que o motoboy tem que trabalhar para cá

import 'package:core/core.dart';
import 'package:motoboy/src/repository.dart';

class Bloc {
  Bloc(String uid) {
    _init(uid);
  }
  late final String uid;
  Repository repository = Repository();

  late MotoboyOrderInfo motoboy;

  final openOrdersBloc = SimpleBloc<List<OpenOrder>>();
  final acceptedOrdersBloc = SimpleBloc<List<AcceptedOrder>>();

  _init(uid) async {
    //TODO: Esse carinha pode dar error pois pode ser necessário antes de chegar (Posso passar por stream); Ver a necessidade dele...
    repository.get(uid).then((value) => motoboy = value);

    final opens = repository
        .openOrders()
        .map((event) => event.map((e) => OpenOrder.fromMap(e)).toList());
    openOrdersBloc.subscribe(opens);

    final accepteds =
        repository.acceptedOrders(uid).map((event) => event.map((e) {
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
