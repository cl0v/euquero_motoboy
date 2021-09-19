
import 'address.dart';

class ClientModel {
  final String name;
  final String phone;
  final Address address;
  ClientModel({
    required this.name,
    required this.phone,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'address': address.toMap(),
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      name: map['name'],
      phone: map['phone'],
      address: Address.fromMap(map['address']),
    );
  }
}
