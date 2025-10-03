import 'package:hive/hive.dart';
import 'package:scalex_chatbot/models/chat_message_model.dart';
import 'package:scalex_chatbot/models/chat_room_model.dart';
import 'package:uuid/uuid.dart';

class RoomManager {
  static final RoomManager _instance = RoomManager._internal();
  factory RoomManager() => _instance;
  RoomManager._internal();

  final Uuid _uuid = Uuid();
  late Box roomsBox;
  late Box<ChatRoom> chatRoomsBox;
  late Box _summaryBox;

  Future<void> init() async {
    roomsBox = Hive.box('rooms');
    chatRoomsBox = Hive.box<ChatRoom>('chatRooms');
    _summaryBox = Hive.box('summary');
  }

  String createNewRoom() {
    final roomId = _uuid.v4();
    roomsBox.put(roomId, []);
    return roomId;
  }

  void saveRoomMessages(String roomId, List<ChatMessage> messages) {
    roomsBox.put(roomId, messages);
    if (messages.isNotEmpty) {
      final firstUserMsg = messages.firstWhere(
        (m) => m.isUser,
        orElse: () => messages.first,
      );

      final roomTitle = firstUserMsg.text.length > 30
          ? '${firstUserMsg.text.substring(0, 30)}...'
          : firstUserMsg.text;

      final room = chatRoomsBox.get(roomId);
      if (room != null) {
        final updatedRoom = ChatRoom(
          id: roomId,
          createdAt: room.createdAt,
          title: roomTitle,
          messages: messages,
        );
        chatRoomsBox.put(roomId, updatedRoom);
      } else {
        final newRoom = ChatRoom(
          id: roomId,
          createdAt: messages.first.timestamp,
          title: roomTitle,
          messages: messages,
        );
        chatRoomsBox.put(roomId, newRoom);
      }
    } else {
      chatRoomsBox.delete(roomId);
    }
  }

  void cleanupEmptyRooms() {
    final allRoomIds = roomsBox.keys.cast<String>().toList();

    for (final roomId in allRoomIds) {
      final messages = loadRoomMessages(roomId);
      if (messages.isEmpty) {
        roomsBox.delete(roomId);
        chatRoomsBox.delete(roomId);
      }
    }
  }

  List<ChatMessage> loadRoomMessages(String roomId) {
    final roomData = roomsBox.get(roomId, defaultValue: []);
    return List<ChatMessage>.from(roomData);
  }

  List<ChatRoom> getAllRooms() {
    return chatRoomsBox.values.toList();
  }

  void deleteRoom(String roomId) {
    roomsBox.delete(roomId);
    chatRoomsBox.delete(roomId);
  }

  List<String> getAllUserMessages() {
    final allRooms = chatRoomsBox.values.toList();
    final userMessages = <String>[];

    for (final room in allRooms) {
      final roomMessages = loadRoomMessages(room.id);
      final userMsgs = roomMessages
          .where((msg) => msg.isUser)
          .map((msg) => msg.text)
          .toList();
      userMessages.addAll(userMsgs);
    }

    return userMessages;
  }

  void saveSummary(String summary) {
    _summaryBox.put('user_summary', {
      'summary': summary,
      'lastUpdated': DateTime.now().toIso8601String(),
      'totalChats': chatRoomsBox.length,
    });
  }

  Map<String, dynamic>? getSavedSummary() {
    final dynamic data = _summaryBox.get('user_summary');
    if (data == null) return null;
    if (data is Map) {
      return data.cast<String, dynamic>();
    }
    return null;
  }

  bool shouldRefreshSummary() {
    final saved = getSavedSummary();
    if (saved == null) return true;

    final lastUpdated = DateTime.parse(saved['lastUpdated']);
    final now = DateTime.now();
    return now.difference(lastUpdated).inDays >= 1;
  }
}
