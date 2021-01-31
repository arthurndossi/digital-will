import 'package:dibu/bank_id_login.dart';
import 'package:dibu/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();

  double screenWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    Widget logoCircle = new Container(
      width: 150,
      height: 150,
      alignment: Alignment.center,
      child: Text(
        'DIBU',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 36,
          decoration: TextDecoration.none,
        ),
      ),
      decoration: new BoxDecoration(
        color: Color(0xFF62D1EA),
        shape: BoxShape.circle,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Card(
            margin: EdgeInsets.fromLTRB(20.0, 120.0, 20.0, 40.0),
            color: Colors.white,
            shadowColor: Color(0xFFC4C4C4),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Column(
                children: [
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 36,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ]
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Form(
                                  key: _formKey,
                                  child: Container(
                                    width: screenWidth * 0.7,
                                    child: Column(
                                      children: <Widget>[
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
                                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
                                              // if (_formKey.currentState.validate()) {
                                              //   ScaffoldMessenger.of(context)
                                              //       .showSnackBar(SnackBar(content: Text('Authenticating')));
                                              // }
                                            },
                                            child: Text(
                                                'LOGIN',
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
                                )
                              ]
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: InkWell(
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF62D1EA),
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Register())),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Text(
                                  'OR',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFFC4C4C4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        child: Text(
                                          'Bank ID',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF62D1EA),
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => BankIDLogin())),
                                      ),
                                      SizedBox(width: 10,),
                                      InkWell(
                                        child: Image.asset('assets/images/png/g-icon.png', width: 50.0, height: 50.0,),
                                      ),
                                      SizedBox(width: 10,),
                                      InkWell(
                                        child: Image.asset('assets/images/png/fb-icon.png', width: 50.0, height: 50.0,),
                                      ),
                                    ]
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: InkWell(
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xFF62D1EA),
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Register())),
                                ),
                              ),
                            ],
                          ),
                        ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: logoCircle,
            ),
          ),
        ],
      ),
    );
  }
}
