import 'package:bugsweeper/src/widgets/menu_button.dart';
import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'BUGSWEEPER',
                style: textTheme.headline6
                    ?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey[800]),
              ),
              const Divider(),
              MenuButton(
                child: Text(
                  'Play',
                  style: textTheme.subtitle1,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/setup_game');
                },
              ),
              MenuButton(
                child: Text(
                  'About',
                  style: textTheme.subtitle1,
                ),
                onTap: () {},
              ),
              MenuButton(
                child: Text(
                  'Exit',
                  style: textTheme.subtitle1,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
