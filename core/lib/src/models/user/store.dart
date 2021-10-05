
import '../address.dart';


class StoreOrderInfo {
  StoreOrderInfo({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
  });

  final String id;
  final String name;
  final String phone;
  final Address address;

  factory StoreOrderInfo.fromMap(Map<String, dynamic> map) {
    return StoreOrderInfo(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      address: Address.fromMap(map['address']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'address': address.toMap(),
    };
  }

  
}
