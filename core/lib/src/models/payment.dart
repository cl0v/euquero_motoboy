import 'dart:convert';

/// Pagamento para o motoboy e lojista com base no rendimento

class Payment {
  static const collection = 'payment';


  String id;
  final double valor;
  bool paid; // Status do pagamento
  final int createdAt;
  int? paidAt;

  Payment({
    required this.valor,
    this.paid = false,
    this.paidAt,
    this.id = '',
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'valor': valor,
      'paid': paid,
      'createdAt': createdAt,
      'paidAt': paidAt,
    };
  }

  factory Payment.fromMap(String id, Map<String, dynamic> map) {
    return Payment(
      id: id,
      valor: map['valor'],
      paid: map['paid'],
      createdAt: map['createdAt'],
      paidAt: map['paidAt'],
    );
  }
}
