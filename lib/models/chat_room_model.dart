import 'package:hive/hive.dart';
import 'chat_message_model.dart';
part 'chat_room_model.g.dart';

@HiveType(typeId: 1)
class ChatRoom {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final DateTime createdAt;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final List<ChatMessage> messages;

  ChatRoom({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.messages,
  });

  factory ChatRoom.fromMessages(String id, List<ChatMessage> messages) {
    final firstUserMsg = messages.firstWhere(
      (m) => m.isUser,
      orElse: () => messages.first,
    );
    return ChatRoom(
      id: id,
      createdAt: firstUserMsg.timestamp,
      title: firstUserMsg.text,
      messages: messages,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdAt': createdAt.toIso8601String(),
    'title': title,
    'messages': messages.map((m) => m.toJson()).toList(),
  };

  factory ChatRoom.fromJson(Map<String, dynamic> json) => ChatRoom(
    id: json['id'],
    createdAt: DateTime.parse(json['createdAt']),
    title: json['title'],
    messages: (json['messages'] as List)
        .map((m) => ChatMessage.fromJson(m))
        .toList(),
  );
}
