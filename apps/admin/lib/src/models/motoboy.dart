
import 'package:core/core.dart';

class Motoboy extends UserData {
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
      'placaDaMoto': placaDaMoto,
      'taxaCobrada': taxaCobrada,
      'dadosBancarios': dadosBancarios.toMap(),
    };
  }
  
}