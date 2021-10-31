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
    required bool authorized,
    required double taxaCobrada,
    required DadosBancarios dadosBancarios,
    required this.placaDaMoto,
  }) : super(
          name: name,
          document: cpf,
          authorized: authorized,
          phone: phone,
          taxaCobrada: taxaCobrada,
          dadosBancarios: dadosBancarios,
        );

  Map<String, dynamic> toMotoboyOrderInfo(String franchiseId) {
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
      'authorized': authorized,
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
    // required this.franchiseId,
    required this.phone,
  });

  final String id;
  final String name;
  late final String franchiseId;

  final String phone;

  Map<String, dynamic> toOrderMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }

  factory MotoboyOrderInfo.fromOrderMap(Map<String, dynamic> map) {
    return MotoboyOrderInfo(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'franchiseId': franchiseId,
      'phone': phone,
    };
  }

  factory MotoboyOrderInfo.fromMap(
    String id,
    Map<String, dynamic> map, [
    String? franchiseId,
  ]) {
    return MotoboyOrderInfo(
      id: id,
      name: map['name'],
      phone: map['phone'],
    )..franchiseId = franchiseId ?? map['franchiseId'];
  }
}
