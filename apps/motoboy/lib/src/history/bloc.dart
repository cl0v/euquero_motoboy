import 'package:core/core.dart';

import '../repository.dart';

class HistoryBloc extends Bloc<List<Order>> {
  final String uid;

  HistoryBloc(this.uid){
  // MotoboyRepository repository = MotoboyRepository(uid);
    // subscribe(repository.deliveredOrders(uid).map((event) => event.map((e) => Order.fromMap(e)).toList()));
  }

  
  
}
