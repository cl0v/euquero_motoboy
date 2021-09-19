import 'package:flutter_test/flutter_test.dart';

final map = {
  'cnpj': '231823813128',
  'phone': '3271731273',
  'dadosBancarios': {
    'chave': '123123123',
    'type': 'TipoTransferencia.Pix',
  },
  'taxaCobrada': 33,
  'address': {
    'rua': 'rua',
    'bairro': 'bairro',
    'cidade': 'Cambuquira',
    'pais': 'BR',
    'estado': 'MG',
    'numero': '01',
    'referencia': 'Casa'
  },
  'name': 'loja1',
  'id': 'XEkD1g7x17bFc2M4JULq6UlwTQl1'
};

main() {
  test('Store.fromMap', () {
    // Store store = Store.fromMap(map);
    // expect(store.name, 'loja1');
  });
}
