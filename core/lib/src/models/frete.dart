
class Frete {
  final num fixo;
  final num variavel;

  Frete({
    required this.fixo,
    required this.variavel,
  });

  // Valor total dado uma distancia em metros
  double valorTotal(double distance) {
    return fixo + (variavel * distance / 1000);
  }

  Map<String, dynamic> toMap() {
    return {
      'fixo': fixo,
      'variavel': variavel,
    };
  }

  factory Frete.fromMap(Map<String, dynamic> map) {
    return Frete(
      fixo: map['fixo'],
      variavel: map['variavel'],
    );
  }

  
}
