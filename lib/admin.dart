import 'dart:convert';

import 'package:flutter/material.dart';
import './models/playerData.dart' as allData;
import 'package:http/http.dart' as http;
import './models/player.dart';
import './player_list.dart';
import './models/playerData.dart' as data;

Future<http.Response> createPlayer(Player p) {
  print(jsonEncode(p));
  return http.post(
      Uri.https(
        'c2y956330l.execute-api.us-east-1.amazonaws.com',
        'production/players',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(p));
}

class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextButton(
              onPressed: () async {
                createPlayer(allData.players[0]);
              },
              child: Text('Create Single Player')),
          TextButton(
              onPressed: () async {
                allData.players.forEach((p) => createPlayer(p));
              },
              child: Text('Populate Default Players')),
        ],
      ),
    );
  }
}
