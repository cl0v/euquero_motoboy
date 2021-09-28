import 'package:authenticator/authenticator.dart';
import 'package:core/core.dart';
import 'package:dependences/dependences.dart';

class Repository{
  
  Future create(UserData user,  String email) async {
    final uid = await UserAuth().create(email, 'xxxxxx');
    return FirebaseFirestore.instance
        .collection(UserData.userCollection)
        .doc(uid)
        .set(user.toMap());
  }
}