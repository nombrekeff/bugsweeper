class Difficulty {
  static const Difficulty extraeasy = Difficulty(
    width: 5,
    height: 5,
    mineCount: 3,
  );

  static const Difficulty easy = Difficulty(
    width: 10,
    height: 10,
    mineCount: 10,
  );
  
  static const Difficulty medium = Difficulty(
    width: 16,
    height: 16,
    mineCount: 40,
  );

  static const Difficulty hard = Difficulty(
    width: 22,
    height: 22,
    mineCount: 70,
  );

  final int width;
  final int height;
  final int mineCount;

  const Difficulty({
    required this.width,
    required this.height,
    required this.mineCount,
  });
}
