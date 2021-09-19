import 'package:core/core.dart';
import 'package:dependences/dependences.dart';

class Repository {
  late final FirebaseFirestore firestore;

  Repository([FirebaseFirestore? firestore]) {
    this.firestore = firestore ?? FirebaseFirestore.instance;
  }

  Future<void> requestMotoboy(Order o) =>
      firestore.collection(Order.collection).add(o.toMap()..addAll({'createdAt' : Timestamp.now()}));

  Future<Frete> fetchFreteValue() async {
    final r = await FirebaseFirestore.instance
        .collection(GlobalConfigs.collection)
        .doc(GlobalConfigs.docId)
        .get();
    return Frete.fromMap(r.data()?['frete']);
  }

  Future<StoreOrderInfo> get(String uid) async {
    final f = await FirebaseFirestore.instance
        .collection(UserData.userCollection)
        .doc(uid)
        .get();
    return StoreOrderInfo.fromMap(f.data()!..addAll({'id': f.id}));
  }
}
