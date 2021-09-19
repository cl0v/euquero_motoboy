
import '../address.dart';
import '../dados_bancarios.dart';
import 'user.dart';

class Store extends UserData {
  Store({
    required String name,
    required String cnpj, // doc
    required String phone,
    required num taxaCobrada,
    required DadosBancarios dadosBancarios,
    required this.address,
  }) : super(
          name: name,
          document: cnpj,
          phone: phone,
          taxaCobrada: taxaCobrada,
          dadosBancarios: dadosBancarios,
        );

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      cnpj: map['cnpj'],
      name: map['name'],
      phone: map['phone'],
      address: Address.fromMap(map['address']),
      taxaCobrada: map['taxaCobrada'],
      dadosBancarios: DadosBancarios.fromMap(map['dadosBancarios']),
    )..id = map['id'];
  }

  final Address address;

  @override
  Map<String, dynamic> toMap() {
    return {
      'cnpj': document,
      'name': name,
      'phone': phone,
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
