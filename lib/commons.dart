import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'login.dart';

class Commons {

  Future<String> getUid() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: "uid");
  }

  Future saveLoginStatus(User user) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: "uid", value: user.uid);
    await storage.write(key: "username", value: user.displayName);
    await storage.write(key: "login_status", value: "logged_in");
  }

  Future<String> checkLoginStatus() async {
    final storage = FlutterSecureStorage();
    String loginStatus = await storage.read(key: "login_status");
    return loginStatus;
  }

  Future logout(BuildContext context) async {
    final storage = FlutterSecureStorage();
    await FirebaseAuth.instance.signOut();
    await storage.write(key: "login_status", value: "logged_out");
    await storage.delete(key: 'username');
    await storage.delete(key: 'uid');
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }
}