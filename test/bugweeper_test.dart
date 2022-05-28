import 'package:bugsweeper/src/api/types.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bugsweeper/src/api/bugsweeper.dart';

void main() {
  group('Bugsweeper assertions', () {
    test('bugCount exceeds max throws AssertionError', () {
      createBugsweeper() => Bugsweeper(
            height: 10,
            width: 10,
            bugCount: 120,
          );

      expect(createBugsweeper, throwsA(isInstanceOf<AssertionError>()));
    });

    test('bugCount throws AssertionError if width <= 0', () {
      createBugsweeper() => Bugsweeper(
            height: 10,
            width: 0,
            bugCount: 120,
          );

      expect(createBugsweeper, throwsA(isInstanceOf<AssertionError>()));
    });

    test('bugCount throws AssertionError if height <= 0', () {
      createBugsweeper() => Bugsweeper(
            height: 0,
            width: 10,
            bugCount: 120,
          );

      expect(createBugsweeper, throwsA(isInstanceOf<AssertionError>()));
    });

    test('doesnt throws AssertionError if values are correct', () {
      createBugsweeper() => Bugsweeper(
            height: 10,
            width: 10,
            bugCount: 10,
          );

      expect(createBugsweeper, isNot(throwsA(isInstanceOf<AssertionError>())));
    });
  });

  group('Bugsweeper generation', () {
    test('generates correct amount of bugs', () {
      final ms = Bugsweeper(
        height: 10,
        width: 10,
        bugCount: 10,
      );
      final bugs = ms.bugFields;

      expect(bugs.length, 10);
    });
  });

  group('Bugsweeper open fields', () {
    test('throws error if position is not correct', () {
      final ms = Bugsweeper(height: 10, width: 10, bugCount: 10);
      final pos = Position(-1, 345);

      expect(() => ms.openField(pos), throwsA(isInstanceOf<ArgumentError>()));
    });

    test('doenst throws error if position is not correct', () {
      final ms = Bugsweeper(height: 10, width: 10, bugCount: 10);
      final pos = Position(0, 0);

      expect(() => ms.openField(pos), isNot(throwsA(isInstanceOf<ArgumentError>())));
    });

    test('open field correctly', () {
      final ms = Bugsweeper(height: 10, width: 10, bugCount: 1);
      final pos = Position(1, 1);
      ms.openField(pos);

      expect(ms.isOpenField(pos), true);
    });

    test('open field finds bug', () {
      final ms = Bugsweeper(height: 10, width: 10, bugCount: 1);
      final pos = Position(1, 1);
      final pos2 = Position(2, 1);

      ms.bugFields.clear();
      ms.bugFields.add(pos);
      ms.bugFields.add(pos2);

      expect(ms.openField(pos), Result.lose);
      expect(ms.isOpenField(pos), true);
      expect(ms.isOpenField(pos2), true);
    });
  });

  group('Bugsweeper toggle flag', () {
    test('throws error if position is not correct', () {
      final ms = Bugsweeper(height: 10, width: 10, bugCount: 10);
      final pos = Position(-1, 345);

      expect(() => ms.toggleFlagField(pos), throwsA(isInstanceOf<ArgumentError>()));
    });

    test('doenst throws error if position is not correct', () {
      final ms = Bugsweeper(height: 10, width: 10, bugCount: 10);
      final pos = Position(0, 0);

      expect(() => ms.toggleFlagField(pos), isNot(throwsA(isInstanceOf<ArgumentError>())));
    });

    test('flags field if field not open', () {
      final ms = Bugsweeper(height: 10, width: 10, bugCount: 1);
      final pos = Position(1, 1);

      final result1 = ms.toggleFlagField(pos);
      expect(ms.flagCount, 1);
      expect(result1, true);
      expect(ms.isFlagField(pos), true);

      final result2 = ms.toggleFlagField(pos);
      expect(ms.flagCount, 0);
      expect(result2, true);
      expect(ms.isFlagField(pos), false);
    });

    test('does not flag field if field already open', () {
      final ms = Bugsweeper(height: 10, width: 10, bugCount: 1);
      final pos = Position(1, 1);
      ms.openField(pos);

      final result1 = ms.toggleFlagField(pos);
      expect(result1, false);
      expect(ms.isFlagField(pos), false);
    });
  });

  group('Bugsweeper neighbors', () {
    test('finds neighbors for field will all neighbors', () {
      final ms = Bugsweeper(height: 10, width: 10, bugCount: 10);
      final pos = Position(3, 3);
      final neighbors = ms.getNeighbors(pos);

      expect(neighbors.length, 8);
      expect(neighbors.contains(pos), false);
      expect(neighbors, [
        Position(2, 2),
        Position(2, 3),
        Position(2, 4),
        Position(3, 2),
        Position(3, 4),
        Position(4, 2),
        Position(4, 3),
        Position(4, 4)
      ]);
    });

    test('finds neighbors for field with not all neighbors', () {
      final ms = Bugsweeper(height: 10, width: 10, bugCount: 10);
      final pos = Position(0, 0);
      final neighbors = ms.getNeighbors(pos);

      expect(neighbors.length, 3);
      expect(neighbors, [
        Position(0, 1),
        Position(1, 0),
        Position(1, 1),
      ]);
    });
  });

  group('Bugsweeper getState', () {
    test('works as expected', () {
      final ms = Bugsweeper(height: 10, width: 10, bugCount: 10);
      ms.bugFields.clear();
      ms.bugFields.add(Position(1, 0));

      ms.openField(Position(0, 1));
      ms.toggleFlagField(Position(0, 2));

      final state = ms.getState();

      final p1 = state.elementAt(1);
      expect(p1.type, FieldType.open);
      expect(p1.pos, Position(0, 1));

      final p2 = state.elementAt(2);
      expect(p2.type, FieldType.flag);
      expect(p2.pos, Position(0, 2));
    });
  });

  test('Bugsweeper.resetGame works', () {
    final ms = Bugsweeper(height: 10, width: 10, bugCount: 10);
    ms.openField(Position(0, 1));
    final mineFieldsBefore = ms.bugFields.where((element) => true).toSet();

    ms.resetGame();

    expect(mineFieldsBefore, isNot(equals(ms.bugFields)));
    expect(ms.openFields.length, 0);
  });
}
