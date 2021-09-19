import 'package:authenticator/authenticator.dart';
import 'package:core/core.dart';
import 'package:dependences/dependences.dart';

import 'models/motoboy.dart';
import 'models/store.dart';

class Repository{
  Future createMotoboy(Motoboy motoboy,  String email) async {
    final uid = await UserAuth().create(email, 'xxxxxx');
    return FirebaseFirestore.instance
        .collection(UserData.userCollection)
        .doc(uid)
        .set(motoboy.toMap());
  }
  
  Future createStore(Store store,  String email) async {
    final uid = await UserAuth().create(email, 'xxxxxx');
    return FirebaseFirestore.instance
        .collection(UserData.userCollection)
        .doc(uid)
        .set(store.toMap());
  }
}