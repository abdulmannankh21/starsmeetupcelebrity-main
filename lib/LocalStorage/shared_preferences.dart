import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class MyPreferences {
  static final MyPreferences _instance = MyPreferences._();
  static MyPreferences get instance => _instance;

  MyPreferences._();

  final String _token = "token";
  final String _firstName = "firstName";
  final String _phone = "phone";
  final String _email = "email";
  final String _password = "password";
  final String _user = "_user";

  static late SharedPreferences _preferences;
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  void setToken({String? token}) {
    _preferences.setString(_token, token!);
  }

  void setPassword({String? password}) {
    _preferences.setString(_password, password!);
  }

  void setName({String? name}) {
    _preferences.setString(_firstName, name!);
  }

  void setEmail({String? email}) {
    _preferences.setString(_email, email!);
  }


  void setUser({UserModel? user}) {
    _preferences.setString(_user, jsonEncode(user!.toJson()));
  }

  void setPhone({String? phone}) {
    _preferences.setString(_phone, phone!);
  }

  void clearPreferences() {
    _preferences.clear();
  }

  String? getPassword() => _preferences.getString(_password);
  String? getToken() => _preferences.getString(_token);
  String? getFirstName() => _preferences.getString(_firstName);
  String? getPhone() => _preferences.getString(_phone);
  String? getEmail() => _preferences.getString(_email);
  UserModel? get user {
    final userString = _preferences.getString(_user);
    if (userString != null) {
      final userJson = jsonDecode(userString);
      return UserModel.fromJson(userJson);
    }
    return null;
  }


}
