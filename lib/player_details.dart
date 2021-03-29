import 'package:flutter/material.dart';
import './models/player.dart';
import 'package:flutter/services.dart';

Widget getPlayerInfoPanel(context, Player player) {
  final itemHeight = MediaQuery.of(context).size.height;
  final itemWidth = MediaQuery.of(context).size.width;
  var getGridItem = (String key, String value) {
    final snackBar = SnackBar(
      content: Text("$value copied to clipboard"),
    );
    var singleDataPoint = [
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
                    Clipboard.setData(ClipboardData(text: value));
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
                    Clipboard.setData(ClipboardData(text: value));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                ),
              )
            ],
          )),
    ];

    return value == "" || value == null ? [] : singleDataPoint;
  };

  return ConstrainedBox(
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
        ...getGridItem("id: ", player.id),
        ...getGridItem("Email: ", player.email),
        ...getGridItem("Phone: ", player.phone),
        ...getGridItem(
            "Preferred Court Location: ", player.preferredCourtLocation),
        ...getGridItem("Availability: ", player.availability),
        ...getGridItem("Skill Level: ", player.skillLevel),
      ],
    ),
  );
}

class PlayerDetails extends StatelessWidget {
  Player player;

  PlayerDetails(this.player);

  @override
  Widget build(BuildContext context) {
    return getPlayerInfoPanel(context, player);
  }
}
