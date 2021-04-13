import 'app.dart';

class Account {
  App? app;
  String? beneficiary;
  String? owner;
  String? accessRight;
  String? status;
  String? description;

  Account({this.app, this.status, this.accessRight, this.owner, this.beneficiary,
      this.description});

  @override
  String toString() {
    return 'Account(application: ${this.app}, status: ${this.status}, '
        'access right: ${this.accessRight}, owner: ${this.owner}, '
        'beneficiary: ${this.beneficiary}, description: ${this.description})';
  }
}