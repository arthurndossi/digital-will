import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddAccount extends StatefulWidget {
  final page;

  const AddAccount({this.page});

  @override
  _AddAccountState createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {

  final _formKey = GlobalKey<FormState>();

  String _categoryVal;
  String _accountVal;
  String _actionVal;

  List<String> _accountsList;
  List<String> _socialList;
  List<String> _storageList;
  List<String> _cryptoCurrencyList;
  List<String> _accessRights;

  double screenWidth = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    _categoryVal = '--Choose Category--';
    _accountVal = '--Choose App--';
    _actionVal = '--Choose Action--';
    _accountsList = [];
    _socialList = ['--Choose App--', 'Facebook', 'Instagram', 'Likee', 'Linked In' 'Snapchat', 'Twitter', 'TikTok', 'Tinder'];
    _storageList = ['--Choose App--', 'Google Drive', 'iCloud', 'Dropbox'];
    _cryptoCurrencyList = ['--Choose App--', 'Coin base', 'Bitcoin', 'Ethereum'];
    _accessRights = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text('ADD ACCOUNT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
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
                                    items: <String>['--Choose Category--', 'Social Media', 'Cloud Storage', 'Cryptocurrency']
                                        .map((e) => DropdownMenuItem(
                                          child: Text(e),
                                          value: e,
                                        )).toList(),
                                    onChanged: (newVal) {
                                      setState(() {
                                        _categoryVal = newVal;
                                        if (_categoryVal == 'Social Media')
                                          _accountsList = _socialList;
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
                                    items: _accountsList.map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    )).toList(),
                                    onChanged: (newVal) {
                                      setState(() {
                                        _accountVal = newVal;
                                        if (_accountVal != '--Choose Action--')
                                          _accessRights = ['--Choose Action--', 'Delete account', 'Full Access', 'Partial Access'];
                                      });
                                    },
                                  ),
                                  DropdownButtonFormField(
                                    value: _actionVal,
                                    items: _accessRights.map((e) => DropdownMenuItem(
                                      child: Text(e),
                                      value: e,
                                    )).toList(),
                                    onChanged: (newVal) {
                                      setState(() {
                                        _actionVal = newVal;
                                      });
                                    },
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      fillColor: Colors.black,
                                      labelText: 'Username',
                                      hintText: 'Enter your username',
                                      prefixIcon: const Icon(Icons.person_outline),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty)
                                        return 'Please enter your username!';
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      fillColor: Colors.black,
                                      labelText: 'Password',
                                      hintText: 'Enter a password',
                                      prefixIcon: const Icon(Icons.lock_outline),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty)
                                        return 'Please enter a password!';
                                      return null;
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 32.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        widget.page('HomePage');
                                        // if (_formKey.currentState.validate()) {
                                        //   ScaffoldMessenger.of(context)
                                        //       .showSnackBar(SnackBar(content: Text('Authenticating')));
                                        // }
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
}
