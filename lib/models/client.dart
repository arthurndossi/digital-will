class Client {

  String? uid;
  String? username;
  String? profileImage;
  String? email;
  String? name;
  String? bankId;
  String? msisdn;
  String? subscriptionPlan;
  bool newUser = false;
  int n1Days;
  int n2Days;
  int n3Days;

  Client({
    this.uid,
    this.username,
    this.email,
    this.name,
    this.bankId,
    this.msisdn,
    required this.newUser,
    this.subscriptionPlan,
    required this.n1Days,
    required this.n2Days,
    required this.n3Days
  });

  Client.update(
    this.uid,
    this.username,
    this.name,
    this.bankId,
    this.msisdn,
    this.n1Days,
    this.n2Days,
    this.n3Days
  );
}