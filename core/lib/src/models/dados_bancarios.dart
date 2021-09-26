enum TipoTransferencia {
  pix,
  conta,
}
// Quando não faz diferença qual dos dois é (na pratica, pode ser usado esse factory)
abstract class DadosBancarios {
  final TipoTransferencia type;
  DadosBancarios(this.type);

  Map<String, dynamic> toMap();

}

class Pix extends DadosBancarios {
  final String chave;
  //TODO: A chave pix pode ser telefone, cpf, email, etc....

  Pix(this.chave) : super(TipoTransferencia.pix);

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type.toString(),
      'chave': chave,
    };
  }

  @override
  String toString() => 'Pix(chave: $chave)';

  factory Pix.fromMap(Map<String, dynamic> map) {
    return Pix(
      map['chave'],
    );
  }
}

class Conta extends DadosBancarios {
  final String banco;
  final String agencia;
  final String conta;

  Conta(this.banco, this.agencia, this.conta) : super(TipoTransferencia.conta);

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type.toString(),
      'banco': banco,
      'agencia': agencia,
      'conta': conta,
    };
  }

  @override
  String toString() => 'Conta(banco: $banco, agencia: $agencia, conta: $conta)';

  factory Conta.fromMap(Map<String, dynamic> map) {
    return Conta(
      map['banco'],
      map['agencia'],
      map['conta'],
    );
  }
}
