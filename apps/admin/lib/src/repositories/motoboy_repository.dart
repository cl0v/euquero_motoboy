import 'package:authenticator/authenticator.dart';
import 'package:core/core.dart';
import 'package:dependences/dependences.dart';

class MotoboyRepository{
  Future create(Motoboy user,  String email) async {
    final uid = await UserAuth().create(email, 'xxxxxx');
    return FirebaseFirestore.instance
        .collection(Motoboy.collection)
        .doc(uid)
        .set(user.toMap());
  }
}