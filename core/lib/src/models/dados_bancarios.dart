enum TipoTransferencia {
  Pix,
  Conta,
}
// Quando não faz diferença qual dos dois é (na pratica, pode ser usado esse factory)
abstract class DadosBancarios {
  final TipoTransferencia type;
  DadosBancarios(this.type);

  factory DadosBancarios.fromMap(Map<String, dynamic> map) {
    switch (map['type']) {
      case 'TipoTransferencia.Pix':
        return Pix.fromMap(map);
      case 'TipoTransferencia.Conta':
        return Conta.fromMap(map);
      default:
    }
    return DadosBancarios.pix(map['chave']);
  }

  factory DadosBancarios.pix(String chave) => Pix(chave);

  factory DadosBancarios.conta(String banco, String agencia, String conta) =>
      Conta(banco, agencia, conta);

  Map<String, dynamic> toMap();

  String toString();
}

class Pix extends DadosBancarios {
  final String chave;
  //TODO: A chave pix pode ser telefone, cpf, email, etc....

  Pix(this.chave) : super(TipoTransferencia.Pix);

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

  Conta(this.banco, this.agencia, this.conta) : super(TipoTransferencia.Conta);

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
