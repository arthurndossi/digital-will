import 'package:dibu/bank_id_login.dart';
import 'package:dibu/commons.dart';
import 'package:dibu/register.dart';
import 'package:dibu/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  final _pageKey = GlobalKey<ScaffoldState>();

  TextEditingController _username = TextEditingController(text: "");
  TextEditingController _password = TextEditingController(text: "");

  bool _isLoading = false;

  double _screenWidth = 0.0;


  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    Widget logoCircle = new Container(
      width: 150,
      height: 150,
      alignment: Alignment.center,
      child: Text(
        'Digital Will',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.w900,
          decoration: TextDecoration.none,
        ),
      ),
      decoration: new BoxDecoration(
        color: Color(0xFF62D1EA),
        shape: BoxShape.circle,
      ),
    );
    return Scaffold(
      key: _pageKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Form(
                                key: _formKey,
                                child: Container(
                                  width: _screenWidth * 0.7,
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        key: Key("username"),
                                        controller: _username,
                                        decoration: InputDecoration(
                                          fillColor: Colors.black,
                                          labelText: 'Username',
                                          hintText: 'Enter your username',
                                          prefixIcon: const Icon(Icons.person_outline),
                                        ),
                                        validator: (value) => (value!.isEmpty) ? 'Please enter your username!' : null,
                                      ),
                                      TextFormField(
                                        key: Key("password"),
                                        controller: _password,
                                        decoration: InputDecoration(
                                          fillColor: Colors.black,
                                          labelText: 'Password',
                                          hintText: 'Enter a password',
                                          prefixIcon: const Icon(Icons.lock_outline),
                                        ),
                                        validator: (value) => (value!.isEmpty) ? 'Please enter a password!' : null,
                                      ),
                                      SizedBox(height: 32.0,),
                                      _isLoading ? Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CircularProgressIndicator(),
                                            SizedBox(width: 20,),
                                            Text("Authenticating...")
                                          ],
                                        )
                                      ) : ElevatedButton(
                                        onPressed: () async {
                                          if (_formKey.currentState!.validate()) {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            try {
                                              final result = await DatabaseService()
                                                  .login(_username.text, _password.text);
                                              User user = result.user;
                                              Commons().saveLoginStatus(user);
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Home(uid: user.uid)
                                                  )
                                              );
                                            } catch (e) {
                                              showDialog(
                                                  context: context,
                                                  builder: (
                                                      BuildContext context) =>
                                                      AlertDialog(
                                                        title: Text("Error!"),
                                                        content: Text(
                                                            (e as FirebaseAuthException).message),
                                                        backgroundColor: Colors
                                                            .white,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius: new BorderRadius
                                                                .circular(
                                                                15)),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            child: Text(
                                                                "Ok"),
                                                            textColor: Colors
                                                                .black,
                                                            onPressed: () {
                                                              Navigator.of(
                                                                  context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ],
                                                      )
                                              );
                                              setState(() =>
                                              _isLoading = false);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar
                                                (content: Text("Could not login."))
                                              );
                                            }
                                          }
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
                                    ],
                                  ),
                                ),
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
          ],
        ),
      ),
    );
  }
}
