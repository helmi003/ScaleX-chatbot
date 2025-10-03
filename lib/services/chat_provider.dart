import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:scalex_chatbot/data/ai_models_data.dart';
import 'package:scalex_chatbot/models/http_exceptions.dart';
import 'package:scalex_chatbot/l10n/app_localizations.dart';

class ChatProvider with ChangeNotifier {
  final String hfApiToken = dotenv.env['HF_TOKEN']!;
  final String openRouterURL = dotenv.env['OPEN_ROUTER_URL']!;
  final String openRouterApiToken = dotenv.env['OPEN_ROUTER_TOKEN']!;
  http.Client? httpClient;

  Future<String> sendMessage(
    BuildContext context,
    String message,
    String model,
  ) async {
    httpClient = http.Client();
    return await handleErrors(context, () async {
      final response = await httpClient!.post(
        Uri.parse(openRouterURL),
        headers: {
          'Authorization': 'Bearer $openRouterApiToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "model": model,
          "messages": [
            {"role": "user", "content": message},
          ],
        }),
      );
      final data = json.decode(response.body);
      if (!context.mounted) return '';
      if (response.statusCode == 200) {
        if (data['choices'] != null &&
            data['choices'] is List &&
            data['choices'].isNotEmpty &&
            data['choices'][0]['message'] != null &&
            data['choices'][0]['message']['content'] != null) {
          return data['choices'][0]['message']['content'] as String;
        } else if (data['error'] != null) {
          throw Exception(AppLocalizations.of(context)!.model_not_working);
        } else {
          throw Exception(AppLocalizations.of(context)!.model_unknown_error);
        }
      } else {
        throw Exception(AppLocalizations.of(context)!.unknown_error);
      }
    });
  }

  Future<String> createSummary(
    BuildContext context,
    List<String> messages,
  ) async {
    httpClient = http.Client();
    return await handleErrors(context, () async {
      final response = await httpClient!.post(
        Uri.parse(openRouterURL),
        headers: {
          'Authorization': 'Bearer $openRouterApiToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "model": aIModelData[0].model,
          "messages": [
            {
              "role": "system",
              "content": AppLocalizations.of(context)!.system_message_summary,
            },
            {
              "role": "user",
              "content": AppLocalizations.of(
                context,
              )!.user_message_summary(messages.take(50).join("\n\n")),
            },
          ],
        }),
      );
      final data = json.decode(response.body);
      if (!context.mounted) return '';
      if (response.statusCode == 200) {
        if (data['choices'] != null &&
            data['choices'] is List &&
            data['choices'].isNotEmpty &&
            data['choices'][0]['message'] != null &&
            data['choices'][0]['message']['content'] != null) {
          return data['choices'][0]['message']['content'] as String;
        } else if (data['error'] != null) {
          throw Exception(AppLocalizations.of(context)!.model_not_working);
        } else {
          throw Exception(AppLocalizations.of(context)!.model_unknown_error);
        }
      } else {
        throw Exception(AppLocalizations.of(context)!.unknown_error);
      }
    });
  }

  void cancelRequest() {
    httpClient?.close();
    httpClient = null;
  }
}
