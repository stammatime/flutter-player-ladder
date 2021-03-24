import 'package:flutter/material.dart';
import './models/playerData.dart' as allData;

generateEventRow({date, description, location, style}) {
  return TableRow(
    decoration: BoxDecoration(),
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SelectableText(date, style: style),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SelectableText(description, style: style),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SelectableText(location, style: style),
      ),
    ],
  );
}

generateEventTable() {
  return Table(
    border: TableBorder.all(),
    columnWidths: {
      0: FlexColumnWidth(),
      1: FlexColumnWidth(),
      2: FlexColumnWidth(),
    },
    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
    children: [
      generateEventRow(
          date: 'Date',
          description: 'Description',
          location: 'Location',
          style: TextStyle(fontWeight: FontWeight.bold)),
      ...allData.events.map((event) {
        return generateEventRow(
            date: event.date,
            location: event.location,
            description: event.description);
      })
    ],
  );
}

class Events extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [generateEventTable()],
      ),
    );
  }
}
