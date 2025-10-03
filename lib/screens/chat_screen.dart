import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';
import 'package:scalex_chatbot/data/ai_models_data.dart';
import 'package:scalex_chatbot/models/chat_message_model.dart';
import 'package:scalex_chatbot/services/chat_provider.dart';
import 'package:scalex_chatbot/services/user_provider.dart';
import 'package:scalex_chatbot/utils/colors.dart';
import 'package:scalex_chatbot/utils/date_format.dart';
import 'package:scalex_chatbot/widgets/chat%20widgets/read_more_markdown.dart';
import 'package:scalex_chatbot/widgets/error_popup.dart';
import 'package:scalex_chatbot/widgets/chat%20widgets/chat_appbar.dart';
import 'package:scalex_chatbot/widgets/chat%20widgets/chat_bottombar.dart';
import 'package:scalex_chatbot/widgets/chat%20widgets/quick_prompt.dart';
import 'package:scalex_chatbot/widgets/chat%20widgets/edit_message.dart';
import 'package:scalex_chatbot/l10n/app_localizations.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const routeName = "/ChatScreen";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? _currentRoomId;

  CancelableOperation<String>? _currentOperation;
  void cancelCurrentRequest() {
    context.read<ChatProvider>().cancelRequest();
    _currentOperation?.cancel();
    setState(() {
      isLoading = false;
    });
  }

  final List<ChatMessage> messages = [];
  final Set<int> _showingTimestamps = {};
  final TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _showScrollDownButton = false;
  bool isLoading = false;
  String selectedModel = aIModelData[0].model;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _initRoom();
  }

  Future<void> _initRoom() async {
    final userProvider = context.read<UserProvider>();

    if (!userProvider.isLoggedIn) {
      return;
    }
    await userProvider.roomManager.init(userProvider.user);

    if (!mounted) return;
    final roomId = ModalRoute.of(context)?.settings.arguments as String?;

    if (roomId != null) {
      _currentRoomId = roomId;
      _loadRoom(roomId);
    } else {
      _currentRoomId = userProvider.roomManager.createNewRoom();
      setState(() {
        messages.clear();
      });
    }
  }

  void _loadRoom(String roomId) {
    final userProvider = context.read<UserProvider>();
    final roomMessages = userProvider.roomManager.loadRoomMessages(roomId);
    setState(() {
      messages.clear();
      messages.addAll(roomMessages);
    });
  }

  void _saveRoom() {
    if (_currentRoomId != null) {
      final userProvider = context.read<UserProvider>();
      userProvider.roomManager.saveRoomMessages(_currentRoomId!, messages);
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels <
        _scrollController.position.maxScrollExtent - 100) {
      if (!_showScrollDownButton) setState(() => _showScrollDownButton = true);
    } else {
      if (_showScrollDownButton) setState(() => _showScrollDownButton = false);
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void sendMessage(String text, {bool fromPrompt = false}) async {
    if (isLoading) return;
    if (text.trim().isEmpty) return;

    FocusScope.of(context).unfocus();
    setState(() {
      messages.add(ChatMessage(text.trim(), true, DateTime.now()));
      isLoading = true;
    });

    controller.clear();
    _scrollToBottom();
    _saveRoom();

    _currentOperation = CancelableOperation.fromFuture(
      context.read<ChatProvider>().sendMessage(context, text, selectedModel),
      onCancel: () {
        setState(() {
          messages.add(
            ChatMessage(
              AppLocalizations.of(context)!.request_cancelled,
              false,
              DateTime.now(),
            ),
          );
          _saveRoom();
        });
      },
    );

    try {
      String message = await _currentOperation!.value;
      setState(() {
        messages.add(ChatMessage(message, false, DateTime.now()));
      });
      _saveRoom();
      _scrollToBottom();
    } catch (error) {
      if (!mounted) return;
      if (error.runtimeType.toString() == 'CancelledException') return;
      showDialog(
        context: context,
        builder: (context) => ErrorPopup(
          AppLocalizations.of(context)!.common_alert,
          error.toString(),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    if (messages.isEmpty && _currentRoomId != null) {
      final userProvider = context.read<UserProvider>();
      userProvider.roomManager.cleanupEmptyRooms();
    }
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: lightColor,
        appBar: ChatAppBar(selectedModel, (model) {
          if (model != null) {
            setState(() => selectedModel = model);
          }
        }),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  QuickPrompt(sendMessage, isLoading),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(12),
                      itemCount: messages.length + (isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == messages.length && isLoading) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 12,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: lightColor,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: dSilverColor),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        color: primaryColor,
                                        strokeWidth: 2,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.common_typing,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        final msg = messages[index];
                        return Align(
                          alignment: msg.isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => showTimestamp(index),
                            onDoubleTap: msg.isUser
                                ? () => isLoading ? null : editMessage(index)
                                : null,
                            onLongPress: () {
                              Clipboard.setData(ClipboardData(text: msg.text));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.message_copied_to_clipboard,
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: primaryColor.withValues(
                                    alpha: 0.8,
                                  ),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: msg.isUser
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: msg.isUser
                                        ? primaryColor.withValues(alpha: 0.2)
                                        : lightColor,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: msg.isUser
                                          ? primaryColor
                                          : dSilverColor,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (!msg.isUser)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8.0,
                                            top: 2,
                                          ),
                                          child: CircleAvatar(
                                            radius: 12,
                                            backgroundColor: lSilverColor,
                                            backgroundImage: const AssetImage(
                                              "assets/images/logo.png",
                                            ),
                                          ),
                                        ),
                                      Flexible(
                                        child: ReadMoreMarkdown(
                                          text: msg.text,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: textColor,
                                          ),
                                          moreText: AppLocalizations.of(
                                            context,
                                          )!.read_more,
                                          lessText: AppLocalizations.of(
                                            context,
                                          )!.read_less,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (_showingTimestamps.contains(index))
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 8.0,
                                      bottom: 2,
                                    ),
                                    child: Text(
                                      dateFormat(context, msg.timestamp),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ChatBottomBar(
                    controller,
                    isLoading,
                    sendMessage,
                    cancelCurrentRequest,
                  ),
                ],
              ),
              if (_showScrollDownButton)
                Positioned(
                  bottom: 80,
                  right: 0,
                  left: 0,
                  child: FloatingActionButton(
                    shape: CircleBorder(),
                    heroTag: AppLocalizations.of(context)!.scroll_down,
                    mini: true,
                    backgroundColor: primaryColor,
                    onPressed: _scrollToBottom,
                    child: const Icon(
                      Icons.arrow_downward,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void editMessage(int index) async {
    String oldText = messages[index].text;
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        final editController = TextEditingController(text: oldText);
        return EditMessage(
          AppLocalizations.of(context)!.edit_message,
          AppLocalizations.of(context)!.modify_your_message_below,
          editController,
          () {
            Navigator.of(context).pop(editController.text.trim());
          },
        );
      },
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        messages
          ..removeRange(index + 1, messages.length)
          ..[index] = ChatMessage(result, true, DateTime.now());
      });
      _saveRoom();
      _scrollToBottom();
      sendMessage(result);
    }
  }

  void showTimestamp(int index) {
    setState(() {
      if (_showingTimestamps.contains(index)) {
        _showingTimestamps.remove(index);
      } else {
        _showingTimestamps.add(index);
      }
    });
  }
}
