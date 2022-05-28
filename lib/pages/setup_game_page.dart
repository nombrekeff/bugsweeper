import 'package:bugsweeper/pages/game_page.dart';
import 'package:bugsweeper/src/api/bugsweeper.dart';
import 'package:bugsweeper/src/api/difficulty.dart';
import 'package:bugsweeper/src/widgets/menu_button.dart';
import 'package:flutter/material.dart';

class SetupGamePage extends StatelessWidget {
  final bugsweeper = Bugsweeper(
    width: 10,
    height: 10,
    bugCount: 10,
  );

  SetupGamePage({Key? key}) : super(key: key);

  startGameWithDifficulty(BuildContext context, Difficulty difficulty) {
    Navigator.pushNamed(
      context,
      GamePage.routeName,
      arguments: difficulty,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'SELECT DIFFICULTY',
                style: textTheme.headline6
                    ?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[800]),
              ),
              const Divider(),
              MenuButton(
                child: Text(
                  'ETRAEASY',
                  style: textTheme.subtitle1,
                ),
                onTap: () {
                  startGameWithDifficulty(context, Difficulty.extraeasy);
                },
              ),
              MenuButton(
                child: Text(
                  'EASY',
                  style: textTheme.subtitle1,
                ),
                onTap: () {
                  startGameWithDifficulty(context, Difficulty.easy);
                },
              ),
              MenuButton(
                child: Text(
                  'MEDIUM',
                  style: textTheme.subtitle1,
                ),
                onTap: () {
                  startGameWithDifficulty(context, Difficulty.medium);
                },
              ),
              MenuButton(
                child: Text(
                  'HARD',
                  style: textTheme.subtitle1,
                ),
                onTap: () {
                  startGameWithDifficulty(context, Difficulty.hard);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
