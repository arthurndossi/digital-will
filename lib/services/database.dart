import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dibu/models/app.dart';
import 'package:dibu/models/beneficiary.dart';
import 'package:dibu/models/client.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String? uid;
  final _authFirebase = FirebaseAuth.instance;
  final CollectionReference beneficiaryCollection = FirebaseFirestore.instance.collection('beneficiary');
  final CollectionReference clientCollection = FirebaseFirestore.instance.collection('client');

  DatabaseService({this.uid});

  Client clientFromSnapshot(DocumentSnapshot documentSnapshot) {
    return Client(
      username: documentSnapshot.get('username'),
      email: documentSnapshot.get('email'),
      name: documentSnapshot.get('name'),
      bankId: documentSnapshot.get('bankID'),
      msisdn: documentSnapshot.get('msisdn'),
      subscriptionPlan: documentSnapshot.get('subscriptionPlan'),
      newUser: documentSnapshot.get('newUser'),
      n1Days: documentSnapshot.get('n1Days'),
      n2Days: documentSnapshot.get('n2Days'),
      n3Days: documentSnapshot.get('n3Days'),
    );
  }

  List<App> appsFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) =>
      App.account(
        name: doc.get('name'),
        category: doc.get('category'),
        accessRight: doc.get('accessRight'),
        status: doc.get('status'),
        description: doc.get('description'),
        owner: doc.get('owner'),
        beneficiary: doc.get('beneficiary'),
      )
    ).toList();
  }

  List<Beneficiary> beneficiariesFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((doc) =>
        Beneficiary.get(
          name: doc.get('name'),
          dp: doc.get('dp'),
          email: doc.get('email'),
          username: doc.get('username'),
          bankId: doc.get('bankID'),
          client: doc.get('client'),
          phoneNumber: doc.get('msisdn'),
        )
    ).toList();
  }

  Future<QuerySnapshot> get myApps {
    return clientCollection.doc(uid).collection('apps').get();
  }

  // Stream<List<App>> get apps {
  //   return clientCollection.doc(uid).collection('apps').snapshots()
  //       .map(appsFromSnapshot);
  // }

  Future<QuerySnapshot> get beneficiaries {
    return clientCollection.doc(uid).collection('beneficiaries').get();
  }

  Future<DocumentSnapshot> get client {
    return clientCollection.doc(uid).get();
  }

  Future<void> saveApp(App app) async {
    await clientCollection.doc(uid).collection('apps').doc(app.name).set({
      'name': app.name,
      'beneficiary': app.beneficiary,
      'category': app.category,
      'accessRight': app.accessRight,
      'owner': uid,
      'username': app.username,
      'password': app.password,
      'token': app.token,
      'status': app.status,
      'description': app.description,
      'hasCredentials': app.hasCredentials,
      'isInstalled': app.isInstalled,
    });
  }

  Future<void> saveBeneficiary(Beneficiary beneficiary) async {
    DocumentReference reference = await beneficiaryCollection.add({
      'email': beneficiary.email,
      'dp': beneficiary.dp,
      'name': beneficiary.name,
      'username': beneficiary.username,
      'password': beneficiary.password,
      'bankID': beneficiary.bankId,
      'msisdn': beneficiary.phoneNumber,
      'newUser': true,
      'client': uid,
    });
    await clientCollection.doc(uid).collection('beneficiaries').doc(reference.id)
        .set({
          'email': beneficiary.email,
          'dp': beneficiary.dp,
          'name': beneficiary.name,
          'username': beneficiary.username,
          'msisdn': beneficiary.phoneNumber,
          'client': uid,
          'bankID': beneficiary.bankId
        });
  }

  Future<void> resetPassword(String email) async {
    await _authFirebase.sendPasswordResetEmail(email: email);
  }

  Future<UserCredential> login(String username, String password) async {
    return await _authFirebase
        .signInWithEmailAndPassword(email: username, password: password);
  }

  Future<bool> registerClient(String name, String email, String username,
      String password) async {
    try {
      final result = await _authFirebase.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      User newUser = result.user;
      await clientCollection.doc(newUser.uid).set({
        'username': username,
        'profileImage': '',
        'email': email,
        'name': name,
        'bankID': '',
        'msisdn': '',
        'subscriptionPlan': 'free',
        'newUser': true,
        'n1Days': 30,
        'n2Days': 15,
        'n3Days': 7,
      });
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code + ": " + e.message);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> saveClient(Client client) async {
    await clientCollection.add({
      'username': client.username,
      'profileImage': '',
      'email': client.email,
      'name': client.name,
      'bankID': '',
      'msisdn': '',
      'subscriptionPlan': 'free',
      'newUser': true,
      'n1Days': 30,
      'n2Days': 15,
      'n3Days': 7,
    });
  }

  Future<void> updateClient(Map<String, dynamic> map) async {
    await clientCollection.doc(uid).set(map, SetOptions(merge: true));
  }

}