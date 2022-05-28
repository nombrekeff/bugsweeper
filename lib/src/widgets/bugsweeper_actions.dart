import 'package:bugsweeper/src/api/bugsweeper.dart';
import 'package:bugsweeper/src/widgets/buttons.dart';
import 'package:flutter/material.dart';

class BugsweeperToolbarActions extends StatelessWidget {
  const BugsweeperToolbarActions({
    Key? key,
    required this.bugsweeper,
    this.resetButtonPressed,
  }) : super(key: key);

  final VoidCallback? resetButtonPressed;
  final Bugsweeper bugsweeper;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (resetButtonPressed != null) _resetButton(),
        Tooltip(
          message: 'Flags placed',
          child: _makeChip(
            Icons.flag,
            bugsweeper.flagCount.toString(),
          ),
        ),
        const SizedBox(width: 12),
        Tooltip(
          message: 'Bugs in this game',
          child: _makeChip(
            Icons.bug_report,
            bugsweeper.bugCount.toString(),
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

  Widget _makeChip(IconData icon, String text) {
    return Chip(
      backgroundColor: Colors.white.withOpacity(0.8),
      label: Row(
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Text(text),
        ],
      ),
    );
  }

  Widget _resetButton() {
    return Tooltip(
      message: 'Reset game',
      child: CustomIconButton(
        icon: const Icon(Icons.refresh, size: 16),
        onPressed: resetButtonPressed,
      ),
    );
  }
}
