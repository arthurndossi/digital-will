import 'app.dart';

class Beneficiary {
  String fullName;
  String dp;
  String email;
  List<App> apps;
  String owner;
  String phoneNumber;

  Beneficiary(this.fullName, this.email, this.dp, this.apps);

  @override
  String toString() {
    return 'Beneficiary(name: ${this.fullName}, email: ${this.email}, displayPicture: ${this.dp}'
        ' phone number: ${this.phoneNumber})';
  }
}