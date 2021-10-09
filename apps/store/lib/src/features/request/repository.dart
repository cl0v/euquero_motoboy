import 'package:core/core.dart';
import 'package:dependences/dependences.dart';

class RequestRepository {
  late final FirebaseFirestore firestore;

  RequestRepository([FirebaseFirestore? firestore]) {
    this.firestore = firestore ?? FirebaseFirestore.instance;
  }



  Future<void> requestMotoboy(Order o) =>
      firestore.collection(Order.collection).add(o.toMap()..addAll({'createdAt' : Timestamp.now()}));

  Future<Frete> fetchFreteValue(String franchiseId) async {
    final r = await FirebaseFirestore.instance
        .collection(Franchise.collection)
        .doc(franchiseId)
        .get();
    return Frete.fromMap(r.data()?['frete']);
  }

  Future<StoreOrderInfo> get(String uid) async {
    final f = await FirebaseFirestore.instance
        .collection(Store.collection)
        .doc(uid)
        .get();
    return StoreOrderInfo.fromMap(f.data()!..addAll({'id': f.id}));
  }
}
