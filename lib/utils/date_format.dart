import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String dateFormat(BuildContext context, DateTime date) {
  return DateFormat('MMM d, yyyy • HH:mm', Localizations.localeOf(context).languageCode).format(date);
}
