import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:loggin_screen/Services/recordmodel.dart';
import 'package:loggin_screen/component/snackbars.dart';
import 'package:loggin_screen/hive/LoginBox.dart';
import 'package:loggin_screen/model/prefs.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PocketBaseAuthClass {
  PocketBase pb = PocketBase('http://10.0.2.2:8090/');
  // PocketBase pb = PocketBase('http://192.168.1.7:8023/');
  AuthStore authStore = AuthStore();
  init() async {
    await initAuthStore();
    try {
      pb = PocketBase('http://10.0.2.2:8090/', authStore: authStore);
      print("pb auth:${pb.authStore.model}");
    } catch (e) {
      print("Error inside custom auth;${e.toString()}");
    }
  }

  initAuthStore() async {
    final prefs = await SharedPreferences.getInstance();
    final token = await prefs.getString(PrefKeys.accessTokenPrefsKey);
    int? key = await prefs.getInt("modelkey");
    print("key:${key != null ? key.toString() : "null"}");
    var modelbox = await Hive.openBox<AuthRecordModelBoxtype>("authmodel");
    print("modelbox:${modelbox.values.toList()}");
    var modeldata;
    if (key != null) {
      modeldata = await modelbox.get(key);
      print("modeldata:${modeldata.id}");
    } else {
      modeldata = null;
    }

    if (modeldata == null || token == null) return;
    authStore.save(token, modeldata);
  }

  String _username = "";

  String get username => _username;
  Future<bool> signup(String name, String password, String confirmpassword,
      String email, BuildContext context) async {
    final body = <String, dynamic>{
      "username": email,
      "email": email,
      "emailVisibility": true,
      "password": password,
      "passwordConfirm": password,
      "name": name,

      ///"profile is used to set type of user(User or admin) please add a variable which decide user according to the login form"
      "profile": "admin"
    };
    late final record;
    try {
      record = await pb.collection('users').create(body: body);

      return true;
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(errorSnackbar(err.toString()));
      return false;
    }
  }

  Future<String?> emailotp(String email) async {
    try {
      final body = {"email": email};
      final res = await pb.send("/mailMFA", method: "POST", body: body);
      return res['id'];
    } catch (e) {
      return null;
    }
  }

  Future<bool> verifymailotp(String id, String otp) async {
    final body = {
      "id": id,
      "otp": otp,
    };
    // print("id==$id");
    bool err = false;
    late final res;
    try {
      res = await pb.send("/mailverification", body: body);
    } catch (error) {
      print(error);
      err = true;
    }
    if (!err && res["verification"] == true) {
      return true;
    }
    return false;
  }

// To check whether provided email id is existed in server or not
  Future<bool> checkemailnotexist(String email) async {
    bool res = false;
    final rec;

    try {
      rec = await pb.collection("users").getFullList();
      res = rec.any((element) => element.data['email'] == email);
      return !res;
    } catch (err) {
      print(err.toString());
      return res;
    }
  }

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      final authData =
          await pb.collection("users").authWithPassword(email, password);
      _username = authData.record?.data['username'].toString() ?? "";
      print("pb inside login :: ${pb.authStore.token} ");
      ScaffoldMessenger.of(context)
          .showSnackBar(errorSnackbar("${pb.authStore.token}"));
      print("In side login:: ${pb.authStore.model}");
      AuthModelRecord model =
          AuthModelRecord.fromRecordModel(pb.authStore.model as RecordModel);
      var modelbox = await Hive.openBox<AuthRecordModelBoxtype>("authmodel");
      final boxkey =
          await modelbox.add(AuthRecordModelBoxtype.fromAuthModelRecord(model));
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(PrefKeys.accessTokenPrefsKey, pb.authStore.token);
      prefs.setString(
          PrefKeys.accessModelPrefsKey, pb.authStore.model.id ?? '');
      prefs.setString(PrefKeys.accessNamePrefsKey, _username);
      prefs.setInt("modelkey", boxkey);
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(errorSnackbar("Login Error:" + e.toString()));
      return false;
    }
  }

  void logout() async {
    print("In logout pb authmodel:${pb.authStore.model}");
    pb.authStore.clear();
    final prefs = await SharedPreferences.getInstance();
    int? key = await prefs.getInt("modelkey");
    var modelbox = await Hive.openBox<AuthRecordModelBoxtype>("authmodel");
    var modeldata;
    await modelbox.delete(key);
    prefs.remove("modelkey");
    prefs.remove(PrefKeys.accessTokenPrefsKey);
    prefs.remove(PrefKeys.accessModelPrefsKey);
    prefs.remove(PrefKeys.accessNamePrefsKey);
  }

  static final PocketBaseAuthClass _pocketBaseAuthClass =
      PocketBaseAuthClass._internal();

  factory PocketBaseAuthClass() {
    return _pocketBaseAuthClass;
  }

  PocketBaseAuthClass._internal();
}
