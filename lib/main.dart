import 'package:flutter/material.dart';
import 'package:leaderboard_ladder/leader_board.dart';

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
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              'Stonewall Tennis 2021',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatelessWidget {
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
