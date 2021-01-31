import 'package:flutter/material.dart';

import 'app_account.dart';
import 'models/account.dart';
import 'models/app.dart';
import 'models/beneficiary.dart';

class BeneficiaryProfile extends StatefulWidget {
  final Beneficiary beneficiary;
  final page;

  // BeneficiaryProfile({Key key, @required this.beneficiary, this.page}) : super(key: key);
  const BeneficiaryProfile({this.beneficiary, this.page});

  @override
  _BeneficiaryProfileState createState() => _BeneficiaryProfileState();
}

class _BeneficiaryProfileState extends State<BeneficiaryProfile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Account>>(
        future: Future(() => [
          Account(
            app: App('Facebook', CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.transparent,
              child: Image.asset('assets/images/png/fb-icon.png', width: 50.0, height: 50.0,),
            ), 'Social'),
            beneficiary: widget.beneficiary.fullName,
            owner: 'Arthur David',
            accessRight: 'Full Access',
            status: '',
            description: '',
          ),
          Account(
            app: App('Instagram', CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.transparent,
              child: Image.asset('assets/images/png/instagram-icon.png', width: 50.0, height: 50.0,),
            ), 'Social'),
            beneficiary: widget.beneficiary.fullName,
            owner: 'Arthur David',
            accessRight: 'Full Access',
            status: '',
            description: '',
          ),
          Account(
            app: App('TikTok', CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.transparent,
              child: Image.asset('assets/images/png/tiktok-icon.png', width: 50.0, height: 50.0,),
            ), 'Social'),
            beneficiary: widget.beneficiary.fullName,
            owner: 'Arthur David',
            accessRight: 'Full Access',
            status: '',
            description: '',
          ),
          Account(
            app: App('Snapchat', CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.transparent,
              child: Image.asset('assets/images/png/snapchat-icon.png', width: 50.0, height: 50.0,),
            ), 'Social'),
            beneficiary: widget.beneficiary.fullName,
            owner: 'Arthur David',
            accessRight: 'Full Access',
            status: '',
            description: '',
          ),
          Account(
            app: App('Tinder', CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.transparent,
              child: Image.asset('assets/images/png/tinder-icon.png', width: 50.0, height: 50.0,),
            ), 'Social'),
            beneficiary: widget.beneficiary.fullName,
            owner: 'Arthur David',
            accessRight: 'Full Access',
            status: '',
            description: '',
          ),
          Account(
            app: App('Twitter', CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.transparent,
              child: Image.asset('assets/images/png/twitter-icon.png', width: 50.0, height: 50.0,),
            ), 'Social'),
            beneficiary: widget.beneficiary.fullName,
            owner: 'Arthur David',
            accessRight: 'Full Access',
            status: '',
            description: '',
          ),
          Account(
            app: App('Linked In', CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.transparent,
              child: Image.asset('assets/images/png/linked_in-icon.png', width: 50.0, height: 50.0,),
            ), 'Social'),
            beneficiary: widget.beneficiary.fullName,
            owner: 'Arthur David',
            accessRight: 'Full Access',
            status: '',
            description: '',
          ),
        ]),
        builder: (context, data) {
          if (data.data == null) {
            return const Center(child: CircularProgressIndicator(),);
          } else {
            List<Account> accounts = data.data;
            return Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: widget.beneficiary.dp.isNotEmpty ? CircleAvatar(
                          radius: 60.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(widget.beneficiary.dp),
                        ): null,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.beneficiary.fullName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.beneficiary.email,)
                    ],
                  ),
                  widget.beneficiary.phoneNumber == null ? Container() :
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.beneficiary.phoneNumber,)
                      ],
                    ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 0, 8.0),
                        child: Text(
                          'ACCOUNTS(${widget.beneficiary.apps.length})',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: Scrollbar(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, position) {
                            Account account = accounts[position];
                            return Card(
                              elevation: 8.0,
                              child: ListTile(
                                leading: account.app.icon != null
                                    ? account.app.icon
                                    : null,
                                // onTap: () => widget.page('AccountPage'),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return AppAccount(account: account);
                                  }));
                                },
                                onLongPress: () {
                                  // widget.setBar('SelectBar');
                                },
                                title: Text('${account.app.name}'),
                                subtitle: Text(
                                  '${account.owner}', style: TextStyle(fontSize: 12),),
                                trailing: IconButton(
                                  icon: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Color(0xFF62D1EA)
                                  ),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return AppAccount(account: account);
                                    }));
                                  },
                                ),
                              ),
                            );
                          },
                          itemCount: accounts.length,
                        ),
                      ),
                    ),
                  ]
              )
            );
          }
        },
    );
  }
}
