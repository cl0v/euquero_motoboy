import 'package:flutter/material.dart';

class GlobalConfigsPage extends StatelessWidget {
  const GlobalConfigsPage({Key? key}) : super(key: key);

  onTaxaFixedChanged(String newTaxa) {}
  onTaxaVariavelChanged(String newTaxa) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações Globais'),
      ),
      body: ListView(
        children: [
          TappableListTile(
            title: 'Taxa Fixa',
            value: '4,00',
            onSaved: onTaxaFixedChanged,
          ),
          TappableListTile(
            title: 'Taxa Variável (Km adicional)',
            value: '0,10',
            onSaved: onTaxaVariavelChanged,
          ),
        ],
      ),
    );
  }
}

class TappableListTile extends StatefulWidget {
  const TappableListTile({
    Key? key,
    required this.value,
    required this.title,
    required this.onSaved,
  }) : super(key: key);
  final String title, value;
  final Function(String value) onSaved;

  @override
  _TappableListTileState createState() => _TappableListTileState();
}

class _TappableListTileState extends State<TappableListTile> {
  bool isEditMode = false;

  void changeToEditMode() {
    setState(() {
      isEditMode = true;
    });
  }

  onSave() {
    setState(() {
      isEditMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isEditMode
        ? ListTile(
            title: Text(widget.title),
            subtitle: const Text('Toque para realizar alterações'),
            trailing: Text(widget.value),
            onTap: changeToEditMode,
          )
        : Row(
            children: [
              Expanded(flex: 3, child: TextFormField()),
              Expanded(
                child: ElevatedButton(
                  onPressed: onSave,
                  child: const Text('Salvar'),
                ),
              ),
            ],
          );
  }
}
