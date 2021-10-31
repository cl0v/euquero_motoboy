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
    required bool authorized,
    required num taxaCobrada,
    required DadosBancarios dadosBancarios,
    required this.address,
  }) : super(
          name: name,
          document: cnpj,
          phone: phone,
          authorized: authorized,
          taxaCobrada: taxaCobrada,
          dadosBancarios: dadosBancarios,
        );

  Map<String, dynamic> toStoreOrderInfo(String franchiseId) {
    return {
      'name': name,
      'franchiseId': franchiseId,
      'phone': phone,
      'address': address.toMap(),
    };
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'cnpj': document,
      'name': name,
      'phone': phone,
      'authorized': authorized,
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
  late final String franchiseId;
  final String phone;
  final Address address;

  /// Recebido na hora de se logar (top-level)
  factory StoreOrderInfo.fromMap(String id, Map<String, dynamic> map,
      [String? franchiseId]) {
    return StoreOrderInfo(
      id: id,
      name: map['name'],
      phone: map['phone'],
      address: Address.fromMap(map['address']),
    )..franchiseId = franchiseId ?? map['franchiseId'];
  }

  /// Enviado na hora de cadastrar (top-level)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'franchiseId': franchiseId,
      'phone': phone,
      'address': address.toMap(),
    };
  }

  /// Recebe o mapa dentro do pedido
  factory StoreOrderInfo.fromOrderMap(Map<String, dynamic> map) {
    return StoreOrderInfo(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      address: Address.fromMap(map['address']),
    );
  }

  /// Envia dentro do pedido
  Map<String, dynamic> toOrderMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'address': address.toMap(),
    };
  }
}
