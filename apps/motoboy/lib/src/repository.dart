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

  /// Procura pelo motoboy na top-collection, caso não tenha é que o cadastro
  /// não foi aprovado ainda.
  static Future<MotoboyOrderInfo> get(String uid, String franchiseId) async {
    final f = await FirebaseFirestore.instance
        .collection(Motoboy.collection)
        .doc(uid)
        .get();
    if (f.data() == null) throw Exception('Cadastro ainda não aprovado!');
    return MotoboyOrderInfo.fromMap(f.id, f.data()!);
  }

  /// Aceitar o pedido
  Future acceptOrder(Order order) async {
    final t = Timestamp.now().millisecondsSinceEpoch;
    final map = order.toMap()
      ..addAll({
        'motoboy': uid,
        'acceptedAt': t,
      });

    // Adiciona o pedido na collection de aceitos.
    await firestore
        .collection(Franchise.collection)
        .doc(franchiseId)
        .collection(Order.acceptedCollection)
        .doc(order.id)
        .set(map);

    // Exclui o pedido da collection de abertos.
    await firestore
        .collection(Franchise.collection)
        .doc(franchiseId)
        .collection(Order.opensCollection)
        .doc(order.id)
        .delete();
  }

  /// Marcar como entregue
  deliverOrder(Order order) async {
    //TODO: É esse cara que vai adicionar a ordem em todos os lugares (Franquia, motoboy e loja)
    final t = Timestamp.now().millisecondsSinceEpoch;
    final map = order.toMap()..addAll({'deliveredAt': t});

    // Adiciona o pedido entregue na franquia
    await firestore
        .collection(Franchise.collection)
        .doc(franchiseId)
        .collection(Order.collection)
        .doc(order.id)
        .set(map);

    // Adiciona o pedido entregue no motoboy
    await firestore
        .collection(Franchise.collection)
        .doc(franchiseId)
        .collection(Motoboy.collection)
        .doc(order.motoboy)
        .collection(Order.collection)
        .doc(order.id)
        .set(map);

    // Adiciona o pedido entregue na loja
    await firestore
        .collection(Franchise.collection)
        .doc(franchiseId)
        .collection(Store.collection)
        .doc(order.store.id)
        .collection(Order.collection)
        .doc(order.id)
        .set(map);

    // Remove das aceitas
    await firestore
        .collection(Franchise.collection)
        .doc(franchiseId)
        .collection(Order.acceptedCollection)
        .doc(order.id)
        .delete();
  }

  /// Pedidos em aberto
  Stream<List<Order>> openOrders() {
    return firestore
        .collection(Franchise.collection)
        .doc(franchiseId)
        .collection(Order.opensCollection)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Order.fromMap(e.id, e.data())).toList());
  }

  /// Pedidos aceitos
  Stream<List<Order>> acceptedOrders(String uid) {
    return firestore
        .collection(Franchise.collection)
        .doc(franchiseId)
        .collection(Order.acceptedCollection)
        .where('motoboy', isEqualTo: uid)
        .snapshots()
        .map((event) => event.docs.map((e) => Order.fromMap(e.id, e.data())).toList());
  }

  /// Ultimos 10 pedidos finalizados
  Stream<List<Map<String, dynamic>>> deliveredOrders(String uid) {
    //TODO: Implementar ordens entregues
    return firestore
        .collection(Franchise.collection)
        .doc(franchiseId)
        .collection(Order.collection)
        .limit(10)
        .snapshots()
        .map((event) => event.docs
            .map(
              (e) => e.data()..['id'] = e.id,
            )
            .toList());
  }
}
