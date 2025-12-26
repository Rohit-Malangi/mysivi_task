import 'dart:math' as math;
import 'dart:math' show Random;
import 'dart:ui' show Color;

class GenerateRandom {
  static final _random = Random();

  static Color randomColor() {
    return Color(
      (math.Random().nextDouble() * 0xFFFFFF).toInt(),
    ).withValues(alpha: 1.0);
  }

  static bool randomBool() {
    return _random.nextBool();
  }

  static int randomIntTillTen() {
    return _random.nextInt(10) + 1;
  }

  static DateTime generateRandomPastTime() {
    final Random random = Random();
    final DateTime now = DateTime.now().toUtc();

    const int minMs = 1000;
    const int maxMs = 24 * 60 * 60 * 1000;

    final int rangeMs = maxMs - minMs;

    final int randomOffsetMs = random.nextInt(rangeMs);

    final int totalRandomDurationMs = minMs + randomOffsetMs;

    return now.subtract(Duration(milliseconds: totalRandomDurationMs));
  }
}
