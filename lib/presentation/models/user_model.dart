import 'dart:ui' show Color;

class User {
  final int userID;
  final String name;
  final Color color;
  final bool isOnline;
  final DateTime? onlineTime;
  String? lastMsg;

  User({
    required this.userID,
    required this.name,
    required this.color,
    required this.isOnline,
    required this.onlineTime,
    required this.lastMsg,
  });
}
