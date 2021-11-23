import 'package:core/core.dart';
import 'package:dependences/dependences.dart';
import 'package:store/src/features/history/interface.dart';

class RequestRepository implements IHistoryRepository{
  late final FirebaseFirestore firestore;
  final String uid;

  RequestRepository({
    required this.uid,
    FirebaseFirestore? firestore,
  }) {
    this.firestore = firestore ?? FirebaseFirestore.instance;
  }

  Future requestMotoboy(Order order) async {
    final map = order.toMap()
      ..addAll({'createdAt': Timestamp.now().millisecondsSinceEpoch});

    //Adiciona a ordem na franchise/{id}/openOrders
    await firestore
        .collection(Franchise.collection)
        .doc(StoreOrderInfo.franchiseId)
        .collection(Order.opensCollection)
        .add(map);
  }

  Future<Frete> fetchFreteValue() async {
    final r = await FirebaseFirestore.instance
        .collection(Franchise.collection)
        .doc(StoreOrderInfo.franchiseId)
        .get();
    return Frete.fromMap(r.data()?['frete']);
  }

  static Future<StoreOrderInfo> get(String uid) async {
    final f = await FirebaseFirestore.instance
        .collection(Store.collection)
        .doc(uid)
        .get();
    try {
      if (f.data() == null) throw Exception('Cadastro ainda não aprovado!');
      StoreOrderInfo.franchiseId = f.data()!['franchiseId'];
      return StoreOrderInfo.fromMap(uid, f.data()!);
    } catch (e) {
      throw Exception('Cadastro ainda não aprovado!');
    }
  }
@override
  Stream<List<Order>> get orders  => firestore
        .collection(Franchise.collection)
        .doc(StoreOrderInfo.franchiseId)
        .collection(Store.collection)
        .doc(uid)
        .collection(Order.collection)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => Order.fromMap(e.id, e.data())).toList());

  @override
  Future<List<Payment>> get payments async {
    final payments = await firestore
        .collection(Franchise.collection)
        .doc(StoreOrderInfo.franchiseId)
        .collection(Store.collection)
        .doc(uid)
        .collection(Payment.collection)
        .get();
    return payments.docs.map((e) => Payment.fromMap(e.id, e.data())).toList();
  }

  @override
  Future<void> requestPayment(Payment payment, List<Order> itens) async {
    final ref = await firestore
        .collection(Franchise.collection)
        .doc(StoreOrderInfo.franchiseId)
        .collection(Store.collection)
        .doc(uid)
        .collection(Payment.collection)
        .add(payment.toMap());

    for (var o in itens) {
      await ref.collection(Order.collection).add(o.toMap());
      await firestore
          .collection(Franchise.collection)
          .doc(StoreOrderInfo.franchiseId)
          .collection(Store.collection)
          .doc(uid)
          .collection(Order.collection)
          .doc(o.id)
          .delete();
    }
  }
}
