import 'app.dart';

class Beneficiary {
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

  Beneficiary(this.name, this.email, this.dp, this.apps);

  Beneficiary.save({
    this.name,
    this.dp,
    this.email,
    this.username,
    this.password,
    this.bankId,
    this.client,
    this.phoneNumber
  });

  Beneficiary.get({
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
    return 'Beneficiary(name: ${this.name}, email: ${this.email}, displayPicture: ${this.dp}'
        ' phone number: ${this.phoneNumber})';
  }
}