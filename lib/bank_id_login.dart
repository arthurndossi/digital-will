import 'package:dibu/login.dart';
import 'package:dibu/register.dart';
import 'package:dibu/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BankIDLogin extends StatefulWidget {
  @override
  _BankIDLoginState createState() => _BankIDLoginState();
}

class _BankIDLoginState extends State<BankIDLogin> {

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
          decoration: TextDecoration.none,
        ),
      ),
      decoration: new BoxDecoration(
        color: Color(0xFF62D1EA),
        shape: BoxShape.circle,
      ),
    );
    return Container(
      color: Colors.white,
      child: Stack(
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
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: Container(
                            width: screenWidth * 0.7,
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                      fillColor: Colors.black,
                                      labelText: 'Bank ID',
                                      hintText: 'Enter your bank ID',
                                      prefixIcon: const Icon(Icons.assignment_ind_outlined),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty)
                                        return 'Please enter your username!';
                                      return null;
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 32.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Welcome()));
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
                          ),
                        )
                      ]
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: InkWell(
                                child: Text(
                                  'Normal Login',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF62D1EA),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login())),
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
                      ],
                    ),
                    flex: 1,
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
