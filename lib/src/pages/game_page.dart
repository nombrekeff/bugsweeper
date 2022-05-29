import 'package:bugsweeper/src/api/bugsweeper.dart';
import 'package:bugsweeper/src/api/difficulty.dart';
import 'package:bugsweeper/src/widgets/bugsweeper_game.dart';
import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  static String routeName = '/play';
  final Bugsweeper bugsweeper;

  GamePage({
    Key? key,
    Difficulty difficulty = Difficulty.easy,
  })  : bugsweeper = Bugsweeper(
          width: difficulty.width,
          height: difficulty.height,
          bugCount: difficulty.bugCount,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BugsweeperGame(
          bugsweeper: bugsweeper,
        ),
      ),
    );
  }
}
