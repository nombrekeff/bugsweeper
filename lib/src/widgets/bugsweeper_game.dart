import 'package:bugsweeper/src/api/bugsweeper.dart';
import 'package:bugsweeper/src/api/types.dart';
import 'package:bugsweeper/src/dialogs/failed_dialog.dart';
import 'package:bugsweeper/src/dialogs/victory_dialog.dart';
import 'package:bugsweeper/src/widgets/bugsweeper_actions.dart';
import 'package:bugsweeper/src/widgets/bugsweeper_grid.dart';
import 'package:bugsweeper/src/widgets/toolbar.dart';
import 'package:bugsweeper/src/widgets/field.dart';
import 'package:flutter/material.dart';

class BugsweeperGame extends StatefulWidget {
  const BugsweeperGame({Key? key, required this.bugsweeper}) : super(key: key);

  final Bugsweeper bugsweeper;

  @override
  State<BugsweeperGame> createState() => _BugsweeperGameState();
}

class _BugsweeperGameState extends State<BugsweeperGame> {
  final double cellSize = 40;

  Bugsweeper get _bugsweeper => widget.bugsweeper;
  Set<FieldState> _gameState = {};
  bool _disableInput = false;

  @override
  void initState() {
    _gameState = _bugsweeper.getState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return IgnorePointer(
      ignoring: _disableInput,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Toolbar(
              child: BugsweeperToolbarActions(
                bugsweeper: _bugsweeper,
                resetButtonPressed: _playAgain,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: BugsweeperGrid(
                  width: _bugsweeper.width,
                  height: _bugsweeper.height,
                  cellSize: cellSize,
                  gridChildBuilder: (_, index) {
                    return _getWidgetForState(_gameState.elementAt(index));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getWidgetForState(FieldState state) {
    switch (state.type) {
      case FieldType.mine:
        return _buildBugField(state.pos);
      case FieldType.flag:
        return _buildFlagField(state.pos);
      case FieldType.open:
        return _buildOpenField(state.pos, state.mineNeighbors);
      case FieldType.closed:
      default:
        return _buildClosedField(state.pos);
    }
  }

  Widget _buildClosedField(Position pos) {
    return FieldWidget(
      onTap: () => _openField(pos),
      onLongPress: () => _toggleFlag(pos),
      decoration: fieldClosedDecoration,
    );
  }

  Widget _buildOpenField(Position pos, int mineNeighbors) {
    return FieldWidget(
      decoration: fieldOpenDecoration,
      child: Center(
        child: Text(
          mineNeighbors > 0 ? mineNeighbors.toString() : '',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildBugField(Position pos) {
    return FieldWidget(
      decoration: fieldBugDecoration,
      child: const Center(
        child: Icon(Icons.bug_report, color: Colors.red),
      ),
    );
  }

  Widget _buildFlagField(Position pos) {
    return FieldWidget(
      onLongPress: () => _toggleFlag(pos),
      decoration: fieldClosedDecoration,
      child: const Center(
        child: Icon(Icons.flag),
      ),
    );
  }

  void _render() {
    setState(() {
      _gameState = _bugsweeper.getState();
    });
  }

  void _playAgain() {
    _disableInput = false;
    _bugsweeper.resetGame();
    _render();
  }

  void _openField(Position pos) {
    final result = _bugsweeper.openField(pos);

    if (result == Result.lose) _showFailDialog();
    if (result == Result.victory) _showVictoryDialog();
    if (result != Result.noop) _render();
  }

  void _toggleFlag(Position pos) {
    _bugsweeper.toggleFlagField(pos);
    _render();
  }

  void _showFailDialog() async {
    setState(() => _disableInput = true);

    final bool? replay = await FailedDialog.open(context);

    if (replay == true) setState(_playAgain);
  }

  void _showVictoryDialog() async {
    setState(() => _disableInput = true);

    final bool? replay = await VictoryDialog.open(context);

    if (replay == true) setState(_playAgain);
  }
}
