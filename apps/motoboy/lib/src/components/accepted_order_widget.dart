import 'package:flutter/material.dart';

class AcceptedOrderTileWidget extends StatelessWidget {
  const AcceptedOrderTileWidget(
      {Key? key,
      required this.storeTitle,
      required this.storeAddress,
      required this.clientTitle,
      required this.clientAddress,
      required this.total,
      required this.onPressed})
      : super(key: key);
  final String storeTitle;
  final String storeAddress;
  final String clientTitle;
  final String clientAddress;
  final String total;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width - 10,
        height: 220,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text("Aceito"),
                    ),
                  ),
                  NewText(
                    text: "Valor: R\$$total",
                    size: 15,
                    color: Colors.black,
                    bold: FontWeight.bold,
                  ),
                ],
              ),
              Divider(
                height: 10,
              ),
              NewText(
                text: "Endereço de coleta:",
                size: 16,
                color: Colors.orange,
                bold: FontWeight.bold,
              ),
              Divider(
                height: 4,
              ),
              NewText(
                text: "Loja: $storeTitle",
                size: 15,
                color: Colors.black,
              ),
              NewText(
                text: "Pegar: $storeAddress",
                size: 15,
                color: Colors.black,
              ),
              Divider(
                height: 15,
              ),
              NewText(
                text: "Endereço de entrega:",
                size: 16,
                color: Colors.orange,
                bold: FontWeight.bold,
              ),
              Divider(
                height: 10,
              ),
              NewText(
                text: "$clientTitle",
                size: 15,
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NewText(
                    text: "Entregar: $clientAddress",
                    size: 15,
                    color: Colors.black,
                  ),
                  ElevatedButton(
                    onPressed: onPressed,
                    child: NewText(
                      text: "entregar",
                      color: Colors.white,
                      bold: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
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
