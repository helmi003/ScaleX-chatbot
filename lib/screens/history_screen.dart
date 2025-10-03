import 'package:flutter/material.dart';
import 'package:scalex_chatbot/models/chat_room_model.dart';
import 'package:scalex_chatbot/screens/chat_screen.dart';
import 'package:scalex_chatbot/services/room_manager.dart';
import 'package:scalex_chatbot/utils/colors.dart';
import 'package:scalex_chatbot/utils/date_format.dart';
import 'package:scalex_chatbot/widgets/button_widget.dart';
import 'package:scalex_chatbot/widgets/yes_or_no_popup.dart';
import 'package:scalex_chatbot/l10n/app_localizations.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late RoomManager _roomManager;
  List<ChatRoom> _rooms = [];
  bool _hasHistory = false;

  @override
  void initState() {
    super.initState();
    _roomManager = RoomManager();
    _loadRooms();
  }

  Future<void> _loadRooms() async {
    await _roomManager.init();
    setState(() {
      _rooms = _roomManager.getAllRooms();
      _rooms.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _hasHistory = _rooms.isNotEmpty;
    });
  }

  void _createNewChat() {
    final newRoomId = _roomManager.createNewRoom();
    Navigator.pushNamed(
      context,
      ChatScreen.routeName,
      arguments: newRoomId,
    ).then((_) => _loadRooms());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColor,
        title: Text(
          AppLocalizations.of(context)!.tab_history,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          if (_hasHistory)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _createNewChat,
              tooltip: AppLocalizations.of(context)!.new_chat,
            ),
        ],
      ),
      backgroundColor: lightColor,
      body: SafeArea(
        child: _rooms.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.no_chat_history),
                    const SizedBox(height: 16),
                    ButtonWidget(
                      AppLocalizations.of(context)!.start_new_chat,
                      _createNewChat,
                      primaryColor,
                      false,
                      lightColor,
                    ),
                  ],
                ),
              )
            : RefreshIndicator(
                onRefresh: _loadRooms,
                child: ListView.builder(
                  itemCount: _rooms.length,
                  itemBuilder: (context, index) {
                    final room = _rooms[index];
                    return Dismissible(
                      key: Key(room.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: redColor,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete, color: lightColor),
                      ),
                      confirmDismiss: (direction) async {
                        final bool? shouldDelete = await showDialog<bool>(
                          context: context,
                          builder: (context) => YesOrNoPopup(
                            AppLocalizations.of(context)!.delete_chat,
                            AppLocalizations.of(
                              context,
                            )!.are_you_sure_you_want_to_delete(room.title),
                            () {
                              Navigator.of(context).pop(true);
                            },
                          ),
                        );
                        return shouldDelete ?? false;
                      },
                      onDismissed: (direction) {
                        _roomManager.deleteRoom(room.id);
                        setState(() {
                          _rooms.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(
                                context,
                              )!.deleted_chat(room.title),
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(room.title),
                        subtitle: Text(dateFormat(context, room.createdAt)),
                        trailing: Text(
                          AppLocalizations.of(
                            context,
                          )!.messages_count(room.messages.length),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ChatScreen.routeName,
                            arguments: room.id,
                          ).then((_) => _loadRooms());
                        },
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
