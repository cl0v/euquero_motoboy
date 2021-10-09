
import 'package:authenticator/authenticator.dart';
import 'package:core/core.dart';
import 'package:dependences/dependences.dart';

class StoreRepository{
  Future create(Store user,  String email) async {
    final uid = await UserAuth().create(email, 'xxxxxx');
    return FirebaseFirestore.instance
        .collection(Store.collection)
        .doc(uid)
        .set(user.toMap());
  }
}