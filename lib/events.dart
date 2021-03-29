import 'dart:convert';

import 'package:flutter/material.dart';
import './models/playerData.dart' as allData;
import 'package:http/http.dart' as http;
import './models/player.dart';

generateEventRow({date, description, location, style}) {
  return TableRow(
    decoration: BoxDecoration(),
    children: [
      TextButton(
          onPressed: () async {
            Future<http.Response> createPlayer(Player p) {
              return http.post(
                  Uri.https('c2y956330l.execute-api.us-east-1.amazonaws.com',
                      'production/players'),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(<String, String>{
                    'name': p.name,
                    'email': p.email,
                    'preferredCourtLocation': p.preferredCourtLocation,
                    'availability': p.availability,
                    'skillLevel': p.skillLevel
                  }));
            }

            // var data = await fetchPlayers();
            // print(data.body);
            allData.players.forEach((p) => createPlayer(p));
          },
          child: Text('hi')),
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
