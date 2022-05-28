import 'package:bugsweeper/src/widgets/buttons.dart';
import 'package:flutter/material.dart';

class Toolbar extends StatelessWidget {
  final Widget? child;

  const Toolbar({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.amber),
      height: 42,
      child: Padding(
        padding: const EdgeInsets.only(right: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Tooltip(
              message: 'Back to menu',
              child: CustomIconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 16),
                onPressed: () {
                  if (Navigator.canPop(context)) return Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
            ),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
