class Address {
  double lat, long;
  final String numero, rua, bairro, referencia, cidade, estado, pais;
// 21° 51' 14" S / 45° 16' 18" W
  Address({
    required this.numero,
    required this.rua,
    required this.bairro,
    this.referencia = 'Casa',
    this.cidade = 'Cambuquira',
    this.estado = 'MG',
    this.pais = 'BR',
    double? lat,
    long,
  })  : this.lat = lat ?? -21.865733,
        this.long = long ?? -45.261857;

  Map<String, dynamic> toMap() {
    return {
      'numero': numero,
      'rua': rua,
      'bairro': bairro,
      'referencia': referencia,
      'cidade': cidade,
      'estado': estado,
      'pais': pais,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      numero: map['numero'],
      rua: map['rua'],
      bairro: map['bairro'],
      referencia: map['referencia'],
      cidade: map['cidade'],
      estado: map['estado'],
      pais: map['pais'],
    );
  }

  @override
  String toString() {
    return '$rua, $numero - $bairro';
  }
}
