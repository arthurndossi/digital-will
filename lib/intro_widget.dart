import 'package:dibu/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'models/intro.dart';

class IntroWidget extends StatelessWidget {
  Intro _intro;

  IntroWidget(Intro intro) {
    _intro = intro;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            _intro.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 36,
            ),
          ),
          SvgPicture.asset(
            _intro.image,
            color: Color(0xFF62D1EA),
            width: 100,
            height: 100,
          ),
          Text(
            _intro.subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          if (_intro.buttonText == "Finish")
            FlatButton(
              minWidth: 250,
              height: 45,
              color: Color(0xFF62D1EA),
              child: Text(
                _intro.buttonText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Register()))
              },
            )
        ],
      ),
    );
  }
}
