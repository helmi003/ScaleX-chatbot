import 'package:flutter/material.dart';
import 'package:scalex_chatbot/data/ai_models_data.dart';
import 'package:scalex_chatbot/utils/colors.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String selectedModel;
  final ValueChanged<String?>? onModelChanged;

  const ChatAppBar(this.selectedModel, this.onModelChanged, {super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: lightColor,
      title: const Text(
        "Scalex Chatbot",
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
      actions: [
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedModel,
            dropdownColor: lightColor,
            items: aIModelData.map((model) {
              final isSelected = model.model == selectedModel;
              return DropdownMenuItem(
                value: model.model,
                child: Text(
                  model.name,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              );
            }).toList(),
            onChanged: onModelChanged,
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
