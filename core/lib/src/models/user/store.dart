
import '../address.dart';
import '../dados_bancarios.dart';
import 'user.dart';

class Store extends UserData {
static const collection = 'store';
  final Address address;

  Store({
    required String name,
    required String cnpj, // doc
    required String phone,
    required String franchiseId,
    required num taxaCobrada,
    required DadosBancarios dadosBancarios,
    required this.address,
  }) : super(
          name: name,
          document: cnpj,
          phone: phone,
          franchiseId: franchiseId,
          taxaCobrada: taxaCobrada,
          dadosBancarios: dadosBancarios,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'cnpj': document,
      'name': name,
      'phone': phone,
      'franchiseId': franchiseId,
      'address': address.toMap(),
      'taxaCobrada': taxaCobrada,
      'dadosBancarios': dadosBancarios.toMap(),
    };
  }
}

class StoreOrderInfo {
  StoreOrderInfo({
    required this.id,
    required this.name,
    required this.franchiseId,
    required this.phone,
    required this.address,
  });

  final String id;
  final String name;
  final String franchiseId;
  final String phone;
  final Address address;

  factory StoreOrderInfo.fromMap(Map<String, dynamic> map) {
    return StoreOrderInfo(
      id: map['id'],
      name: map['name'],
      franchiseId: map['franchiseId'],
      phone: map['phone'],
      address: Address.fromMap(map['address']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'franchiseId': franchiseId,
      'phone': phone,
      'address': address.toMap(),
    };
  }

  
}
