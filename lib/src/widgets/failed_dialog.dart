import 'package:flutter/material.dart';

class FailedDialog extends StatelessWidget {
  static Future open(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      anchorPoint: Offset(MediaQuery.of(context).size.width * 0.5, 15),
      builder: (_) {
        return const FailedDialog();
      },
    );
  }

  const FailedDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      alignment: Alignment.topCenter,
      title: Text(
        'Ooopsy, you found a bug!',
        style: TextStyle(color: Colors.red[500] as Color),
      ),
      content: const Text(
        'You have lost the game, exit or play another round',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
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
