import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dibu/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'edit_profile.dart';
import 'models/client.dart';
import 'models/keys.dart';

class ClientProfile extends StatefulWidget {
  final String uid;

  const ClientProfile({required this.uid});

  @override
  _ClientProfileState createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {

  late Client _client;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DatabaseService(uid: widget.uid).client,
      builder: (context, data) {
        if (data.data == null) {
          return const Center(child: CircularProgressIndicator(),);
        } else {
          DocumentSnapshot snapshot = data.data as DocumentSnapshot;
          _client = DatabaseService(uid: widget.uid).clientFromSnapshot(snapshot);
          return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF62D1EA), Color(0xFF00d4ff)]
                      ),
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                              MediaQuery.of(context).size.width, 100.0)
                      )
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 250.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(
                                  (_client.profileImage == null ? "" : _client.profileImage)!
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Text(client.username, style: TextStyle(fontSize: 20),),
                          // ),
                          Text(
                            _client.name!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            _client.email!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                            ),
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.0,horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Phone Number:",
                                style: TextStyle(fontWeight: FontWeight.bold)
                              ),
                              SizedBox(width: 10.0),
                              Text(_client.msisdn!),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Visibility(
                            child: Row(
                              children: [
                                Text(
                                  "Bank ID:",
                                  style: TextStyle(fontWeight: FontWeight.bold)
                                ),
                                SizedBox(width: 10.0),
                                Text(_client.bankId!),
                              ],
                            ),
                            visible: _client.bankId != null,
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Text(
                                "Subscription Plan:",
                                style: TextStyle(fontWeight: FontWeight.bold)
                              ),
                              SizedBox(width: 10.0),
                              Text(_client.subscriptionPlan!),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Text(
                                "First notification interval (in days):",
                                style: TextStyle(fontWeight: FontWeight.bold)
                              ),
                              SizedBox(width: 10.0),
                              Text(_client.n1Days.toString()),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Text(
                                "Second notification interval (in days):",
                                style: TextStyle(fontWeight: FontWeight.bold)
                              ),
                              SizedBox(width: 10.0),
                              Text(_client.n2Days.toString()),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Text(
                                "Third notification interval (in days):",
                                style: TextStyle(fontWeight: FontWeight.bold)
                              ),
                              SizedBox(width: 10.0),
                              Text(_client.n3Days.toString()),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Text(
                                  "Number of Apps:",
                                  style: TextStyle(fontWeight: FontWeight.bold)
                              ),
                              SizedBox(width: 10.0),
                              Text(""),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Text(
                                  "Number of Beneficiaries:",
                                  style: TextStyle(fontWeight: FontWeight.bold)
                              ),
                              SizedBox(width: 10.0),
                              Text(""),
                            ],
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            width: 200.0,
                            child: RaisedButton(
                              onPressed: () {
                                _editAndUpdateClient();
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)
                              ),
                              elevation: 0.0,
                              padding: EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                    colors: [
                                      Color(0xFF62D1EA),
                                      Color(0xFF00d4ff)
                                    ]
                                  ),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Container(
                                  constraints: BoxConstraints(maxWidth: 200.0, minHeight: 40.0),
                                  alignment: Alignment.center,
                                  child: Text("Edit Profile",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight:FontWeight.bold
                                    ),
                                  ),
                                ),
                              )
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
          );
        }
      }
    );
  }

  _editAndUpdateClient() async {
    final result = await NavKey.innerNavKey.currentState!.push(
        MaterialPageRoute(
            builder: (context) => EditProfile(
                uid: widget.uid,
                client: _client
            )
        )
    );
    setState(() {
      if (result != null) _client = result;
    });
  }
}
