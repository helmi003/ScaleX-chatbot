import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ReadMoreMarkdown extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final String moreText;
  final String lessText;

  const ReadMoreMarkdown({
    super.key,
    required this.text,
    this.style,
    required this.moreText,
    required this.lessText,
  });

  @override
  State<ReadMoreMarkdown> createState() => _ReadMoreMarkdownState();
}

class _ReadMoreMarkdownState extends State<ReadMoreMarkdown> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          firstChild: MarkdownBody(
            data: widget.text.length > 300
                ? '${widget.text.substring(0, 300)}...'
                : widget.text,
            styleSheet: MarkdownStyleSheet.fromTheme(
              Theme.of(context),
            ).copyWith(p: widget.style),
          ),
          secondChild: MarkdownBody(
            data: widget.text,
            styleSheet: MarkdownStyleSheet.fromTheme(
              Theme.of(context),
            ).copyWith(p: widget.style),
          ),
          crossFadeState: expanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
        widget.text.length > 300
            ? Padding(
              padding: EdgeInsets.only(top: 8),
              child: GestureDetector(
                  onTap: () => setState(() => expanded = !expanded),
                  child: Text(
                    expanded ? widget.lessText : widget.moreText,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
            )
            : const SizedBox(),
      ],
    );
  }
}
