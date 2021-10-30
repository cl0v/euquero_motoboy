import 'package:core/core.dart';
import 'package:dependences/dependences.dart';

class RequestRepository {
  late final FirebaseFirestore firestore;
  final String id;
  final String franchiseId;

  RequestRepository({
    required this.id,
    required this.franchiseId,
    FirebaseFirestore? firestore,
  }) {
    this.firestore = firestore ?? FirebaseFirestore.instance;
  }

  //TODO: Avaliar se a loja precisa monitorar o pedido também
  Future<void> requestMotoboy(String franchiseId, Order o) async {
    final doc = await firestore
        .collection(Franchise.collection)
        .doc(franchiseId)
        .collection(Order.collection)
        .add(
          o.toMap()
            ..addAll(
              {'createdAt': Timestamp.now()},
            ),
        );

    await firestore.collection(Store.collection).doc(doc.id).set(o.toMap());
  }

  Future<Frete> fetchFreteValue(String franchiseId) async {
    final r = await FirebaseFirestore.instance
        .collection(Franchise.collection)
        .doc(franchiseId)
        .get();
    return Frete.fromMap(r.data()?['frete']);
  }

  static Future<StoreOrderInfo> get(String uid) async {
    final f = await FirebaseFirestore.instance
        .collection(Store.collection)
        .doc(uid)
        .get();
    return StoreOrderInfo.fromMap(f.data()!..addAll({'id': f.id}));
  }
}
