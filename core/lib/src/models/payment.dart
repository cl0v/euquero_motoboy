

enum PaymentMethod {
  Card,
  Cash,
  Others,
}

class Payment {
  double _precoSolicitado;
  double valorDoFrete;
  PaymentMethod method;

  Payment({
    required double precoSolicitado,
    required this.valorDoFrete,
    required this.method,
  }) : _precoSolicitado = precoSolicitado;

  Payment.cash(this._precoSolicitado, this.valorDoFrete)
      : method = PaymentMethod.Cash;
  Payment.card(this._precoSolicitado, this.valorDoFrete)
      : method = PaymentMethod.Card;

  double valorTotalCobrado() => _precoSolicitado + valorDoFrete;
}
