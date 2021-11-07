import 'package:authenticator/authenticator.dart';
import 'package:core/core.dart';
import 'package:dependences/dependences.dart';

abstract class IRegistration {
  Future createMotoboy(Motoboy motoboy, String email);
  Future createStore(Store store, String email);
}

class Repository implements IRegistration {
  final ff = FirebaseFirestore.instance;
  final String id;

  Repository(this.id);
  @override
  Future createMotoboy(Motoboy motoboy, String email) async {
    final motoboyId = await UserAuth().create(email, '123123');

    await ff
        .collection(Franchise.collection)
        .doc(id)
        .collection(Motoboy.collection)
        .doc(motoboyId)
        .set(motoboy.toMap());

    await ff
        .collection(Motoboy.collection)
        .doc(motoboyId)
        .set(motoboy.toMotoboyOrderInfo(id));
  }

  @override
  Future createStore(Store store, String email) async {
    final storeId = await UserAuth().create(email, '123123');

    await ff
        .collection(Franchise.collection)
        .doc(id)
        .collection(Store.collection)
        .doc(storeId)
        .set(store.toMap());

    await ff
        .collection(Store.collection)
        .doc(storeId)
        .set(store.toStoreOrderInfo(id));
  }

  Future<List<Order>> orders(int month) async {
    final ti = DateTime(DateTime.now().year, month, 1);
    final tf = ti.add(const Duration(days: 15));
    final r = await ff
        .collection(Franchise.collection)
        .doc(id)
        .collection(Order.collection)
        .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(ti))
        .where('createdAt', isLessThan: Timestamp.fromDate(tf))
        .get();

    return r.docs.map((e) {
      return Order.fromMap(e.reference.id, e.data());
    }).toList();
  }
}
