class Difficulty {
  static const Difficulty extraeasy = Difficulty(
    width: 5,
    height: 5,
    bugCount: 3,
  );

  static const Difficulty easy = Difficulty(
    width: 10,
    height: 10,
    bugCount: 10,
  );
  
  static const Difficulty medium = Difficulty(
    width: 16,
    height: 16,
    bugCount: 40,
  );

  static const Difficulty hard = Difficulty(
    width: 22,
    height: 22,
    bugCount: 70,
  );

  final int width;
  final int height;
  final int bugCount;

  const Difficulty({
    required this.width,
    required this.height,
    required this.bugCount,
  });
}
