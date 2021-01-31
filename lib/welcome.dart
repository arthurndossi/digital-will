import 'package:dibu/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

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
            margin: EdgeInsets.fromLTRB(20.0, 120.0, 20.0, 60.0),
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
                          padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 16.0),
                          child: Text(
                            'Welcome to DIBU',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 30,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ]
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                              },
                              child: Text(
                                  'Login as Client',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  )
                              ),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(189.00, 46.87)
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 32.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                                },
                                child: Text(
                                    'Login as Beneficiary',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    )
                                ),
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(189.00, 46.87)
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
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
