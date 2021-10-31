import 'package:core/core.dart';
import 'package:dependences/dependences.dart';
import 'package:flutter/material.dart';

class PendentMotoboyRegistrationsPage extends StatelessWidget {
  PendentMotoboyRegistrationsPage({Key? key, required this.id})
      : super(key: key);
  final String id;

  final r = Rep();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastros pendentes'),
      ),
      body: StreamBuilder<List<MotoboyOrderInfo>>(
        stream: r.pending(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final f = snapshot.data ?? [];
            return ListView.builder(
              itemCount: f.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(f[index].name),
                  trailing: ElevatedButton.icon(
                      onPressed: () {
                        r.aprove(id, f[index]);
                      },
                      icon: const Icon(Icons.check),
                      label: const Text('Aprovar')),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class Rep {
  final f = FirebaseFirestore.instance;

  Stream<List<MotoboyOrderInfo>> pending(String franchiseId) => f
      .collection(Franchise.collection)
      .doc(franchiseId)
      .collection(Motoboy.collection)
      .where('authorized', isEqualTo: false)
      .snapshots()
      .map((event) => event.docs
          .map((e) => MotoboyOrderInfo.fromMap(e.id, e.data(), franchiseId))
          .toList());

  aprove(String franchiseId, MotoboyOrderInfo motoboy) {
    f.collection(Motoboy.collection).doc(motoboy.id).set(motoboy.toMap());
    f
        .collection(Franchise.collection)
        .doc(franchiseId)
        .collection(Motoboy.collection)
        .doc(motoboy.id)
        .update({
      'authorized': true,
      'authorizedAt': Timestamp.now().millisecondsSinceEpoch,
    });
  }
}
