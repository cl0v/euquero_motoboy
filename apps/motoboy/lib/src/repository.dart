import 'package:core/core.dart';
import 'package:dependences/dependences.dart';

class MotoboyRepository {
  late final FirebaseFirestore firestore;
  final String uid;
  final String franchiseId;

  MotoboyRepository({
    required this.uid,
    required this.franchiseId,
    FirebaseFirestore? firestore,
  }) {
    this.firestore = firestore ?? FirebaseFirestore.instance;
  }

  /// Recebe o motoboy
  static Future<MotoboyOrderInfo> get(String uid) async {
    final f = await FirebaseFirestore.instance
        .collection(Motoboy.collection)
        .doc(uid)
        .get();
    return MotoboyOrderInfo.fromMap(f.data()!..addAll({'id': f.id}));
  }

  /// Aceitar o pedido
  Future<void> acceptOrder(Order order) async {
    final t = Timestamp.now();
    await firestore
        .collection(Franchise.collection)
        .doc(franchiseId)
        .collection(Order.collection)
        .doc(order.id)
        .update({
      'motoboy': uid,
      'status': OrderStatus.accepted.index,
      'acceptedAt': t,
    });
    await firestore
        .collection(Motoboy.collection)
        .doc(uid)
        .collection(Order.collection)
        .add(order.toMap()
          ..addAll({
            'acceptedAt': t,
            'status': OrderStatus.accepted.index,
          }));
  }

  /// Marcar como entregue
  deliverOrder(String orderId) async {
    await firestore
        .collection(Motoboy.collection)
        .doc(uid)
        .collection(Order.collection)
        .doc(orderId)
        .update({
      'status': OrderStatus.delivered.index,
      'deliveredAt': Timestamp.now(),
    });
  }

  /// Pedidos em aberto
  Stream<List<Map<String, dynamic>>> openOrders() {
    return firestore
        .collection(Franchise.collection)
        .doc(franchiseId)
        .collection(Order.collection)
        .where('status', isEqualTo: OrderStatus.open.index)
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
        .collection(Motoboy.collection)
        .doc(uid)
        .collection(Order.collection)
        .where('status', isEqualTo: OrderStatus.accepted.index)
        //TODO: Testar isso, pois so pode ter um query
        // .where('motoboy.id', isEqualTo: uid)
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
        .collection(Franchise.collection)
        .doc(franchiseId)
        .collection(Order.collection)
        .where('status', isEqualTo: OrderStatus.delivered.index)
        .limit(10)
        .snapshots()
        .map((event) => event.docs
            .map(
              (e) => e.data()..['id'] = e.id,
            )
            .toList());
  }
}
