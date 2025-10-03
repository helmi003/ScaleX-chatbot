// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String are_you_sure_you_want_to_delete(String title) {
    return 'Are you sure you want to delete \"$title\"?';
  }

  @override
  String get chat_summary => 'Chat Summary';

  @override
  String get common_alert => 'Alert';

  @override
  String get common_attention => 'Attention';

  @override
  String get common_cancel => 'Cancel';

  @override
  String get common_confirm_password => 'Confirm Password';

  @override
  String get common_first_name => 'First Name';

  @override
  String get common_last_name => 'Last Name';

  @override
  String get common_log_out => 'Log Out';

  @override
  String get common_login => 'Login';

  @override
  String get common_message => 'Message';

  @override
  String get common_no => 'No';

  @override
  String get common_ok => 'Ok';

  @override
  String get common_password => 'Password';

  @override
  String get common_register => 'Register';

  @override
  String get common_required => 'This field is required';

  @override
  String get common_save => 'Save';

  @override
  String get common_suggestions => 'Suggestions:';

  @override
  String get common_typing => 'Typing...';

  @override
  String get common_upper_email => 'E-mail';

  @override
  String get common_yes => 'Yes';

  @override
  String get data_processing_error =>
      'An error occurred while processing the data.';

  @override
  String get delete_chat => 'Delete Chat';

  @override
  String deleted_chat(String title) {
    return 'Deleted \"$title\"';
  }

  @override
  String get email_required => 'Please enter your email';

  @override
  String get edit_message => 'Edit Message';

  @override
  String get explain_flutter_in_simple_terms =>
      'Explain Flutter in simple terms';

  @override
  String get failed_to_generate_summary => 'Failed to generate summary';

  @override
  String get generate_summary_description =>
      'Generate a summary to see insights about your chat patterns';

  @override
  String get generate_summary => 'Generate a summary';

  @override
  String get give_me_a_motivational_quote => 'Give me a motivational quote';

  @override
  String get how_to_improve_productivity => 'How to improve productivity?';

  @override
  String get invalid_email => 'This is not a valid email';

  @override
  String get language_description =>
      'Do you want to set this language as your default application language?';

  @override
  String last_updated(String time) {
    return 'Last updated: $time';
  }

  @override
  String get login_description => 'Log in to access your account';

  @override
  String get message_copied_to_clipboard => 'Message copied to clipboard';

  @override
  String messages_count(int count) {
    return 'Messages: $count';
  }

  @override
  String get modify_your_message_below => 'Modify your message below.';

  @override
  String get new_chat => 'New Chat';

  @override
  String get no_account => 'Don\'t have an account?';

  @override
  String get no_chat_history => 'No chat history yet.';

  @override
  String get no_chat_history_summary =>
      'No chat history available to generate summary.';

  @override
  String get no_internet_access => 'Unable to access the Internet!';

  @override
  String get no_summary_generated_yet => 'No summary generated yet';

  @override
  String get not_authorized =>
      'You are not authorized to access this application';

  @override
  String get passwords_do_not_match => 'Passwords do not match';

  @override
  String get read_less => 'Read less';

  @override
  String get read_more => 'Read more';

  @override
  String get refresh_summary => 'Refresh Summary';

  @override
  String get register_description => 'Register to create a new account';

  @override
  String get request_cancelled => '❌ Request cancelled.';

  @override
  String get scroll_down => 'Scroll Down';

  @override
  String get server_not_responding => 'The server is not responding.';

  @override
  String get session_expired => 'Your session has expired.';

  @override
  String get start_new_chat => 'Start New Chat';

  @override
  String get tab_history => 'History';

  @override
  String get tab_profile => 'Profile';

  @override
  String get tab_summary => 'Summary';

  @override
  String get unknown_error => 'An error has occurred';

  @override
  String welcome_back_user(String name) {
    return 'Welcome back, $name!';
  }

  @override
  String get what_is_ai => 'What is AI?';

  @override
  String get you_have_an_account => 'You have an account?';

  @override
  String get your_chat_patterns => 'Your Chat Patterns';

  @override
  String get system_message_summary =>
      'You are a helpful assistant that analyzes conversation patterns and provides concise, insightful summaries. Focus on the main topics, interests, and recurring patterns in the user\'s messages.';

  @override
  String user_message_summary(String messages) {
    return 'Analyze these user messages and provide a brief summary of the user\'s main interests, common topics, and communication patterns. Keep the summary concise yet meaningful (maximum 2–3 short paragraphs):\n\n$messages';
  }

  @override
  String get user_dont_exist => 'User doesn\'t exist';

  @override
  String get user_not_found => 'User not found';

  @override
  String get wrong_password => 'Wrong password';

  @override
  String get email_already_used =>
      'The email address is already in use by another account.';

  @override
  String get weak_password => 'The password is too weak.';

  @override
  String get logout_confirmation => 'Are you sure you want to log out?';

  @override
  String get model_not_working =>
      'The selected model is not working. Please try another one.';

  @override
  String get model_unknown_error => 'An unknown error occurred with the model.';
}
