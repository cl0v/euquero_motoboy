import 'package:core/core.dart';
import 'interface.dart';

class HistoryController {
  final IHistoryRepository repository;
  HistoryController({
    required this.repository,
  });

  Future<void> requestPayment(List<Order> itens) async {
    Payment payment = Payment(
        valor: itens.map((e) => e.valorPedido).fold(0, (a, b) => a + b),
        createdAt: DateTime.now().millisecondsSinceEpoch);

    await repository.requestPayment(payment, itens);
  }
}
