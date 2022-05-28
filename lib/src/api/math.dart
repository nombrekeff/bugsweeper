import 'dart:math' as math;

class Math {
  static int getRandomInt(int min, int max) {
    return min + math.Random().nextInt(max - min);
  }
}
