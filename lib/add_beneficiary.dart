import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddBeneficiary extends StatefulWidget {
  final page;

  const AddBeneficiary({this.page});

  @override
  _AddBeneficiaryState createState() => _AddBeneficiaryState();
}

class _AddBeneficiaryState extends State<AddBeneficiary> {

  final _formKey = GlobalKey<FormState>();

  double screenWidth = 0.0;

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
                      child: Text('ADD BENEFICIARY', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
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
                                  TextFormField(
                                    decoration: InputDecoration(
                                      fillColor: Colors.black,
                                      labelText: 'Full Name',
                                      hintText: 'Enter your full name',
                                      // helperText: 'At least two names eg. John Doe',
                                      prefixIcon: const Icon(Icons.person),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty)
                                        return 'Please enter your full name';
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      fillColor: Colors.black,
                                      labelText: 'Email',
                                      hintText: 'Enter your email',
                                      prefixIcon: const Icon(Icons.email_outlined),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty)
                                        return 'Please enter your email';
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      fillColor: Colors.black,
                                      labelText: 'Phone number',
                                      hintText: 'Enter your mobile number',
                                      prefixIcon: const Icon(Icons.smartphone),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty)
                                        return 'Please enter your mobile number!';
                                      return null;
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
