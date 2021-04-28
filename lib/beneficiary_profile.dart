import 'package:flutter/material.dart';

import 'app_account.dart';
import 'models/app.dart';
import 'models/beneficiary.dart';

class BeneficiaryProfile extends StatefulWidget {
  final Beneficiary beneficiary;
  final page;

  const BeneficiaryProfile({required this.beneficiary, this.page});

  @override
  _BeneficiaryProfileState createState() => _BeneficiaryProfileState();
}

class _BeneficiaryProfileState extends State<BeneficiaryProfile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<App>>(
        future: Future(() => [
          App.account(
            name: 'Facebook',
            icon: 'assets/images/png/fb-icon.png',
            category: 'Social',
            accessRight: 'Full Access',
            status: '',
            description: '',
            owner: 'Arthur David',
            beneficiary: {'uid': '', 'name': widget.beneficiary.name!},
          ),
          App.account(
            name: 'Instagram',
            icon: 'assets/images/png/instagram-icon.png',
            category: 'Social',
            accessRight: 'Full Access',
            status: '',
            description: '',
            owner: 'Arthur David',
            beneficiary: {'uid': '', 'name': widget.beneficiary.name!},
          ),
          App.account(
            name: 'TikTok',
            icon: 'assets/images/png/tiktok-icon.png',
            category: 'Social',
            accessRight: 'Full Access',
            status: '',
            description: '',
            owner: 'Arthur David',
            beneficiary: {'uid': '', 'name': widget.beneficiary.name!},
          ),
          App.account(
            name: 'Snapchat',
            icon: 'assets/images/png/snapchat-icon.png',
            category: 'Social',
            accessRight: 'Full Access',
            status: '',
            description: '',
            owner: 'Arthur David',
            beneficiary: {'uid': '', 'name': widget.beneficiary.name!},
          ),
          App.account(
            name: 'Tinder',
            icon: 'assets/images/png/tinder-icon.png',
            category: 'Social',
            accessRight: 'Full Access',
            status: '',
            description: '',
            owner: 'Arthur David',
            beneficiary: {'uid': '', 'name': widget.beneficiary.name!},
          ),
          App.account(
            name: 'Tinder',
            icon: 'assets/images/png/twitter-icon.png',
            category: 'Social',
            accessRight: 'Full Access',
            status: '',
            description: '',
            owner: 'Arthur David',
            beneficiary: {'uid': '', 'name': widget.beneficiary.name!},
          ),
          App.account(
            name: 'Twitter',
            icon: 'assets/images/png/twitter-icon.png',
            category: 'Social',
            accessRight: 'Full Access',
            status: '',
            description: '',
            owner: 'Arthur David',
            beneficiary: {'uid': '', 'name': widget.beneficiary.name!},
          ),
          App.account(
            name: 'Linked In',
            icon: 'assets/images/png/linked_in-icon.png',
            category: 'Social',
            accessRight: 'Full Access',
            status: '',
            description: '',
            owner: 'Arthur David',
            beneficiary: {'uid': '', 'name': widget.beneficiary.name!},
          ),
        ]),
        builder: (context, data) {
          if (data.data == null) {
            return const Center(child: CircularProgressIndicator(),);
          } else {
            List<App> accounts = data.data!;
            return Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: widget.beneficiary.dp!.isNotEmpty ? CircleAvatar(
                          radius: 60.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(widget.beneficiary.dp!),
                        ): null,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.beneficiary.name!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.beneficiary.email!,)
                    ],
                  ),
                  widget.beneficiary.phoneNumber == null ? Container() :
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.beneficiary.phoneNumber!)
                      ],
                    ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 0, 8.0),
                        child: Text(
                          // 'ACCOUNTS(${widget.beneficiary.apps!.length})',
                          'ACCOUNTS(${accounts.length})',
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
                            App account = accounts[position];
                            return Card(
                              elevation: 8.0,
                              child: ListTile(
                                leading: account.icon != null ? CircleAvatar(
                                  radius: 25.0,
                                  backgroundColor: Colors.transparent,
                                  child: Image.asset(account.icon!, width: 50.0, height: 50.0,),
                                ) : null,
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return AppAccount(app: account);
                                  }));
                                },
                                onLongPress: () {
                                  // widget.setBar('SelectBar');
                                },
                                title: Text('${account.name}'),
                                subtitle: Text(
                                  '${account.owner}', style: TextStyle(fontSize: 12),),
                                trailing: IconButton(
                                  icon: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Color(0xFF62D1EA)
                                  ),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return AppAccount(app: account);
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
