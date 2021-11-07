
import 'package:core/core.dart';

abstract class IHistoryRepository {
  /// Recebe a lista dos pedidos que ainda não foram solicitados o pagamento.
  Stream<List<Order>> get orders;

  /// Recebe a lista dos pagamentos (abertos e fechados).
  Future<List<Payment>> get payments;

  Future<void> requestPayment(Payment payment, List<Order> orders);
}
