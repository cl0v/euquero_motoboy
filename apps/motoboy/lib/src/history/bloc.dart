import 'package:core/core.dart';

import '../repository.dart';

class HistoryBloc extends SimpleBloc<List<DeliveredOrder>> {
  MotoboyRepository repository = MotoboyRepository();
  final String uid;

  HistoryBloc(this.uid){
    subscribe(repository.deliveredOrders(uid).map((event) => event.map((e) => DeliveredOrder.fromMap(e)).toList()));
  }

  
  
}
