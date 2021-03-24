import 'package:flutter/material.dart';
import 'package:leaderboard_ladder/leader_board.dart';
import 'package:leaderboard_ladder/rules.dart';
import 'package:leaderboard_ladder/events.dart';

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
        length: 3,
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
              ],
            ),
          ),
          body: TabBarView(
            children: [LeaderBoardPage(), RulesPage(), EventsPage()],
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
