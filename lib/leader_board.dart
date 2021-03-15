import 'package:flutter/material.dart';
import 'models/player.dart';
import './models/playerData.dart' as allPlayerData;

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

List<ExpansionTile> generatePlayerItemList(List<Player> allPlayers) {
  return allPlayers.asMap().entries.map<ExpansionTile>((player) {
    return ExpansionTile(
      title: Text(player.value.name),
      children: [
        ListTile(
          // leading: Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 10)),
          title: SingleChildScrollView(
            child: Column(
              // https://stackoverflow.com/questions/51638176/under-which-circumstances-textalign-property-works-in-flutter
              children: [
                player.value.preferredCourtLocation != ""
                    ? SizedBox(
                        width: double.infinity,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text('Preferred Courts: '),
                              ),
                              Expanded(
                                  child: Text(
                                      player.value.preferredCourtLocation)),
                            ]),
                      )
                    : Container(),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: Text('Availability: ')),
                      Expanded(child: Text(player.value.availability))
                    ],
                  ),
                )
              ],
            ),
          ),
          trailing: Text(player.value.phone),
          // should figure out how to do this w/o intrinsic width
        ),
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
  final List<ExpansionTile> _data =
      generatePlayerItemList(allPlayerData.players);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return Column(
      children: [
        AppBar(
          title: Text("Stonewall Tennis 2021 Leaderboard"),
          centerTitle: true,
        ),
        ..._data
      ],
    );
  }
}
