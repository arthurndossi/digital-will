import 'package:flutter/material.dart';

import 'models/app.dart';

class AppAccount extends StatefulWidget {
  final App app;

  const AppAccount({required this.app});

  @override
  _AppAccountState createState() => _AppAccountState();
}

class _AppAccountState extends State<AppAccount> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: new SingleChildScrollView(
            child: new Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: widget.app.icon != null ? CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.transparent,
                          child: Image.asset(widget.app.icon!, width: 60.0, height: 60.0,),
                        ): null,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.app.name!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Beneficiary: ', style: TextStyle(fontSize: 16),),
                      Text(widget.app.beneficiary!['name']!, style: TextStyle(fontSize: 16),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Status: ', style: TextStyle(fontSize: 16),),
                      Text(widget.app.status!, style: TextStyle(fontSize: 16),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Description: ', style: TextStyle(fontSize: 16),),
                      Text(widget.app.description!, style: TextStyle(fontSize: 16),)
                    ],
                  ),
                ]
            )
        )
    );
  }
}
