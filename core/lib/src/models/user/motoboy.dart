
import '../dados_bancarios.dart';
import 'user.dart';

/// Modelo que será usado para cadastrar o motoboy nos docs

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
