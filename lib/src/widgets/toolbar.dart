import 'package:bugsweeper/src/api/bugsweeper.dart';
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
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 16),
                  splashRadius: 18,
                  onPressed: () {
                    if (Navigator.canPop(context)) return Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
              ),
            ),
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}

class BugsweeperToolbar extends StatelessWidget {
  final Bugsweeper bugsweeper;
  const BugsweeperToolbar({Key? key, required this.bugsweeper}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Toolbar(
      child: _counters(),
    );
  }

  Widget _counters() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Tooltip(
          message: 'Flags placed',
          child: Chip(
            backgroundColor: Colors.white.withOpacity(0.8),
            label: Row(
              children: [
                const Icon(Icons.flag, size: 16),
                const SizedBox(width: 4),
                Text(bugsweeper.flagCount.toString()),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Tooltip(
          message: 'Bugs in this game',
          child: Chip(
            backgroundColor: Colors.white.withOpacity(0.8),
            label: Row(
              children: [
                const Icon(Icons.bug_report, size: 16),
                const SizedBox(width: 4),
                Text(bugsweeper.bugCount.toString()),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Tooltip(
          message: 'Click to uncover a cell, long click to flag a cell',
          child: Icon(
            Icons.help,
            size: 16,
          ),
        )
      ],
    );
  }
}
