import 'package:hive/hive.dart';
import 'package:scalex_chatbot/models/chat_message_model.dart';
import 'package:scalex_chatbot/models/chat_room_model.dart';
import 'package:scalex_chatbot/models/user_model.dart';
import 'package:uuid/uuid.dart';

class RoomManager {
  static final RoomManager _instance = RoomManager._internal();
  factory RoomManager() => _instance;
  RoomManager._internal();

  final Uuid _uuid = Uuid();
  late String _currentUserId;

  Box get _roomsBox => Hive.box('rooms_$_currentUserId');
  Box<ChatRoom> get _chatRoomsBox =>
      Hive.box<ChatRoom>('chatRooms_$_currentUserId');
  Future<Box> get _summaryBox async {
    if (!Hive.isBoxOpen('summary_$_currentUserId')) {
      return await Hive.openBox('summary_$_currentUserId');
    }
    return Hive.box('summary_$_currentUserId');
  }

  Future<void> init(UserModel user) async {
    if (!user.isValid) {
      throw Exception('Invalid user provided to RoomManager');
    }
    _currentUserId = user.uid;
    await _ensureBoxesOpen();
  }

  Future<void> _ensureBoxesOpen() async {
    if (!Hive.isBoxOpen('rooms_$_currentUserId')) {
      await Hive.openBox('rooms_$_currentUserId');
    }

    if (!Hive.isBoxOpen('chatRooms_$_currentUserId')) {
      await Hive.openBox<ChatRoom>('chatRooms_$_currentUserId');
    }

    if (!Hive.isBoxOpen('summary_$_currentUserId')) {
      await Hive.openBox('summary_$_currentUserId');
    }
  }

  String createNewRoom() {
    final roomId = _uuid.v4();
    _roomsBox.put(roomId, []);
    return roomId;
  }

  void saveRoomMessages(String roomId, List<ChatMessage> messages) {
    _roomsBox.put(roomId, messages);
    if (messages.isNotEmpty) {
      final firstUserMsg = messages.firstWhere(
        (m) => m.isUser,
        orElse: () => messages.first,
      );

      final roomTitle = firstUserMsg.text.length > 30
          ? '${firstUserMsg.text.substring(0, 30)}...'
          : firstUserMsg.text;

      final room = _chatRoomsBox.get(roomId);
      if (room != null) {
        final updatedRoom = ChatRoom(
          id: roomId,
          createdAt: room.createdAt,
          title: roomTitle,
          messages: messages,
        );
        _chatRoomsBox.put(roomId, updatedRoom);
      } else {
        final newRoom = ChatRoom(
          id: roomId,
          createdAt: messages.first.timestamp,
          title: roomTitle,
          messages: messages,
        );
        _chatRoomsBox.put(roomId, newRoom);
      }
    } else {
      _chatRoomsBox.delete(roomId);
    }
  }

  void cleanupEmptyRooms() {
    final allRoomIds = _roomsBox.keys.cast<String>().toList();

    for (final roomId in allRoomIds) {
      final messages = loadRoomMessages(roomId);
      if (messages.isEmpty) {
        _roomsBox.delete(roomId);
        _chatRoomsBox.delete(roomId);
      }
    }
  }

  List<ChatMessage> loadRoomMessages(String roomId) {
    final roomData = _roomsBox.get(roomId, defaultValue: []);
    return List<ChatMessage>.from(roomData);
  }

  List<ChatRoom> getAllRooms() {
    return _chatRoomsBox.values.toList();
  }

  void deleteRoom(String roomId) {
    _roomsBox.delete(roomId);
    _chatRoomsBox.delete(roomId);
  }

  List<String> getAllUserMessages() {
    final allRooms = _chatRoomsBox.values.toList();
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

  Future<void> saveSummary(String summary) async {
    final box = await _summaryBox;
    box.put('user_summary', {
      'summary': summary,
      'lastUpdated': DateTime.now().toIso8601String(),
      'totalChats': _chatRoomsBox.length,
    });
  }

  Future<Map<String, dynamic>?> getSavedSummary() async {
    final box = await _summaryBox;
    final dynamic data = box.get('user_summary');
    if (data == null) return null;
    if (data is Map) {
      return data.cast<String, dynamic>();
    }
    return null;
  }

  Future<bool> shouldRefreshSummary() async {
    final saved = await getSavedSummary();
    if (saved == null) return true;

    final lastUpdated = DateTime.parse(saved['lastUpdated']);
    final now = DateTime.now();
    return now.difference(lastUpdated).inDays >= 1;
  }

  Future<void> clearUserData() async {
    await _roomsBox.clear();
    await _chatRoomsBox.clear();
    final box = await _summaryBox;
    await box.clear();
  }

  String get currentUserId => _currentUserId;
}
