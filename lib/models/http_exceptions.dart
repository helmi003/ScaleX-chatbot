import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scalex_chatbot/l10n/app_localizations.dart';

class CustomHttpException implements Exception {
  final String message;
  CustomHttpException(this.message);

  @override
  String toString() => message;
}

Future<T> handleErrors<T>(
  BuildContext context,
  Future<T> Function() operation,
) async {
  try {
    return await operation();
  } on SocketException catch (e) {
    if (kDebugMode) debugPrint("SocketException: $e");
    throw CustomHttpException(AppLocalizations.of(context)!.no_internet_access);
  } on FormatException catch (e) {
    if (kDebugMode) debugPrint("FormatException: $e");
    throw CustomHttpException(AppLocalizations.of(context)!.data_processing_error);
  } on StateError catch (e) {
    if (kDebugMode) debugPrint("StateError: $e");
    throw CustomHttpException(AppLocalizations.of(context)!.unknown_error);
  } catch (exception) {
    if (kDebugMode) debugPrint("Unknown error: $exception");
    throw CustomHttpException(exception.toString());
  }
}
