

import '../dados_bancarios.dart';

// TODO: Passar o nome, telefone e taxa prak(Coisas em comum)
enum UserType { motoboy, store }
//o uid é o uid;

// O user nunca se preocupa com quem são as classes filhas.
abstract class UserData {
  static String userCollection = 'user';

  late String id;

  /// Documento de identificação do usuário (CPF ou CNPJ)
  final String document;
  final String name;
  final String phone;
  final num taxaCobrada;
  final DadosBancarios dadosBancarios;

  UserData({
    required this.name,
    required this.document,
    required this.phone,
    required this.taxaCobrada,
    required this.dadosBancarios,
  });


/// Usado para cadastrar o usuário no servidor
  Map<String, dynamic> toMap();

//TODO: Verificar onde esse cara está sendo usado
  get orderInfo;

//TODO: Fazer em cada um
  // Future createOnFirebase(String email) async {
  //   final uid = await UserAuth().create(email, 'xxxxxx');
  //   return FirebaseFirestore.instance
  //       .collection(userCollection)
  //       .doc(uid)
  //       .set(toMap());
  // }

  // static Future<Map<String, dynamic>> fromFirebaseAsMap(String uid) {
  //   return FirebaseFirestore.instance
  //       .collection(userCollection)
  //       .doc(uid)
  //       .get()
  //       .then((value) => value.data()!
  //         ..addEntries([
  //           MapEntry('id', value.id),
  //         ]));
  // }
}
