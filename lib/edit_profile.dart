import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/client.dart';
import 'models/keys.dart';
import 'services/database.dart';

class EditProfile extends StatefulWidget {
  final String uid;
  final Client? client;

  const EditProfile({required this.uid, this.client});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  bool _isLoading = false;
  late Client _client;
  String? _profileImage;
  TextEditingController? _name;
  TextEditingController? _username;
  TextEditingController? _msisdn;
  TextEditingController? _bankId;
  TextEditingController? _n1Days;
  TextEditingController? _n2Days;
  TextEditingController? _n3Days;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _client = widget.client!;
    _profileImage = _client.profileImage == null ? "" : _client.profileImage;
    _name = TextEditingController(text: _client.name == null ? "" : _client.name);
    _username = TextEditingController(text: _client.username == null ? "" : _client.username);
    _msisdn = TextEditingController(text: _client.msisdn == null ? "" : _client.msisdn);
    _bankId = TextEditingController(text: _client.bankId == null ? "" : _client.bankId);
    _n1Days = TextEditingController(text: _client.n1Days.toString() == null ? "0" : _client.n1Days.toString());
    _n2Days = TextEditingController(text: _client.n2Days.toString() == null ? "0" : _client.n2Days.toString());
    _n3Days = TextEditingController(text: _client.n3Days.toString() == null ? "0" : _client.n3Days.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _isLoading ? Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20,),
              Text("Saving...")
            ],
          )
      ) : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10,),
          Text(
            "Edit Profile",
            style: TextStyle(fontSize: 30)
          ),
          SizedBox(height: 10,),
          GestureDetector(
            onTap: () {

            },
            child: CircleAvatar(
              radius: 60.0,
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(_profileImage!),
            ),
          ),
          SizedBox(height: 10,),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 8.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _username,
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          labelText: 'Username',
                          hintText: 'Edit username',
                          prefixIcon: const Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Please enter your username!';
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _name,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          labelText: 'Name',
                          hintText: 'Edit name',
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Please enter your name!';
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _msisdn,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          labelText: 'Phone number',
                          hintText: 'Edit phone number',
                          prefixIcon: const Icon(Icons.smartphone),
                        ),
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Please enter your phone number!';
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _bankId,
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          labelText: 'Bank ID',
                          prefixIcon: const Icon(Icons.assignment_ind_outlined),
                        )
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                          controller: _n1Days,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            fillColor: Colors.black,
                            labelText: 'First Notification (in Days)',
                            prefixIcon: const Icon(Icons.notification_important_outlined),
                          )
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                          controller: _n2Days,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            fillColor: Colors.black,
                            labelText: 'Second Notification (in Days)',
                            prefixIcon: const Icon(Icons.notification_important_outlined),
                          )
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                          controller: _n3Days,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            fillColor: Colors.black,
                            labelText: 'Third Notification (in Days)',
                            prefixIcon: const Icon(Icons.notification_important_outlined),
                          )
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() => _isLoading = true);
                            _client.username = _username!.text;
                            _client.name = _name!.text;
                            _client.bankId = _bankId!.text;
                            _client.msisdn = _msisdn!.text;
                            _client.n1Days = int.parse(_n1Days!.text);
                            _client.n2Days = int.parse(_n2Days!.text);
                            _client.n3Days = int.parse(_n3Days!.text);
                            Map<String, dynamic> clientMap = {
                              'username': _username!.text,
                              'name': _name!.text,
                              'bankID': _bankId!.text,
                              'msisdn': _msisdn!.text,
                              'n1Days': int.parse(_n1Days!.text),
                              'n2Days': int.parse(_n2Days!.text),
                              'n3Days': int.parse(_n3Days!.text),
                            };
                            saving(clientMap);
                            setState(() => _isLoading = false);
                            NavKey.innerNavKey.currentState!.pop(_client);
                          }
                        },
                        child: Text(
                            'SAVE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            )
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(155.35, 46.87)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ]
      )
    );
  }

  saving(Map<String, dynamic> clientMap) async {
    await DatabaseService(uid: widget.uid).updateClient(clientMap);
  }
}
