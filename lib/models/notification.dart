import 'app.dart';

class Notification {
  String? uid;
  String? name;
  String? dp;
  String? email;
  String? username;
  String? password;
  String? bankId;
  List<App>? apps;
  String? client;
  String? phoneNumber;

  Notification(this.name, this.email, this.dp, this.apps);

  Notification.create({
    this.name,
    this.dp,
    this.email,
    this.username,
    this.password,
    this.bankId,
    this.client,
    this.phoneNumber
  });

  Notification.get({
    this.uid,
    this.name,
    this.dp,
    this.email,
    this.username,
    this.bankId,
    this.client,
    this.phoneNumber
  });

  @override
  String toString() {
    return 'Notification(name: ${this.name}, email: ${this.email}, displayPicture: ${this.dp}'
        ' phone number: ${this.phoneNumber})';
  }
}