import 'package:flutter/material.dart';
import 'models/player.dart';
import './models/playerData.dart' as allData;

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
                  value,
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

    return value == "" ? [] : row;
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
              // ...getGridItem(itemWidth.toString(), itemHeight.toString()),
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
  List<ExpansionTile> _data = [];

  @override
  Widget build(BuildContext context) {
    this._data = generatePlayerItemList(allData.players, context);
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
        ..._data,
      ],
    );
  }
}
