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

  Future<void> requestMotoboy(String franchiseId, Order o) async {
    final doc = await firestore
        .collection(Franchise.collection)
        .doc(franchiseId)
        .collection(Order.collection)
        .add(o.toMap()..addAll({'createdAt': Timestamp.now().millisecondsSinceEpoch}));

    //TODO: Avaliar se a loja precisa monitorar o pedido também
    await firestore.collection(Franchise.collection)
        .doc(franchiseId)
        .collection(Store.collection)
        .doc(id)
        .collection(Order.collection)
        .doc(doc.id)
        .set(o.toMap());
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
    try {
      if (f.data() == null) throw Exception('Cadastro ainda não aprovado!');
      return StoreOrderInfo.fromMap(uid, f.data()!);
    } catch (e) {
      throw Exception('Cadastro ainda não aprovado!');
    }
  }
}
