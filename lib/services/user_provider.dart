import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scalex_chatbot/models/http_exceptions.dart';
import 'package:scalex_chatbot/models/user_model.dart';
import 'package:scalex_chatbot/services/room_manager.dart';
import 'package:scalex_chatbot/widgets/error_popup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scalex_chatbot/l10n/app_localizations.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference userCollection = FirebaseFirestore.instance
      .collection("users");
  UserModel user = UserModel("", "", "", "");
  final RoomManager _roomManager = RoomManager();
  
  // Get RoomManager instance
  RoomManager get roomManager => _roomManager;
  
  bool get isLoggedIn => user.isValid;

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user')) {
      final userData = json.decode(prefs.getString('user').toString());
      user = UserModel.fromJson(userData);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  Future<void> setUser(UserModel user1) async {
    user = user1;
    await _roomManager.init(user);
    notifyListeners();
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
    required BuildContext context,
    required Function(UserModel) onSuccess,
  }) async {
    return await handleErrors(context, () async {
      try {
        final result = await auth.signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );
        final firebaseUser = result.user;
        if (firebaseUser == null) {
          if (!context.mounted) {
            return {"success": false, "code": "user-dont-exist"};
          }

          showDialog(
            context: context,
            builder: (_) => ErrorPopup(
              AppLocalizations.of(context)!.common_alert,
              AppLocalizations.of(context)!.user_not_found,
            ),
          );
          return {"success": false, "code": "user-null"};
        }

        final userSnapshot = await userCollection.doc(firebaseUser.uid).get();
        if (!userSnapshot.exists) {
          if (!context.mounted) {
            return {"success": false, "code": "user-dont-exist"};
          }
          showDialog(
            context: context,
            builder: (_) => ErrorPopup(
              AppLocalizations.of(context)!.common_alert,
              AppLocalizations.of(context)!.user_dont_exist,
            ),
          );
          return {"success": false, "code": "user-dont-exist"};
        }

        final userData = UserModel.fromJson(
          userSnapshot.data()! as Map<String, dynamic>,
        );
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', json.encode(userData.toJson()));

        user = userData;
        notifyListeners();
        onSuccess(userData);
        return {"success": true};
      } on FirebaseAuthException catch (e) {
        String message;
        if (!context.mounted) return {"success": false, "code": e.code};
        switch (e.code) {
          case 'user-not-found':
            message = AppLocalizations.of(context)!.user_not_found;
            break;
          case 'wrong-password':
            message = AppLocalizations.of(context)!.wrong_password;
            break;
          case 'invalid-email':
            message = AppLocalizations.of(context)!.invalid_email;
            break;
          case 'network-request-failed':
            message = AppLocalizations.of(context)!.no_internet_access;
            break;
          case 'user-dont-exist':
            message = AppLocalizations.of(context)!.user_dont_exist;
            break;
          default:
            message = AppLocalizations.of(context)!.unknown_error;
        }
        showDialog(
          context: context,
          builder: (_) =>
              ErrorPopup(AppLocalizations.of(context)!.common_alert, message),
        );
        return {"success": false, "code": e.code};
      }
    });
  }

  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required BuildContext context,
    required Function(UserModel) onSuccess,
  }) async {
    return await handleErrors(context, () async {
      try {
        final result = await auth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );
        final userModel = UserModel(
          result.user!.uid,
          firstName.trim(),
          lastName.trim(),
          email.trim(),
        );
        try {
          await userCollection.doc(userModel.uid).set(userModel.toJson());
        } catch (firestoreError) {
          if (!context.mounted) {
            return {"success": false, "code": "firestore-error"};
          }
          showDialog(
            context: context,
            builder: (_) => ErrorPopup(
              AppLocalizations.of(context)!.common_alert,
              AppLocalizations.of(context)!.unknown_error,
            ),
          );
          return {"success": false, "code": "firestore-error"};
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', json.encode(userModel.toJson()));

        user = userModel;
        notifyListeners();
        onSuccess(userModel);
        return {"success": true};
      } on FirebaseAuthException catch (e) {
        String message;
        if (!context.mounted) return {"success": false, "code": e.code};
        switch (e.code) {
          case 'email-already-in-use':
            message = AppLocalizations.of(context)!.email_already_used;
            break;
          case 'invalid-email':
            message = AppLocalizations.of(context)!.invalid_email;
            break;
          case 'weak-password':
            message = AppLocalizations.of(context)!.weak_password;
            break;
          default:
            message = AppLocalizations.of(context)!.unknown_error;
        }
        showDialog(
          context: context,
          builder: (_) =>
              ErrorPopup(AppLocalizations.of(context)!.common_alert, message),
        );
        return {"success": false, "code": e.code};
      }
    });
  }

  Future<void> logout() async {
    await _roomManager.clearUserData();
    user = UserModel("", "", "", "");
    notifyListeners();
  }
}
