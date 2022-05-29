import 'package:bugsweeper/src/api/types.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Position == operators works correctly', () {
    final pos1 = Position(1, 1);
    final pos2 = Position(1, 2);
    final pos3 = Position(1, 1);

    expect(pos1 == pos2, false);
    expect(pos1 == pos3, true);
  });
}
