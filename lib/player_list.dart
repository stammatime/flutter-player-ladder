import 'package:flutter/material.dart';
import './models/player.dart';

class PlayerList extends StatefulWidget {
  final List<Player> players;
  final Function getDetailsWidget;

  PlayerList(this.players, this.getDetailsWidget);

  @override
  _PlayerListState createState() => _PlayerListState(players, getDetailsWidget);
}

class _PlayerListState extends State<PlayerList> {
  final List<Player> players;
  final Function getDetailsWidget;

  _PlayerListState(this.players, this.getDetailsWidget);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      children: [
        AppBar(
          title: Text("Stonewall Tennis 2021 Leaderboard"),
          centerTitle: true,
        ),
        ...generatePlayerList(context, players, getDetailsWidget)
      ],
    );
  }
}

List<ExpansionTile> generatePlayerList(
    BuildContext context, List<Player> allPlayers, Function detailsWidget) {
  return allPlayers.map<ExpansionTile>((player) {
    return ExpansionTile(
      title: Text("${player.rank} ${player.name}"),
      initiallyExpanded: player.name == "Cody Stammer" ? true : false,
      children: [
        detailsWidget(player),
      ], // we can show different options if isAdmin
    );
  }).toList();
}
