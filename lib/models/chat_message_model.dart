import 'package:hive/hive.dart';
part 'chat_message_model.g.dart';

@HiveType(typeId: 0)
class ChatMessage {
  @HiveField(0)
  final String text;
  @HiveField(1)
  final bool isUser;
  @HiveField(2)
  final DateTime timestamp;

  ChatMessage(this.text, this.isUser, this.timestamp);

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      json['text'] ?? "",
      json['isUser'] ?? false,
      DateTime.parse(json['timestamp'] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'isUser': isUser, 'timestamp': timestamp.toIso8601String()};
  }
}
