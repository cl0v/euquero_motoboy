import 'package:core/core.dart';
import 'package:dependences/dependences.dart';

class Repository {
  late final FirebaseFirestore firestore;

  Repository([FirebaseFirestore? firestore]) {
    this.firestore = firestore ?? FirebaseFirestore.instance;
  }

/// Recebe o motoboy
  Future<MotoboyOrderInfo> get(String uid) async {
    final f = await FirebaseFirestore.instance
        .collection(Motoboy.collection)
        .doc(uid)
        .get();
    return MotoboyOrderInfo.fromMap(f.data()!..addAll({'id': f.id}));
  }

/// Aceitar o pedido
  Future<void> acceptOrder(String orderId, Map<String, dynamic> values) =>
      firestore.collection(Order.collection).doc(orderId).update(values
        ..addAll({
          'acceptedAt': Timestamp.now(),
        }));

/// Marcar como entregue
  deliverOrder(String orderId, Map<String, dynamic> values) =>
      firestore.collection(Order.collection).doc(orderId).update(values
        ..addAll({
          'deliveredAt': Timestamp.now(),
        }));

/// Pedidos em aberto
  Stream<List<Map<String, dynamic>>> openOrders() {
    return firestore
        .collection(Order.collection)
        .where('status', isEqualTo: OrderStatus.open.toString())
        .snapshots()
        .map((event) => event.docs
            .map(
              (e) => e.data()..['id'] = e.id,
            )
            .toList());
  }

/// Pedidos aceitos
  Stream<List<Map<String, dynamic>>> acceptedOrders(String uid) {
    return firestore
        .collection(Order.collection)
        .where('status', isEqualTo: OrderStatus.accepted.toString())
        .where('motoboy.id', isEqualTo: uid)
        .snapshots()
        .map((event) => event.docs
            .map(
              (e) => e.data()..['id'] = e.id,
            )
            .toList());
  }

  /// Ultimos 10 pedidos finalizados
   Stream<List<Map<String, dynamic>>> deliveredOrders(String uid) {
    return firestore
        .collection(Order.collection)
        .where('status', isEqualTo: OrderStatus.delivered.toString())
        .where('motoboy.id', isEqualTo: uid).limit(10)
        .snapshots()
        .map((event) => event.docs
            .map(
              (e) => e.data()..['id'] = e.id,
            )
            .toList());
  }

}
