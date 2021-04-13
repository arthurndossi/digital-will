import 'package:flutter/material.dart';

class App {
  String? name;
  String? icon;
  CircleAvatar? avatar;
  String? category;
  String? subTitle;
  String? accessRight;
  String? owner;
  String? username;
  String? password;
  String? token;
  String? status;
  String? description;
  Map<String, String>? beneficiary;
  bool hasCredentials = false;
  bool isInstalled = true;

  App(this.name, this.icon, this.category);

  App.installed(this.name, this.avatar, this.category);

  App.account({
    this.name,
    this.icon,
    this.avatar,
    this.category,
    this.accessRight,
    this.status,
    this.description,
    this.owner,
    this.beneficiary,
  });

  App.newApp(
      this.name,
      this.category,
      this.accessRight,
      this.username,
      this.password,
      this.token,
      this.beneficiary,
      this.hasCredentials,
      this.isInstalled
  );

  @override
  String toString() {
    return 'App(name: ${this.name}, category: ${this.category}';
  }
}