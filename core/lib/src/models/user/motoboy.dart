
import '../dados_bancarios.dart';
import 'user.dart';


class Motoboy extends UserData {
  static const collection = 'motoboy';
  final String? placaDaMoto;

  Motoboy({
    required String name,
    required String cpf,
    required String phone,
    required String franchiseId,
    required double taxaCobrada,
    required DadosBancarios dadosBancarios,
    required this.placaDaMoto,
  }) : super(
          name: name,
          document: cpf,
          phone: phone,
          franchiseId: franchiseId,
          taxaCobrada: taxaCobrada,
          dadosBancarios: dadosBancarios,
        );

  // factory Motoboy.fromMap(Map<String, dynamic> map) {
  //   return Motoboy(
  //     name: map['name'],
  //     cpf: map['cpf'],
  //     phone: map['phone'],
  //     placaDaMoto: map['placaDaMoto'],
  //     taxaCobrada: map['taxaCobrada'],
  //     dadosBancarios: DadosBancarios.fromMap(map['dadosBancarios']),
  //   );
  // }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'cpf': document,
      'phone': phone,
      'franchiseId': franchiseId,
      'placaDaMoto': placaDaMoto,
      'taxaCobrada': taxaCobrada,
      'dadosBancarios': dadosBancarios.toMap(),
    };
  }
}


class MotoboyOrderInfo {
  MotoboyOrderInfo({
    required this.id,
    required this.name,
    required this.phone,
  });

  final String id;
  final String name;
  final String phone;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }

  factory MotoboyOrderInfo.fromMap(Map<String, dynamic> map) {
    return MotoboyOrderInfo(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
    );
  }

  
}
