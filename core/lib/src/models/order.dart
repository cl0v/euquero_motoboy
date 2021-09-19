
import '../../core.dart';

/*
A criaçao de uma ordem é feita exclusivamente pela loja é um modelo exclusivo para tal
As ordens abertas são modelos exclusivos para o motoboy
 > O Motoboy tem acesso a diferentes tipos de modelos que definem eventos.

*/

enum OrderStatus {
  open,
  accepted,
  delivered,
}

/// Criação da ordem pela loja
class Order {
  static const String collection = 'order';

  
  final double valor;
  final double frete;
  final OrderStatus status;

  final StoreOrderInfo store;
  final ClientModel client;

  Order({
    required this.valor,
    required this.frete,
    required this.store,
    required this.client,
  })  : status = OrderStatus.open;

  Map<String, dynamic> toMap() {
    return {
      'valor': valor,
      'frete': frete,
      'status': status.toString(),
      'client': client.toMap(),
      'store': store.toMap(),
    };
  }
}

/// Classe de leitura do motoboy
abstract class OrderWithId {
  final String id;
  final OrderStatus status;

  OrderWithId({
    required this.status,
    required this.id,
  });
}

/// Informações sobre a ordem em aberto (Pode aceitar)
class OpenOrder extends OrderWithId {
  final StoreOrderInfo store;

  OpenOrder({
    required this.store,
    required String id,
  }) : super(id: id, status: OrderStatus.open);

// Esse cara retorna um modelo para ser salvo no firebase
  Map<String, dynamic> toMap(MotoboyOrderInfo motoboy) {
    return {
      'motoboy': motoboy.toMap(),
      'status': OrderStatus.accepted.toString(),
    };
  }

  factory OpenOrder.fromMap(Map<String, dynamic> map) {
    return OpenOrder(
      id: map['id'],
      store: StoreOrderInfo.fromMap(map['store']),
    );
  }
}

/// Informações sobre a ordem aceita (Pode aceitar)
/// Esse cara não precisa existir, pois é a ordem aberta que irá enviar novas
/// informações sobre o motoboy e momento em que foi aceita
///
class AcceptedOrder extends OrderWithId {
  ClientModel client;
  //Adicionar o valor total também

  AcceptedOrder({
    required String id,
    required this.client,
  }) : super(id: id, status: OrderStatus.accepted);

  Map<String, dynamic> delivered() {
    return {
      'status': OrderStatus.delivered.toString(),
    };
  }

  factory AcceptedOrder.fromMap(Map<String, dynamic> map) {
    return AcceptedOrder(
      id: map['id'],
      client: ClientModel.fromMap(map['client']),
    );
  }
}

/// Modelo para uma ordem entregue
class DeliveredOrder extends OrderWithId {
  DeliveredOrder({
    required String id,
  }) : super(
          id: id,
          status: OrderStatus.delivered,
        );
}

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
