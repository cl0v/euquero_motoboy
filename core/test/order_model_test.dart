import 'package:flutter_test/flutter_test.dart';

final map = {
  'id': 'x',
  'motoboy': null,
  'store': {
    'id': 'XEkD1g7x17bFc2M4JULq6UlwTQl1',
    'name': 'loja1',
    'address': {
      'numero': '01',
      'rua': 'rua',
      'pais': 'BR',
      'bairro': 'bairro',
      'cidade': 'Cambuquira',
      'referencia': 'Casa',
      'estado': 'MG'
    }
  },
  'client': {
    'address': {
      'estado': 'MG',
      'numero': '19',
      'pais': 'BR',
      'cidade': 'Cambuquira',
      'bairro': 'centro',
      'referencia': 'Casa',
      'rua': 'rua arlindo'
    },
    'name': 'marcelo',
    'phone': '231321'
  },
  'valorFrete': 4,
  'valorPedido': 37,
};

main() {
  test('order.fromMap', () {
    // Order order = Order.fromMotoboyServer(map);
    // expect(order.id, 'x');
  });
}
