import 'package:dibu/models/beneficiary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'beneficiary_profile.dart';
import 'models/app.dart';

class Beneficiaries extends StatefulWidget {
  final String uid;

  const Beneficiaries({required this.uid});

  @override
  _BeneficiariesState createState() => _BeneficiariesState();
}

class _BeneficiariesState extends State<Beneficiaries> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Beneficiary>>(
      future: Future(() => [
        Beneficiary(
          'Kareem Masoud',
          'kareem.masoud@gmail.com',
          'https://via.placeholder.com/50',
          [
            App('TikTok', 'assets/images/png/tiktok-icon.png', 'Social'),
            App('Instagram', 'assets/images/png/instagram-icon.png', 'Social'),
            App('Youtube', 'assets/images/png/youtube-icon.png', 'Social'),
          ]
        ),
        Beneficiary(
          'Esther Kimenya',
          'esther.kimenya@gmail.com',
          'https://via.placeholder.com/50',
          [
            App('Snapchat', 'assets/images/png/snapchat-icon.png', 'Social'),
            App('Twitter', 'assets/images/png/twitter-icon.png', 'Social'),
            App('Facebook', 'assets/images/png/f-icon.png', 'Social'),
          ]
        ),
        Beneficiary(
          'Maureen Shayo',
          'maureen.shayo@gmail.com',
          'https://via.placeholder.com/50',
          [
            App('Linked in', 'assets/images/png/linked_in-icon.png', 'Social'),
            App('Skype', 'assets/images/png/skype-icon.png', 'Social'),
            App('Evernote', 'assets/images/png/evernote-icon.png', 'Social'),
          ]
        ),
        Beneficiary(
          'Pascal Mtweve',
          'pascal.mtweve@gmail.com',
          'https://via.placeholder.com/50',
          [
            App('Gmail', 'assets/images/png/gmail-icon.png', 'Social'),
            App('Yahoo', 'assets/images/png/yahoo-icon.png', 'Social'),
          ]
        ),
        Beneficiary(
          'Lilian Mushi',
          'lilian.mushi@gmail.com',
          'https://via.placeholder.com/50',
          [
            App('Netflix', 'assets/images/png/netflix-icon.png', 'Social'),
            App('Tumbler', 'assets/images/png/tumbler-icon.png', 'Social'),
            App('X-box', 'assets/images/png/xbox-icon.png', 'Social'),
          ]
        ),
        Beneficiary(
          'Eric Swai',
          'eric.swai@gmail.com',
          'https://via.placeholder.com/50',
          [
            App('Discord', 'assets/images/png/discord-icon.png', 'Social'),
            App('Pinterest', 'assets/images/png/pinterest-icon.png', 'Social'),
          ]
        ),
      ]),
      builder: (context, data) {
        if (data.data == null) {
          return const Center(child: CircularProgressIndicator(),);
        } else {
          List<Beneficiary> beneficiaries = data.data!;
          return Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text('BENEFICIARIES', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                    )
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: beneficiaries.length,
                    itemBuilder: (context, position) {
                      Beneficiary beneficiary = beneficiaries[position];
                      return Card(
                        elevation: 8.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: beneficiary.dp!.isNotEmpty ? CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(beneficiary.dp!),
                            ): null,
                            onTap: () => {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return BeneficiaryProfile(beneficiary: beneficiary,);
                              }))
                            },
                            onLongPress: () {
                              // widget.setBar('SelectBar');
                            },
                            title: Text('${beneficiary.name}'),
                            subtitle: Text('${beneficiary.email}', style: TextStyle(fontSize: 10)),
                            trailing: Container(
                              width: 100,
                              height: 50,
                              child: Stack(
                                alignment: AlignmentDirectional.centerEnd,
                                children: beneficiary.apps!.asMap().map((i, app) =>
                                  MapEntry(i,
                                    Positioned(
                                      left: i == 0 ? 0 : 30.0 * i,
                                      // child: Icon(Icons.monetization_on, size: 50.0, color: const Color.fromRGBO(218, 165, 32, 1.0)),
                                      child: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: Colors.transparent,
                                        child: Image.asset(app.icon!), // Provide your custom image
                                      ),
                                    ),
                                  )
                                ).values.toList()
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
