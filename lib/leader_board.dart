import 'dart:convert';

import 'package:flutter/material.dart';
import 'models/player.dart';
// import './models/playerData.dart' as allData;
import 'package:http/http.dart' as http;

// stores ExpansionPanel state information
class Item {
  Item({
    @required this.expandedValue,
    @required this.headerValue,
    this.isExpanded = false,
  });

  Widget expandedValue;
  Widget headerValue;
  bool isExpanded;
}

Future<List<Player>> fetchPlayers() async {
  final response = await http.get(Uri.https(
      'c2y956330l.execute-api.us-east-1.amazonaws.com', 'production/players'));

  List playersJson = jsonDecode(response.body);

  List<Player> playerList =
      playersJson.map((player) => Player.fromJson(player)).toList();

  return Future.value(playerList);
}

List<ExpansionTile> generatePlayerItemList(
    List<Player> allPlayers, BuildContext context) {
  final itemHeight = MediaQuery.of(context).size.height;
  final itemWidth = MediaQuery.of(context).size.width;

  var getGridItem = (String key, String value) {
    final snackBar = SnackBar(
      content: Text("$value copied to clipboard"),
    );
    var row = [
      Align(
          alignment: Alignment.centerLeft,
          child: Text(
            key,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      Align(
          alignment: Alignment.centerLeft,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: SelectableText(
                  value ?? "",
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                ),
              ),
              FittedBox(
                child: IconButton(
                  icon: Icon(Icons.copy),
                  color: Colors.grey,
                  iconSize: 16,
                  splashRadius: 18,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                ),
              )
            ],
          )),
    ];

    return value == "" || value == null ? [] : row;
  };

  return allPlayers.asMap().entries.map<ExpansionTile>((player) {
    var rank = player.key + 1;
    return ExpansionTile(
      title: Text("$rank ${player.value.name}"),
      initiallyExpanded: player.value.name == "Cody Stammer" ? true : false,
      children: [
        // SingleChildScrollView(child: Row(children: [Text('hi'), Text('hi')]))
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 550,
            maxWidth: 1200,
          ),
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: () {
              if (itemWidth > 1000)
                return 4;
              else if (itemWidth > 550)
                return 2;
              else
                return 1;
            }(),
            padding: const EdgeInsets.all(20.0),
            crossAxisSpacing: 10,
            mainAxisSpacing: 5,

            // https://stackoverflow.com/questions/48405123/how-to-set-custom-height-for-widget-in-gridview-in-flutter
            childAspectRatio: () {
              if (itemWidth > 1200)
                return 10 / 1;
              else if (itemWidth > 550)
                return itemHeight * 5 / itemWidth;
              else
                return itemHeight * 6 / itemWidth;
            }(),
            children: [
              ...getGridItem("Email: ", player.value.email),
              ...getGridItem("Phone: ", player.value.phone),
              ...getGridItem("Preferred Court Location: ",
                  player.value.preferredCourtLocation),
              ...getGridItem("Availability: ", player.value.availability),
              ...getGridItem("Skill Level: ", player.value.skillLevel)
            ],
          ),
        )
      ],
    );
  }).toList();
}

/// This is the stateful widget that the main application instantiates.
class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key key}) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

/// This is the private State class that goes with LeaderBoard.
class _LeaderBoardState extends State<LeaderBoard> {
  List<ExpansionTile> _playerTiles = [];
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
              this._playerTiles =
                  generatePlayerItemList(snapshot.data, context);
              return SingleChildScrollView(
                child: Container(
                  child: _buildPanel(),
                ),
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

  Widget _buildPanel() {
    return Column(
      children: [
        AppBar(
          title: Text("Stonewall Tennis 2021 Leaderboard"),
          centerTitle: true,
        ),
        ..._playerTiles,
      ],
    );
  }
}
