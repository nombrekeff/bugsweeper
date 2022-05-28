import 'package:bugsweeper/src/api/bugsweeper.dart';

class ConsoleDisplay {
  final String bombEmoji = '💣';
  final String closedFieldEmoji = '🟨';
  final String openFieldEmoji = '⬜';
  final String flagFieldEmoji = '🚩';

  final Bugsweeper _mineweeper;

  ConsoleDisplay(this._mineweeper);

  render() {
    for (int i = 0; i < _mineweeper.width; i++) {
      String row = '';
      for (int j = 0; j < _mineweeper.height; j++) {
        row += '$closedFieldEmoji ';
      }
      // ignore: avoid_print
      print(row);
    }
  }
}

void main() {
  final ms = Bugsweeper(height: 10, width: 10, bugCount: 10);
  final display = ConsoleDisplay(ms);

  display.render();
}
