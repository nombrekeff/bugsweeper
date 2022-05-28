import 'package:bugsweeper/src/api/types.dart';
import 'package:bugsweeper/src/widgets/bugsweeper_toolbar.dart';
import 'package:bugsweeper/src/widgets/victory_dialog.dart';
import 'package:flutter/material.dart';
import 'package:bugsweeper/src/api/bugsweeper.dart';
import 'package:bugsweeper/src/widgets/failed_dialog.dart';
import 'package:bugsweeper/src/widgets/bugsweeper_grid.dart';

class BugsweeperGame extends StatefulWidget {
  final Bugsweeper bugsweeper;

  const BugsweeperGame({
    Key? key,
    required this.bugsweeper,
  }) : super(key: key);

  @override
  State<BugsweeperGame> createState() => _BugsweeperGameState();
}

class _BugsweeperGameState extends State<BugsweeperGame> {
  final double cellSize = 40;

  Bugsweeper get _bugsweeper => widget.bugsweeper;
  Set<FieldState> gameState = {};
  bool _disableInput = false;

  @override
  void initState() {
    gameState = _bugsweeper.getState();
    super.initState();
  }

  _render() {
    setState(() {
      gameState = _bugsweeper.getState();
    });
  }

  _playAgain() {
    _disableInput = false;
    _bugsweeper.resetGame();
    _render();
  }

  void _openField(Position pos) {
    final result = _bugsweeper.openField(pos);

    if (result == Result.lose) {
      _mineExploded();
    }
    if (result == Result.victory) {
      _victory();
    }

    if (result != Result.noop) _render();
  }

  void _toggleFlag(Position pos) {
    _bugsweeper.toggleFlagField(pos);
    _render();
  }

  void _mineExploded() async {
    setState(() {
      _disableInput = true;
    });

    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      FailedDialog.open(context).then((replay) {
        if (replay == true) {
          setState(_playAgain);
        }
      });
    });
  }

  void _victory() async {
    setState(() {
      _disableInput = true;
    });

    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      VictoryDialog.open(context).then((replay) {
        if (replay == true) {
          setState(_playAgain);
        }
      });
    });
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
            BugsweeperToolbar(bugsweeper: _bugsweeper),
            const SizedBox(height: 8),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: BugsweeperGrid(
                  width: _bugsweeper.width,
                  height: _bugsweeper.height,
                  cellSize: 40,
                  gridChildBuilder: (BuildContext context, Position pos, index) {
                    return _getWidgetForState(gameState.elementAt(index));
                    // return _getWidgetForPos(pos);
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
        return _mineField(state.pos);
      case FieldType.flag:
        return _flagField(state.pos);
      case FieldType.open:
        return _openedField(state.pos, state.mineNeighbors);
      case FieldType.closed:
      default:
        return _closedField(state.pos);
    }
  }

  Widget _closedField(Position pos) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _openField(pos),
        onLongPress: () => _toggleFlag(pos),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }

  Widget _openedField(Position pos, int mineNeighbors) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey[400] as Color),
      ),
      child: Center(
        child: Text(
          mineNeighbors > 0 ? mineNeighbors.toString() : '',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _mineField(Position pos) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.red[400] as Color),
      ),
      child: const Center(
        child: Icon(Icons.bug_report),
      ),
    );
  }

  Widget _flagField(Position pos) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTertiaryTapUp: (_) => _toggleFlag(pos),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Center(
            child: Icon(Icons.flag),
          ),
        ),
      ),
    );
  }
}
