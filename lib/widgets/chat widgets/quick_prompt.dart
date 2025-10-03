import 'package:flutter/material.dart';
import 'package:scalex_chatbot/utils/colors.dart';
import 'package:scalex_chatbot/l10n/app_localizations.dart';

class QuickPrompt extends StatelessWidget {
  final ValueChanged<String> sendMessage;
  final bool isLoading;
  const QuickPrompt(this.sendMessage, this.isLoading, {super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> quickPrompts = [
      AppLocalizations.of(context)!.what_is_ai,
      AppLocalizations.of(context)!.how_to_improve_productivity,
      AppLocalizations.of(context)!.explain_flutter_in_simple_terms,
      AppLocalizations.of(context)!.give_me_a_motivational_quote,
    ];

    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: quickPrompts.length + 1,
        separatorBuilder: (_, child) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.common_suggestions,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: primaryColor,
                ),
              ),
            );
          }

          final prompt = quickPrompts[index - 1];
          return ActionChip(
            backgroundColor: lightColor,
            label: Text(prompt, style: const TextStyle(fontSize: 13)),
            onPressed: () => isLoading ? null : sendMessage(prompt),
          );
        },
      ),
    );
  }
}
