import 'package:dibu/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  // final _authFirebase = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  bool _checked = false;
  bool _isLoading = false;

  double screenWidth = 0.0;

  TextEditingController _name = TextEditingController(text: "");
  TextEditingController _email = TextEditingController(text: "");
  TextEditingController _username = TextEditingController(text: "");
  TextEditingController _password = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    Widget logoCircle = new Container(
      width: 150,
      height: 150,
      alignment: Alignment.center,
      child: Text(
        'Digital Will',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w900,
          color: Colors.white,
          decoration: TextDecoration.none,
        ),
      ),
      decoration: new BoxDecoration(
        color: Color(0xFF62D1EA),
        shape: BoxShape.circle,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
                children: [
                  Card(
                    margin: EdgeInsets.fromLTRB(20.0, 120.0, 20.0, 20.0),
                    color: Colors.white,
                    shadowColor: Color(0xFFC4C4C4),
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 70.0),
                      child: Container(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                              child: Form(
                                key: _formKey,
                                child: ListView(
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                          'Register',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 36,
                                            decoration: TextDecoration.underline,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _name,
                                      textCapitalization: TextCapitalization.words,
                                      decoration: InputDecoration(
                                        fillColor: Colors.black,
                                        labelText: 'Full Name',
                                        hintText: 'Enter your full name',
                                        // helperText: 'At least two names eg. John Doe',
                                        prefixIcon: const Icon(Icons.person),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty)
                                          return 'Please enter your full name';
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: _email,
                                      decoration: InputDecoration(
                                        fillColor: Colors.black,
                                        labelText: 'Email',
                                        hintText: 'Enter your email',
                                        prefixIcon: const Icon(Icons.email_outlined),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty)
                                          return 'Please enter your email';
                                        return null;
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
                                    CheckboxListTile(
                                      title: Text(
                                          'Agree to terms and conditions',
                                          style: TextStyle(
                                            color: Colors.grey,
                                          )
                                      ),
                                      value: _checked,
                                      controlAffinity: ListTileControlAffinity.leading,
                                      onChanged: (bool? val) {
                                        setState(() {
                                          _checked = val!;
                                        });
                                      },
                                      contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 16.0),
                                        child: InkWell(
                                          child: Text(
                                            'Privacy Policy',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey,
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Register())),
                                        ),
                                      ),
                                    ),
                                    _isLoading ? Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CircularProgressIndicator(),
                                            SizedBox(width: 20,),
                                            Text("Authenticating...")
                                          ],
                                        )
                                    ) :
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            _isLoading = true;
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('Processing Data'))
                                            );
                                          });
                                          // try {
                                          //   final result = await _authFirebase
                                          //       .createUserWithEmailAndPassword(
                                          //       email: _email.text,
                                          //       password: _password.text
                                          //   );
                                          //   User newUser = result.user;
                                          //   await FirebaseFirestore.instance.collection('client')
                                          //       .doc(newUser.uid)
                                          //       .set({
                                          //     'username': _username.text,
                                          //     'email': _email.text,
                                          //     'name': _name.text,
                                          //     'newUser': true,
                                          //     'subscriptionPlan': 'free',
                                          //   });
                                          //   Navigator.of(context)
                                          //       .pushReplacement(
                                          //       MaterialPageRoute(
                                          //           builder: (
                                          //               context) =>
                                          //               Login()));
                                          // } on FirebaseAuthException catch (e) {
                                          //   print(e.code + ": " + e.message);
                                          // } catch (e) {
                                          //   print(e);
                                          // }
                                          bool isSuccess = await DatabaseService()
                                              .registerClient(
                                              _name.text,
                                              _email.text,
                                              _username.text,
                                              _password.text
                                          );
                                          if (isSuccess)
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (
                                                          context) =>
                                                          Login()));
                                          setState(() => _isLoading = false);
                                        }
                                      },
                                      child: Text(
                                          'REGISTER',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          )
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: Size(155.35, 46.87)
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: InkWell(
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xFF62D1EA),
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                          onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login())),
                                        ),
                                      ),
                                    )
                                  ]
                                )
                              )
                            ),
                          ],
                        )
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
