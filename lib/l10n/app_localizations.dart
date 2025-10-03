import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @are_you_sure_you_want_to_delete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{title}\"?'**
  String are_you_sure_you_want_to_delete(String title);

  /// No description provided for @chat_summary.
  ///
  /// In en, this message translates to:
  /// **'Chat Summary'**
  String get chat_summary;

  /// No description provided for @common_alert.
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get common_alert;

  /// No description provided for @common_attention.
  ///
  /// In en, this message translates to:
  /// **'Attention'**
  String get common_attention;

  /// No description provided for @common_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get common_cancel;

  /// No description provided for @common_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get common_confirm_password;

  /// No description provided for @common_first_name.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get common_first_name;

  /// No description provided for @common_last_name.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get common_last_name;

  /// No description provided for @common_log_out.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get common_log_out;

  /// No description provided for @common_login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get common_login;

  /// No description provided for @common_message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get common_message;

  /// No description provided for @common_no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get common_no;

  /// No description provided for @common_ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get common_ok;

  /// No description provided for @common_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get common_password;

  /// No description provided for @common_register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get common_register;

  /// No description provided for @common_required.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get common_required;

  /// No description provided for @common_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get common_save;

  /// No description provided for @common_suggestions.
  ///
  /// In en, this message translates to:
  /// **'Suggestions:'**
  String get common_suggestions;

  /// No description provided for @common_typing.
  ///
  /// In en, this message translates to:
  /// **'Typing...'**
  String get common_typing;

  /// No description provided for @common_upper_email.
  ///
  /// In en, this message translates to:
  /// **'E-mail'**
  String get common_upper_email;

  /// No description provided for @common_yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get common_yes;

  /// No description provided for @data_processing_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while processing the data.'**
  String get data_processing_error;

  /// No description provided for @delete_chat.
  ///
  /// In en, this message translates to:
  /// **'Delete Chat'**
  String get delete_chat;

  /// No description provided for @deleted_chat.
  ///
  /// In en, this message translates to:
  /// **'Deleted \"{title}\"'**
  String deleted_chat(String title);

  /// No description provided for @email_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get email_required;

  /// No description provided for @edit_message.
  ///
  /// In en, this message translates to:
  /// **'Edit Message'**
  String get edit_message;

  /// No description provided for @explain_flutter_in_simple_terms.
  ///
  /// In en, this message translates to:
  /// **'Explain Flutter in simple terms'**
  String get explain_flutter_in_simple_terms;

  /// No description provided for @failed_to_generate_summary.
  ///
  /// In en, this message translates to:
  /// **'Failed to generate summary'**
  String get failed_to_generate_summary;

  /// No description provided for @generate_summary.
  ///
  /// In en, this message translates to:
  /// **'Generate a summary to see insights about your chat patterns'**
  String get generate_summary;

  /// No description provided for @give_me_a_motivational_quote.
  ///
  /// In en, this message translates to:
  /// **'Give me a motivational quote'**
  String get give_me_a_motivational_quote;

  /// No description provided for @how_to_improve_productivity.
  ///
  /// In en, this message translates to:
  /// **'How to improve productivity?'**
  String get how_to_improve_productivity;

  /// No description provided for @invalid_email.
  ///
  /// In en, this message translates to:
  /// **'This is not a valid email'**
  String get invalid_email;

  /// No description provided for @language_description.
  ///
  /// In en, this message translates to:
  /// **'Do you want to set this language as your default application language?'**
  String get language_description;

  /// No description provided for @last_updated.
  ///
  /// In en, this message translates to:
  /// **'Last updated: {time}'**
  String last_updated(String time);

  /// No description provided for @login_description.
  ///
  /// In en, this message translates to:
  /// **'Log in to access your account'**
  String get login_description;

  /// No description provided for @message_copied_to_clipboard.
  ///
  /// In en, this message translates to:
  /// **'Message copied to clipboard'**
  String get message_copied_to_clipboard;

  /// No description provided for @messages_count.
  ///
  /// In en, this message translates to:
  /// **'Messages: {count}'**
  String messages_count(int count);

  /// No description provided for @modify_your_message_below.
  ///
  /// In en, this message translates to:
  /// **'Modify your message below.'**
  String get modify_your_message_below;

  /// No description provided for @new_chat.
  ///
  /// In en, this message translates to:
  /// **'New Chat'**
  String get new_chat;

  /// No description provided for @no_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get no_account;

  /// No description provided for @no_chat_history.
  ///
  /// In en, this message translates to:
  /// **'No chat history yet.'**
  String get no_chat_history;

  /// No description provided for @no_chat_history_summary.
  ///
  /// In en, this message translates to:
  /// **'No chat history available to generate summary.'**
  String get no_chat_history_summary;

  /// No description provided for @no_internet_access.
  ///
  /// In en, this message translates to:
  /// **'Unable to access the Internet!'**
  String get no_internet_access;

  /// No description provided for @no_summary_generated_yet.
  ///
  /// In en, this message translates to:
  /// **'No summary generated yet'**
  String get no_summary_generated_yet;

  /// No description provided for @not_authorized.
  ///
  /// In en, this message translates to:
  /// **'You are not authorized to access this application'**
  String get not_authorized;

  /// No description provided for @passwords_do_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwords_do_not_match;

  /// No description provided for @read_less.
  ///
  /// In en, this message translates to:
  /// **'Read less'**
  String get read_less;

  /// No description provided for @read_more.
  ///
  /// In en, this message translates to:
  /// **'Read more'**
  String get read_more;

  /// No description provided for @refresh_summary.
  ///
  /// In en, this message translates to:
  /// **'Refresh Summary'**
  String get refresh_summary;

  /// No description provided for @register_description.
  ///
  /// In en, this message translates to:
  /// **'Register to create a new account'**
  String get register_description;

  /// No description provided for @request_cancelled.
  ///
  /// In en, this message translates to:
  /// **'❌ Request cancelled.'**
  String get request_cancelled;

  /// No description provided for @scroll_down.
  ///
  /// In en, this message translates to:
  /// **'Scroll Down'**
  String get scroll_down;

  /// No description provided for @server_not_responding.
  ///
  /// In en, this message translates to:
  /// **'The server is not responding.'**
  String get server_not_responding;

  /// No description provided for @session_expired.
  ///
  /// In en, this message translates to:
  /// **'Your session has expired.'**
  String get session_expired;

  /// No description provided for @start_new_chat.
  ///
  /// In en, this message translates to:
  /// **'Start New Chat'**
  String get start_new_chat;

  /// No description provided for @tab_history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get tab_history;

  /// No description provided for @tab_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get tab_profile;

  /// No description provided for @tab_summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get tab_summary;

  /// No description provided for @unknown_error.
  ///
  /// In en, this message translates to:
  /// **'An error has occurred'**
  String get unknown_error;

  /// No description provided for @welcome_back_user.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, {name}!'**
  String welcome_back_user(String name);

  /// No description provided for @what_is_ai.
  ///
  /// In en, this message translates to:
  /// **'What is AI?'**
  String get what_is_ai;

  /// No description provided for @you_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'You have an account?'**
  String get you_have_an_account;

  /// No description provided for @your_chat_patterns.
  ///
  /// In en, this message translates to:
  /// **'Your Chat Patterns'**
  String get your_chat_patterns;

  /// No description provided for @system_message_summary.
  ///
  /// In en, this message translates to:
  /// **'You are a helpful assistant that analyzes conversation patterns and provides concise, insightful summaries. Focus on the main topics, interests, and recurring patterns in the user\'s messages.'**
  String get system_message_summary;

  /// No description provided for @user_message_summary.
  ///
  /// In en, this message translates to:
  /// **'Analyze these user messages and provide a brief summary of the user\'s main interests, common topics, and communication patterns. Keep the summary concise yet meaningful (maximum 2–3 short paragraphs):\n\n{messages}'**
  String user_message_summary(String messages);

  /// No description provided for @user_dont_exist.
  ///
  /// In en, this message translates to:
  /// **'User doesn\'t exist'**
  String get user_dont_exist;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
