import 'package:flutter/material.dart';
import './models/playerData.dart' as allData;

generateContentText(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Align(alignment: Alignment.centerLeft, child: SelectableText(text)),
  );
}

class Rules extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          generateContentText(allData.RULES_CONTENT),
        ],
      ),
    );
  }
}
