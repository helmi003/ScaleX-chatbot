import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scalex_chatbot/services/chat_provider.dart';
import 'package:scalex_chatbot/services/room_manager.dart';
import 'package:scalex_chatbot/utils/colors.dart';
import 'package:scalex_chatbot/utils/date_format.dart';
import 'package:scalex_chatbot/widgets/button_widget.dart';
import 'package:scalex_chatbot/widgets/error_popup.dart';
import 'package:scalex_chatbot/l10n/app_localizations.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final RoomManager _roomManager = RoomManager();
  String _summary = '';
  bool _isLoading = false;
  bool _hasSummary = false;
  DateTime? _lastUpdated;

  @override
  void initState() {
    super.initState();
    _loadSavedSummary();
  }

  Future<void> _loadSavedSummary() async {
    final saved = await _roomManager.getSavedSummary();
    if (saved != null) {
      setState(() {
        _summary = saved['summary'] ?? '';
        _lastUpdated = DateTime.parse(saved['lastUpdated']);
        _hasSummary = _summary.isNotEmpty;
      });
    }
  }

  Future<void> _generateSummary() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final userMessages = _roomManager.getAllUserMessages();

      if (userMessages.isEmpty) {
        setState(() {
          _summary = AppLocalizations.of(context)!.no_chat_history_summary;
          _hasSummary = true;
          _isLoading = false;
        });
        return;
      }

      final chatProvider = context.read<ChatProvider>();
      final newSummary = await chatProvider.createSummary(
        context,
        userMessages,
      );

      _roomManager.saveSummary(newSummary);

      setState(() {
        _summary = newSummary;
        _lastUpdated = DateTime.now();
        _hasSummary = true;
      });
    } catch (error) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => ErrorPopup(
          AppLocalizations.of(context)!.common_alert,
          AppLocalizations.of(context)!.failed_to_generate_summary,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColor,
        title: Text(
          AppLocalizations.of(context)!.chat_summary,
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          if (_hasSummary)
            IconButton(
              icon: const Icon(Icons.refresh, color: darkColor),
              onPressed: _isLoading ? null : _generateSummary,
              tooltip: AppLocalizations.of(context)!.refresh_summary,
            ),
        ],
      ),
      backgroundColor: lightColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _isLoading
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: primaryColor,
                              strokeWidth: 2,
                            ),
                            SizedBox(height: 16),
                            Text(AppLocalizations.of(context)!.common_typing),
                          ],
                        ),
                      )
                    : _hasSummary
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(
                                  context,
                                )!.your_chat_patterns,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _summary,
                                style: const TextStyle(
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                              if (_lastUpdated != null) ...[
                                const SizedBox(height: 16),
                                Divider(color: Colors.grey[300]),
                                Text(
                                  AppLocalizations.of(context)!.last_updated(
                                    dateFormat(context, _lastUpdated!),
                                  ),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.analytics,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.no_summary_generated_yet,
                              style: TextStyle(
                                fontSize: 16,
                                color: dSilverColor,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              AppLocalizations.of(
                                context,
                              )!.generate_summary_description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: dSilverColor,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            ButtonWidget(
                              AppLocalizations.of(context)!.generate_summary,
                              _generateSummary,
                              primaryColor,
                              false,
                              lightColor,
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
