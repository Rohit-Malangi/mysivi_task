class ChatMessage {
  final String text;
  final bool isSender;
  final DateTime time;

  ChatMessage({required this.text, required this.isSender, required this.time});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      text: json['text'] as String,
      isSender: json['isSender'] as bool,
      time: DateTime.parse(json['time'] as String),
    );
  }
}
