import 'package:core/core.dart';
import 'package:motoboy/src/history/interface.dart';

class HistoryController {
  final IHistoryRepository repository;
  HistoryController({
    required this.repository,
  });

  Future<void> requestPayment(List<Order> itens) async {
    Payment payment = Payment(
        valor: itens.map((e) => e.valorFrete).fold(0, (a, b) => a + b),
        createdAt: DateTime.now().millisecondsSinceEpoch);

    await repository.requestPayment(payment, itens);
  }
}
