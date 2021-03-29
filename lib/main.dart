import 'package:flutter/material.dart';
import 'package:leaderboard_ladder/leader_board.dart';
import 'package:leaderboard_ladder/rules.dart';
import 'package:leaderboard_ladder/events.dart';
import 'package:leaderboard_ladder/admin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stonewall Tennis 2021 Leaderboard',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(color: Colors.white, fontSize: 20))),
      ),
      home: DefaultTabController(
        length: 4,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Tennis Hub"),
            bottom: TabBar(
              labelColor: Colors.white,
              tabs: [
                Tab(
                    text: "Leaderboard",
                    icon: Icon(Icons.sports_tennis_rounded)),
                Tab(text: "Rules", icon: Icon(Icons.rule_rounded)),
                Tab(text: "Upcoming Events", icon: Icon(Icons.calendar_today)),
                Tab(text: "Admin", icon: Icon(Icons.admin_panel_settings))
              ],
            ),
          ),
          body: TabBarView(
            children: [
              LeaderBoardPage(),
              RulesPage(),
              EventsPage(),
              AdminPage()
            ],
          ),
        ),
      ),
    );
  }
}

class RulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.height * .05,
          vertical: screenSize.height * .02),
      child: Center(
          child: Container(width: screenSize.width * .8, child: Rules())),
    );
  }
}

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.height * .05,
          vertical: screenSize.height * .02),
      child: Center(
          child: Container(width: screenSize.width * .8, child: Admin())),
    );
  }
}

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenSize.height * .05,
          vertical: screenSize.height * .02),
      child: Center(
          child: Container(width: screenSize.width * .8, child: Events())),
    );
  }
}

class LeaderBoardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(screenSize.height * .05),
      child: Center(
          child: Container(width: screenSize.width * .8, child: LeaderBoard())),
    );
  }
}
