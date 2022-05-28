/// Represents the type of a field
enum FieldType {
  mine,
  flag,
  open,
  closed,
}

/// Represents the result of opening a field
///
/// Once the player uncovers a field, it can result in a couple of scenarios:
/// 1. The uncovered cell is a Bug, in that case the player loses ([Result.lose])
/// 2. The uncovered cell is not a Bug ([Result.op])
/// 3. The uncovered cell is flagged or already uncovered ([Result.noop])
/// 4. If the only cells left uncovered are Bugs, the player wins ([Result.victory])
enum Result {
  lose,
  victory,
  op,
  noop,
}

/// Class holding the state for a field.
class FieldState {
  final FieldType type;
  final Position pos;
  final int mineNeighbors;

  FieldState({
    required this.type,
    required this.pos,
    this.mineNeighbors = 0,
  });
}

/// Represents a 2d coordinate
class Position {
  final int x;
  final int y;

  Position(this.x, this.y);

  @override
  int get hashCode => Object.hash(x, y).hashCode;

  @override
  bool operator ==(dynamic other) {
    return other is Position && other.x == x && other.y == y;
  }

  bool inRange(int width, int height) {
    return (x >= 0 && x < width) && (y >= 0 && y < height);
  }

  @override
  String toString() {
    return '($x, $y)';
  }
}
