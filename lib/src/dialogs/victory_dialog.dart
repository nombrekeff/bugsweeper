import 'package:bugsweeper/src/pages/start_page.dart';
import 'package:flutter/material.dart';

class VictoryDialog extends StatelessWidget {
  static Future open(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const VictoryDialog();
      },
    );
  }

  const VictoryDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('You won the game!'),
      content: const Text(
        'You have found all the bugs!',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName(StartPage.routeName));
          },
          child: const Text('EXIT'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text('PLAY AGAIN'),
        ),
      ],
    );
  }
}
