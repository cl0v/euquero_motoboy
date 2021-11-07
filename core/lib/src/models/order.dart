import '../../core.dart';

/*
A criaçao de uma ordem é feita exclusivamente pela loja é um modelo exclusivo para tal
As ordens abertas são modelos exclusivos para o motoboy
 > O Motoboy tem acesso a diferentes tipos de modelos que definem eventos.

*/
//TODO: Fazer apenas um modelo de ordem aceita(Muitas informaçoes em comum, apenas revelar o cliente depois)

/// Criação da ordem pela loja
class Order {
  // Equivalente a pedidos entregues(Todos os dados preenchidos)
  static const String collection = 'orders';
  // Pedidos que não foram pagos e nem solicitado o pagamento.
  static const String paidCollection = 'paidOrders';
  // Pedidos que o pagamento foi solicitado.
  static const String requestPaymentCollection = 'paymentRequestOrders';
  // Equivalente a pedidos em aberto(Dados de entrega faltando)
  static const String opensCollection = 'openOrders';
  // Equivalente a pedidos aceitos(Alguns dados de entrega faltando)
  static const String acceptedCollection = 'acceptedOrders';

  late final String id;

  String? motoboy;
  late int? createdAt;
  late int? acceptedAt;
  late int? deliveredAt;

  final double valorPedido;
  final double valorFrete;
  final StoreOrderInfo store;
  final ClientModel client;

  Order({
    required this.valorPedido,
    required this.valorFrete,
    required this.store,
    required this.client,
    this.createdAt,
    this.acceptedAt,
    this.deliveredAt,
    this.motoboy,
  });

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
      'acceptedAt': acceptedAt,
      'deliveredAt': deliveredAt,
      'valorPedido': valorPedido,
      'valorFrete': valorFrete,
      'motoboy': motoboy,
      'store': store.toOrderMap(),
      'client': client.toMap(),
    };
  }

  factory Order.fromMap(String id, Map<String, dynamic> map) {
    return Order(
      valorPedido: map['valorPedido'],
      valorFrete: map['valorFrete'],
      store: StoreOrderInfo.fromOrderMap(map['store']),
      client: ClientModel.fromMap(map['client']),
      motoboy: map['motoboy'],
      createdAt: map['createdAt'],
      acceptedAt: map['acceptedAt'],
      deliveredAt: map['deliveredAt'],
    )..id = id;
  }
}

// /// Classe de leitura do motoboy
// abstract class OrderWithId {
//   final String id;
//   final OrderStatus status;

//   OrderWithId({
//     required this.status,
//     required this.id,
//   });
// }

// /// Informações sobre a ordem em aberto (Pode aceitar)
// class OpenOrder extends OrderWithId {
//   final StoreOrderInfo store;
//   double total;

//   OpenOrder({
//     required this.store,
//     required String id,
//     required this.total,
//   }) : super(id: id, status: OrderStatus.open);

// // Esse cara retorna um modelo para ser salvo no firebase
//   Map<String, dynamic> toMap(MotoboyOrderInfo motoboy) {
//     return {
//       'motoboy': motoboy.toMap(),
//       'status': OrderStatus.accepted.toString(),
//     };
//   }

//   factory OpenOrder.fromMap(Map<String, dynamic> map) {
//     return OpenOrder(
//       id: map['id'],
//       total:
//           ((map['valorPedido'] as num) + (map['valorFrete'] as num)).toDouble(),
//       store: StoreOrderInfo.fromMap(map['store']),
//     );
//   }
// }

// /// Informações sobre a ordem aceita (Pode aceitar)
// /// Esse cara não precisa existir, pois é a ordem aberta que irá enviar novas
// /// informações sobre o motoboy e momento em que foi aceita
// ///
// class AcceptedOrder extends OrderWithId {
//   ClientModel client;
//   StoreOrderInfo store;
//   double total;
//   //Adicionar o valor total também

//   AcceptedOrder({
//     required String id,
//     required this.client,
//     required this.store,
//     required this.total,
//   }) : super(id: id, status: OrderStatus.accepted);

//   Map<String, dynamic> delivered() {
//     return {
//       'status': OrderStatus.delivered.toString(),
//     };
//   }

//   factory AcceptedOrder.fromMap(Map<String, dynamic> map) {
//     return AcceptedOrder(
//       id: map['id'],
//       total: ((map['valor'] as num) + (map['frete'] as num)).toDouble(),
//       store: StoreOrderInfo.fromMap(map['store']),
//       client: ClientModel.fromMap(map['client']),
//     );
//   }
// }

// /// Modelo para uma ordem entregue
// class DeliveredOrder extends OrderWithId {
//   final ClientModel client;
//   final double total;
//   DeliveredOrder({
//     required String id,
//     required this.client,
//     required this.total,
//   }) : super(
//           id: id,
//           status: OrderStatus.delivered,
//         );

//   factory DeliveredOrder.fromMap(Map<String, dynamic> map) {
//     return DeliveredOrder(
//       id: map['id'],
//       total: ((map['valor'] as num) + (map['frete'] as num)).toDouble(),
//       client: ClientModel.fromMap(map['client']),
//     );
//   }
// }

/* Dados da ordem
 - valorPedido : num
 - valorFrete : num
 - status: enum OrderStatus
 - createdAt: Datetime
 - acceptedAt : Datetime
 - deliveredAt: Datetime
 - infoLoja : {...}
 - infoMotoboy : {...}
 - infoCliente : {...}

 >> Campos que serão preenchidos no form
  valorPedido : num
  infoCliente : {...}
*/
