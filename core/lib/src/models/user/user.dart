import '../dados_bancarios.dart';

// TODO: Passar o nome, telefone e taxa prak(Coisas em comum)
enum UserType { motoboy, store }
//o uid é o uid;

// O user nunca se preocupa com quem são as classes filhas.
abstract class UserData {

  /// Documento de identificação do usuário (CPF ou CNPJ)
  final String document;
  final String name;
  final String phone;
  final String franchiseId;
  final num taxaCobrada;
  final DadosBancarios dadosBancarios;

  UserData({
    required this.name,
    required this.document,
    required this.phone,
    required this.franchiseId,
    required this.taxaCobrada,
    required this.dadosBancarios,
  });

  /// Usado para cadastrar o usuário no servidor
  Map<String, dynamic> toMap();
}
