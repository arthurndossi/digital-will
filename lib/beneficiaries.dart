import 'package:dibu/models/beneficiary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'beneficiary_profile.dart';
import 'models/app.dart';

class Beneficiaries extends StatefulWidget {
  final page;
  final beneficiary;

  const Beneficiaries({this.page, this.beneficiary});

  @override
  _BeneficiariesState createState() => _BeneficiariesState();
}

class _BeneficiariesState extends State<Beneficiaries> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Beneficiary>>(
      future: Future(() => [
        Beneficiary('Kareem Masoud', 'kareem.masoud@gmail.com', 'https://via.placeholder.com/50', [App('TikTok', null, 'Social'), App('Instagram', null, 'Social'), App('Snapchat', null, 'Social'),]),
        Beneficiary('Esther Kimenya', 'esther.kimenya@gmail.com', 'https://via.placeholder.com/50', []),
        Beneficiary('Maureen Shayo', 'maureen.shayo@gmail.com', 'https://via.placeholder.com/50', []),
        Beneficiary('Pascal Mtweve', 'pascal.mtweve@gmail.com', 'https://via.placeholder.com/50', []),
        Beneficiary('Lilian Mushi', 'lilian.mushi@gmail.com', 'https://via.placeholder.com/50', []),
        Beneficiary('Eric Swai', 'eric.swai@gmail.com', 'https://via.placeholder.com/50', []),
      ]),
      builder: (context, data) {
        if (data.data == null) {
          return const Center(child: CircularProgressIndicator(),);
        } else {
          List<Beneficiary> beneficiaries = data.data;
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
                  child: Scrollbar(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, position) {
                        Beneficiary beneficiary = beneficiaries[position];
                        return Column(
                          children: <Widget>[
                            Card(
                              elevation: 8.0,
                              child: ListTile(
                                leading: beneficiary.dp.isNotEmpty ? CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(beneficiary.dp),
                                ): null,
                                onTap: () => {
                                  // widget.page('BeneficiaryPage');
                                  // widget.beneficiary('BeneficiaryPage', beneficiary)
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return BeneficiaryProfile(beneficiary: beneficiary,);
                                  }))
                                },
                                onLongPress: () {
                                  // widget.setBar('SelectBar');
                                },
                                title: Text('${beneficiary.fullName}'),
                                subtitle: Text('${beneficiary.email}', style: TextStyle(fontSize: 12),),
                                trailing: Container(
                                  width: 110,
                                  height: 50,
                                  child: Stack(
                                    alignment: AlignmentDirectional.centerEnd,
                                    children: beneficiary.apps.asMap().map((i, app) =>
                                      MapEntry(i,
                                        Positioned(
                                          left: i == 0 ? 0 : 30.0 * i,
                                          child: Icon(Icons.monetization_on, size: 50.0, color: const Color.fromRGBO(218, 165, 32, 1.0)),
                                        ),
                                      )
                                    ).values.toList()

                                    //     Align(
                                    //       alignment: Alignment.centerLeft,
                                    //       child: CircleAvatar(
                                    //         backgroundColor: Colors.white,
                                    //         child: CircleAvatar(
                                    //           radius: 18,
                                    //           backgroundColor: Colors.red,
                                    //           child: Image.asset('assets\image'), // Provide your custom image
                                    //         ),
                                    //       ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: beneficiaries.length,
                    )
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
