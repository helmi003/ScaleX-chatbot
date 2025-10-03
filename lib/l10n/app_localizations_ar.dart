// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String are_you_sure_you_want_to_delete(String title) {
    return 'هل أنت متأكد أنك تريد حذف \"$title\"؟';
  }

  @override
  String get chat_summary => 'ملخص المحادثة';

  @override
  String get common_alert => 'تنبيه';

  @override
  String get common_attention => 'انتباه';

  @override
  String get common_cancel => 'إلغاء';

  @override
  String get common_confirm_password => 'تأكيد كلمة المرور';

  @override
  String get common_first_name => 'الاسم الأول';

  @override
  String get common_last_name => 'اللقب';

  @override
  String get common_log_out => 'تسجيل الخروج';

  @override
  String get common_login => 'تسجيل الدخول';

  @override
  String get common_message => 'رسالة';

  @override
  String get common_no => 'لا';

  @override
  String get common_ok => 'حسنًا';

  @override
  String get common_password => 'كلمة المرور';

  @override
  String get common_register => 'إنشاء حساب';

  @override
  String get common_required => 'هذا الحقل مطلوب';

  @override
  String get common_save => 'حفظ';

  @override
  String get common_suggestions => 'اقتراحات:';

  @override
  String get common_typing => 'يكتب...';

  @override
  String get common_upper_email => 'البريد الإلكتروني';

  @override
  String get common_yes => 'نعم';

  @override
  String get data_processing_error => 'حدث خطأ أثناء معالجة البيانات.';

  @override
  String get delete_chat => 'حذف المحادثة';

  @override
  String deleted_chat(String title) {
    return 'تم حذف \"$title\"';
  }

  @override
  String get email_required => 'يرجى إدخال البريد الإلكتروني';

  @override
  String get edit_message => 'تعديل الرسالة';

  @override
  String get explain_flutter_in_simple_terms => 'اشرح Flutter بطريقة مبسطة';

  @override
  String get failed_to_generate_summary => 'فشل في إنشاء الملخص';

  @override
  String get generate_summary => 'أنشئ ملخصًا لعرض رؤى حول أنماط محادثاتك';

  @override
  String get give_me_a_motivational_quote => 'أعطني اقتباسًا تحفيزيًا';

  @override
  String get how_to_improve_productivity => 'كيف يمكن تحسين الإنتاجية؟';

  @override
  String get invalid_email => 'البريد الإلكتروني غير صالح';

  @override
  String get language_description =>
      'هل ترغب في تعيين هذه اللغة كلغة افتراضية للتطبيق؟';

  @override
  String last_updated(String time) {
    return 'آخر تحديث: $time';
  }

  @override
  String get login_description => 'سجل الدخول للوصول إلى حسابك';

  @override
  String get message_copied_to_clipboard => 'تم نسخ الرسالة إلى الحافظة';

  @override
  String messages_count(int count) {
    return 'عدد الرسائل: $count';
  }

  @override
  String get modify_your_message_below => 'عدّل رسالتك أدناه.';

  @override
  String get new_chat => 'محادثة جديدة';

  @override
  String get no_account => 'ليس لديك حساب؟';

  @override
  String get no_chat_history => 'لا توجد محادثات بعد.';

  @override
  String get no_chat_history_summary => 'لا توجد محادثات لإنشاء ملخص.';

  @override
  String get no_internet_access => 'تعذر الاتصال بالإنترنت!';

  @override
  String get no_summary_generated_yet => 'لم يتم إنشاء أي ملخص بعد';

  @override
  String get not_authorized => 'غير مصرح لك بالوصول إلى هذا التطبيق';

  @override
  String get passwords_do_not_match => 'كلمتا المرور غير متطابقتين';

  @override
  String get read_less => 'عرض أقل';

  @override
  String get read_more => 'عرض المزيد';

  @override
  String get refresh_summary => 'تحديث الملخص';

  @override
  String get register_description => 'قم بإنشاء حساب جديد';

  @override
  String get request_cancelled => '❌ تم إلغاء الطلب.';

  @override
  String get scroll_down => 'التمرير للأسفل';

  @override
  String get server_not_responding => 'الخادم لا يستجيب.';

  @override
  String get session_expired => 'انتهت صلاحية الجلسة.';

  @override
  String get start_new_chat => 'ابدأ محادثة جديدة';

  @override
  String get tab_history => 'السجل';

  @override
  String get tab_profile => 'الملف الشخصي';

  @override
  String get tab_summary => 'الملخص';

  @override
  String get unknown_error => 'حدث خطأ غير متوقع';

  @override
  String welcome_back_user(String name) {
    return 'مرحبًا بعودتك، $name!';
  }

  @override
  String get what_is_ai => 'ما هو الذكاء الاصطناعي؟';

  @override
  String get you_have_an_account => 'هل لديك حساب؟';

  @override
  String get your_chat_patterns => 'أنماط محادثاتك';

  @override
  String get system_message_summary =>
      'أنت مساعد ذكي يقوم بتحليل أنماط المحادثة ويقدّم ملخصات موجزة وهادفة. ركّز على المواضيع الرئيسية، والاهتمامات، والأنماط المتكررة في رسائل المستخدم.';

  @override
  String user_message_summary(String messages) {
    return 'قم بتحليل هذه الرسائل واكتب ملخصًا موجزًا يوضّح اهتمامات المستخدم الرئيسية، والمواضيع الشائعة، وأنماط التواصل. اجعل الملخص مختصرًا وذا مغزى (من فقرتين إلى ثلاث فقرات كحد أقصى):\n\n$messages';
  }

  @override
  String get user_dont_exist => 'المستخدم غير موجود';
}
