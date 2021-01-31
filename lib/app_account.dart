import 'package:flutter/material.dart';

import 'models/account.dart';

class AppAccount extends StatefulWidget {
  final Account account;

  const AppAccount({this.account});

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
                        child: widget.account.app != null ? CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.transparent,
                          child: Image.asset('assets/images/png/fb-icon.png', width: 60.0, height: 60.0,),
                        ): null,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.account.app.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Beneficiary: ', style: TextStyle(fontSize: 16),),
                      Text(widget.account.beneficiary, style: TextStyle(fontSize: 16),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Status: ', style: TextStyle(fontSize: 16),),
                      Text(widget.account.status, style: TextStyle(fontSize: 16),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Description: ', style: TextStyle(fontSize: 16),),
                      Text(widget.account.description, style: TextStyle(fontSize: 16),)
                    ],
                  ),
                ]
            )
        )
    );
  }
}
