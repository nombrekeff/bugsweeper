import 'package:bugsweeper/src/api/math.dart';
import 'package:bugsweeper/src/api/types.dart';

/// This class holds the logic and state of the Bugsweeper game
class Bugsweeper {
  final Set<Position> _openFields = {};
  final Set<Position> _bugFields = {};
  final Set<Position> _flagFields = {};

  final int width;
  final int height;
  final int bugCount;

  Bugsweeper({
    required this.width,
    required this.height,
    required this.bugCount,
  }) {
    assert(width >= 0, '"width" must be greater than 0');
    assert(height >= 0, '"height" must be greater than 0');
    assert(bugCount >= 0, '"mineCount" must be greater than 0');
    assert(
      bugCount < (width * height),
      'mineCount "$bugCount" cannot exceed the number of fields (${width * height})',
    );

    _generateBugs();
  }

  /// Returns the current amount of flagged cells
  int get flagCount => flagFields.length;

  Set<Position> get bugFields => _bugFields;
  Set<Position> get flagFields => _flagFields;
  Set<Position> get openFields => _openFields;

  /// Is the position currenty in the [bugFields] set
  bool isBugField(Position pos) => _bugFields.contains(pos);

  /// Is the position currenty in the [flagFields] set
  bool isFlagField(Position pos) => _flagFields.contains(pos);

  /// Is the position currenty in the [openFields] set
  bool isOpenField(Position pos) => _openFields.contains(pos);

  /// Is this position inside the width & height range provided
  bool isValidPosition(Position pos) => pos.inRange(width, height);

  /// Returns the items which are in [bugFields]
  Set<Position> getBugsFromSet(Set<Position> set) => set.where((pos) => isBugField(pos)).toSet();

  /// Returns the neighbors (3x3) of a field
  Set<Position> getNeighbors(Position pos) {
    Set<Position> neighbors = {};

    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        final neighbor = Position(pos.x + i, pos.y + j);

        if (isValidPosition(neighbor) && pos != neighbor) {
          neighbors.add(neighbor);
        }
      }
    }

    return neighbors;
  }

  /// Returns the current state of the game
  Set<FieldState> getState() {
    Set<FieldState> state = {};

    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        final pos = Position(i, j);
        var type = FieldType.closed;
        var mineNeighborsCount = 0;

        if (isFlagField(pos)) {
          type = FieldType.flag;
        }

        if (isOpenField(pos)) {
          if (isBugField(pos)) {
            type = FieldType.mine;
          } else {
            type = FieldType.open;
            mineNeighborsCount = getBugsFromSet(getNeighbors(pos)).length;
          }
        }

        state.add(
          FieldState(
            pos: pos,
            type: type,
            mineNeighbors: mineNeighborsCount,
          ),
        );
      }
    }

    return state;
  }

  /// Open (or uncover) a field,
  /// it returns a [Result] as to explain what happened when the cell
  /// was opened at a given position
  Result openField(Position pos) {
    if (!isValidPosition(pos)) {
      throw ArgumentError("Invalid position $pos");
    }

    // Check the flag first, as we don't want to open the flagged field
    if (isFlagField(pos) || isOpenField(pos)) return Result.noop;

    if (isBugField(pos)) {
      openFields.add(pos);

      // once a mine is uncovered, open the rest of the mines
      for (final neighbor in bugFields) {
        openFields.add(neighbor);
      }

      return Result.lose;
    }

    if (!isOpenField(pos)) {
      openFields.add(pos);

      final neighbors = getNeighbors(pos);
      final bugNeighbors = getBugsFromSet(neighbors);

      // If there is no bug neighbors, open the neighbors
      if (bugNeighbors.isEmpty) {
        for (final neighbor in neighbors) {
          openField(neighbor);
        }
      }
    }

    // Check for victory
    if (isVictory()) return Result.victory;

    return Result.op;
  }

  /// Checks if the current game is a win
  bool isVictory() {
    final totalFieldsCount = width * height;
    final remainingFields = totalFieldsCount - openFields.length;

    return remainingFields == bugCount;
  }

  /// Set/unset a flag at a given position
  bool toggleFlagField(Position pos) {
    if (!isValidPosition(pos)) {
      throw ArgumentError("Invalid position $pos");
    }
    if (isOpenField(pos)) return false;

    if (isFlagField(pos)) {
      _flagFields.remove(pos);
    } else {
      _flagFields.add(pos);
    }

    return true;
  }

  /// Reset the game
  void resetGame() {
    _flagFields.clear();
    _openFields.clear();
    _generateBugs();
  }

  /// Generates a [bugCount] amount of randomly positioned bugs
  void _generateBugs() {
    _bugFields.clear();
    while (_bugFields.length < bugCount) {
      final x = Math.getRandomInt(0, width);
      final y = Math.getRandomInt(0, height);
      final bugPos = Position(x, y);

      if (!_bugFields.contains(bugPos)) {
        _bugFields.add(bugPos);
      }
    }
  }
}

