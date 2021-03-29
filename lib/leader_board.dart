import 'dart:convert';
import 'package:flutter/material.dart';
import 'models/player.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import './player_list.dart';
import './player_details.dart';

Future<List<Player>> fetchPlayers() async {
  final response = await http.get(Uri.https(
      'c2y956330l.execute-api.us-east-1.amazonaws.com', 'production/players'));

  List playersJson = jsonDecode(response.body);

  List<Player> playerList =
      playersJson.map((player) => Player.fromJson(player)).toList();

  return Future.value(playerList);
}

/// This is the stateful widget that the main application instantiates.
class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key key}) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

/// This is the private State class that goes with LeaderBoard.
class _LeaderBoardState extends State<LeaderBoard> {
  List<Player> allPlayers = [];
  Future<List<Player>> _futureGetPlayers;

  @override
  void initState() {
    // if we don't define this to be ran once, it will run every render
    // https://flutterigniter.com/future-async-called-multiple-times/
    _futureGetPlayers = fetchPlayers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureGetPlayers,
        builder: (BuildContext context, AsyncSnapshot<List<Player>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingWidget();
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else {
              return SingleChildScrollView(
                child: Container(
                    child: PlayerList(snapshot.data, (player) {
                  return PlayerDetails(player);
                })),
              );
            }
          }
        });
  }

  Widget loadingWidget() {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Retrieving Players',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              value: null,
              semanticsLabel: 'Linear progress indicator',
            ),
          ],
        ));
  }
}
