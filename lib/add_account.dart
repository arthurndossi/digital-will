import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dibu/models/app.dart';
import 'package:dibu/models/keys.dart';
import 'package:dibu/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/beneficiary.dart';

class AddAccount extends StatefulWidget {
  final String? appName;
  final String? category;
  final bool isInstalled;
  final String uid;

  const AddAccount({this.appName, this.category, required this.isInstalled, required this.uid});

  @override
  _AddAccountState createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {

  final _formKey = GlobalKey<FormState>();

  String? _categoryVal;
  String? _accountVal;
  String? _actionVal;
  Beneficiary? _beneficiaryVal;

  List<String> _categoryList = ['Social', 'Cloud Storage', 'Cryptocurrency',
    'Streaming'];
  List<String> _accountsList = [];
  List<String> _socialList = ['Facebook', 'Instagram', 'WhatsApp', 'Likee',
    'Linked In', 'Snapchat', 'Twitter', 'TikTok', 'Tinder', 'Skype'];
  List<String> _storageList = ['Google Drive', 'iCloud', 'Dropbox'];
  List<String> _streamingList = ['Netflix', 'Spotify', 'Prime Video'];
  List<String> _cryptoCurrencyList = ['Coin base', 'Bitcoin', 'Ethereum'];
  List<String>? _accessRights = [];
  List<Beneficiary>? _beneficiaries;

  bool _isLoading = false;

  double screenWidth = 0.0;

  TextEditingController _username = TextEditingController(text: "");
  TextEditingController _password = TextEditingController(text: "");

  @override
  void initState() {
    _accountVal = widget.appName;
    _categoryVal = widget.category;
    if (_categoryVal == 'Social')
      _accountsList = _socialList;
    else if (_categoryVal == 'Streaming')
      _accountsList = _streamingList;
    else if (_categoryVal == 'Cloud Storage')
      _accountsList = _storageList;
    else if (_categoryVal == 'Cryptocurrency')
      _accountsList = _cryptoCurrencyList;
    else
      _accountsList = [];
    _accessRights = ['Delete account', 'Full Access', 'Partial Access'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: DatabaseService(uid: widget.uid).beneficiaries,
      builder: (context, data) {
        if (data.hasData) {
          _beneficiaries = DatabaseService(uid: widget.uid)
              .beneficiariesFromSnapshot(data.data as QuerySnapshot);
        }
        return Container(
          child: Column(
            children: [
              Expanded(
                child: _isLoading ? Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(width: 20,),
                        Text("Saving...")
                      ],
                    )
                ) : ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'ADD ACCOUNT',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 8.0,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
                                child: Container(
                                  width: screenWidth * 0.7,
                                  child: Column(
                                    children: <Widget>[
                                      DropdownButtonFormField(
                                        value: _categoryVal,
                                        items: _categoryList.map((e) =>
                                            DropdownMenuItem(
                                              child: Text(e),
                                              value: e,
                                            )).toList(),
                                        hint: Text('--Choose Category--'),
                                        onChanged: (newVal) {
                                          setState(() {
                                            _categoryVal = newVal as String?;
                                            if (_categoryVal == 'Social')
                                              _accountsList = _socialList;
                                            else if (_categoryVal == 'Streaming')
                                              _accountsList = _streamingList;
                                            else if (_categoryVal == 'Cloud Storage')
                                              _accountsList = _storageList;
                                            else if (_categoryVal == 'Cryptocurrency')
                                              _accountsList = _cryptoCurrencyList;
                                            else
                                              _accountsList = [];
                                          });
                                        },
                                      ),
                                      DropdownButtonFormField(
                                        value: _accountVal,
                                        items: _accountsList.map((e) =>
                                            DropdownMenuItem(
                                              child: Text(e),
                                              value: e,
                                            )).toList(),
                                        hint: Text('--Choose App--'),
                                        onChanged: (newVal) {
                                          setState(() {
                                            _accountVal = newVal as String?;
                                            if (_accountVal != '--Choose Action--')
                                              _accessRights = ['Delete account',
                                                'Full Access', 'Partial Access'];
                                          });
                                        },
                                      ),
                                      DropdownButtonFormField(
                                        value: _actionVal,
                                        items: _accessRights!.map((e) => DropdownMenuItem(
                                          child: Text(e),
                                          value: e,
                                        )).toList(),
                                        hint: Text('--Choose Action--'),
                                        onChanged: (newVal) {
                                          setState(() {
                                            _actionVal = newVal as String?;
                                          });
                                        },
                                      ),
                                      TextFormField(
                                        controller: _username,
                                        decoration: InputDecoration(
                                          fillColor: Colors.black,
                                          labelText: 'Username',
                                          hintText: 'Enter your username',
                                          prefixIcon: const Icon(Icons.person_outline),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty)
                                            return 'Please enter your username!';
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        controller: _password,
                                        decoration: InputDecoration(
                                          fillColor: Colors.black,
                                          labelText: 'Password',
                                          hintText: 'Enter a password',
                                          prefixIcon: const Icon(Icons.lock_outline),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty)
                                            return 'Please enter a password!';
                                          return null;
                                        },
                                      ),
                                      DropdownButtonFormField(
                                        value: _beneficiaryVal,
                                        items: _beneficiaries != null ?
                                        _beneficiaries!.map((e) => DropdownMenuItem(
                                          child: Text(e.name!),
                                          value: e,
                                        )).toList() : null,
                                        hint: Text('--Choose Beneficiary--'),
                                        onChanged: (newVal) {
                                          setState(() {
                                            _beneficiaryVal = newVal as Beneficiary?;
                                          });
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 32.0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!.validate()) {
                                              setState(() => _isLoading = true);
                                              // if (!widget.isInstalled) {
                                                Map<String, String> benMap = Map();
                                                if (_beneficiaryVal != null)
                                                  benMap = {
                                                    'uid': _beneficiaryVal!.uid!,
                                                    'name': _beneficiaryVal!.name!
                                                  };
                                                App app = App.newApp(
                                                    _accountVal!,
                                                    _categoryVal!,
                                                    _actionVal!,
                                                    _username.text,
                                                    _password.text,
                                                    "",
                                                    benMap,
                                                    true,
                                                    widget.isInstalled
                                                );
                                                DatabaseService(uid: widget.uid)
                                                    .saveApp(app);
                                              // }
                                              setState(() => _isLoading = false);
                                              NavKey.innerNavKey.currentState!.pop();
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
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
