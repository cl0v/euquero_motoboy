import 'dart:convert';

import '../dados_bancarios.dart';
import 'user.dart';

class Motoboy extends UserData {
  static const collection = 'motoboy';
  final String? placaDaMoto;

  Motoboy({
    required String name,
    required String cpf,
    required String phone,
    required double taxaCobrada,
    required DadosBancarios dadosBancarios,
    required this.placaDaMoto,
  }) : super(
          name: name,
          document: cpf,
          phone: phone,
          taxaCobrada: taxaCobrada,
          dadosBancarios: dadosBancarios,
        );

  Map<String, dynamic> toMotoboyOrderInfo() {
    return {
      'name': name,
      'phone': phone,
      'franchiseId': franchiseId,
    };
  }

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
    required this.franchiseId,
    required this.phone,
  });

  final String id;
  final String name;
  final String franchiseId;

  final String phone;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'franchiseId': franchiseId,
      'phone': phone,
    };
  }

  factory MotoboyOrderInfo.fromMap(Map<String, dynamic> map) {
    return MotoboyOrderInfo(
      id: map['id'],
      name: map['name'],
      franchiseId: map['franchiseId'],
      phone: map['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MotoboyOrderInfo.fromJson(String source) =>
      MotoboyOrderInfo.fromMap(json.decode(source));
}
