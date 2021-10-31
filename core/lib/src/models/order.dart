import '../../core.dart';

/*
A criaçao de uma ordem é feita exclusivamente pela loja é um modelo exclusivo para tal
As ordens abertas são modelos exclusivos para o motoboy
 > O Motoboy tem acesso a diferentes tipos de modelos que definem eventos.

*/
//TODO: Fazer apenas um modelo de ordem aceita(Muitas informaçoes em comum, apenas revelar o cliente depois)
enum OrderStatus {
  open,
  accepted,
  delivered,
}

/// Criação da ordem pela loja
class Order {
  static const String collection = 'order';

  late final String id;

  final double valorPedido;
  final double valorFrete;
  final OrderStatus status;
  final StoreOrderInfo store;
  final ClientModel client;

  Order({
    required this.valorPedido,
    required this.valorFrete,
    required this.store,
    required this.client,
    OrderStatus? status,
  }) : status = status ?? OrderStatus.open;

  Map<String, dynamic> toMap() {
    return {
      'valorPedido': valorPedido,
      'valorFrete': valorFrete,
      'status': status.index,
      'store': store.toOrderMap(),
      'client': client.toMap(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      valorPedido: map['valorPedido'],
      valorFrete: map['valorFrete'],
      status: OrderStatus.values[map['status']],
      store: StoreOrderInfo.fromOrderMap(map['store']),
      client: ClientModel.fromMap(map['client']),
    )..id = map['id'];
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
