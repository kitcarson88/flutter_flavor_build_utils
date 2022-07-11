import 'package:flutter/material.dart';

class BuildTile extends StatelessWidget {
  final String chiave, valore;

  const BuildTile({
    super.key,
    required this.chiave,
    required this.valore,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: <Widget>[
            Text(
              '$chiave ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(valore)
          ],
        ),
      );
}
