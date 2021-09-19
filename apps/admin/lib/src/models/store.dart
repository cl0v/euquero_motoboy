
import 'package:core/core.dart';

class Store extends UserData {

  final Address address;

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