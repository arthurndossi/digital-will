import 'package:flutter/material.dart';

class App {
  String name;
  CircleAvatar icon;
  String category;
  String subTitle;
  bool showDialog = false;

  App(this.name, this.icon, this.category);

  @override
  String toString() {
    return 'App(name: ${this.name}, category: ${this.category}, subTitle: ${this.subTitle}, showDialog: ${this.showDialog})';
  }
}