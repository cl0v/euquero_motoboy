import 'package:flutter/material.dart';

class RequestField extends StatelessWidget {
  const RequestField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Colors.black45,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TagWidget(),
                Text(
                  'Valor: 80,00',
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Padaria NSA'),
            subtitle: Text('Pegar: Rua alvares cabral 132 - Cambuquira'),
          ),
          ListTile(
            title: Text('Renato Fernando da Silva'),
            subtitle: Text('Entregar: Rua Benjamin constant 70 B'),
            trailing:
                ElevatedButton(onPressed: () {}, child: Text('Encerrar')),
          )
        ],
      ),
    );
  }
}

class TagWidget extends StatelessWidget {
  const TagWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
      color: Colors.red,
      ),
      child: Text(
        '  ACEITO  ',
      ),
    );
  }
}

class NewText extends StatelessWidget {
  final text;
  final color;
  final size;
  final bold;

  const NewText({Key? key, this.text, this.color, this.size, this.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: size, fontWeight: bold),
    );
  }
}

class AcceptedField extends StatelessWidget {
  const AcceptedField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {},
        child: Ink(
          width: MediaQuery.of(context).size.width - 10,
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NewText(
                  text: "Endereço de entrega:",
                  size: 16,
                  color: Colors.orange,
                  bold: FontWeight.bold,
                ),
                Divider(
                  height: 4,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NewText(
                      text: "Rua Benjamin constant 70 B",
                      size: 15,
                      color: Colors.black,
                    ),
                    NewText(
                      text: "Entregar: Renato Ikeuchi",
                      size: 15,
                      color: Colors.black,
                    ),
                  ],
                ),
                Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NewText(
                      text: "Rua Benjamin constant 70 B",
                      size: 15,
                      color: Colors.black,
                    ),
                    NewText(
                      text: "Entregar: Renato Ikeuchi",
                      size: 15,
                      color: Colors.black,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
