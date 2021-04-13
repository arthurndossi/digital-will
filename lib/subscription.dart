import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class Subscription extends StatefulWidget {
  final String uid;

  const Subscription({required this.uid});

  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> with TickerProviderStateMixin {
  int _selected = 1;
  bool _checkout = false;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      crossFadeState: _checkout ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 300),
      firstChild: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "Enter your payment details",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                cardBgColor: Color(0xFF00d4ff),
                //true when you want to show cvv(back) view
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        themeColor: Color(0xFF62D1EA),
                        cardNumberDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                        ),
                        expiryDateDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Expired Date',
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Card Holder',
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          elevation: 0.0,
                          padding: EdgeInsets.all(0.0),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  Color(0xFF62D1EA),
                                  Color(0xFF00d4ff)
                                ]
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Container(
                            constraints: BoxConstraints(maxWidth: 200.0, minHeight: 40.0),
                            alignment: Alignment.center,
                            child: Text("Validate",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight:FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            print('valid!');
                          } else {
                            print('invalid!');
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      secondChild: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "Choose your plan",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Stack(
                          children: [
                            Visibility(
                              visible: _selected == 1,
                              child: ClipPath(
                                clipper: ClipperStack(),
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  color: Color(0xFF62D1EA),
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 4.0, 4.0, 0.0),
                                        child: Icon(Icons.check, color: Colors.white),
                                      )
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selected = 1;
                                });
                              },
                              child: Container(
                                height: 150.0,
                                width: 150.0,
                                color: Colors.transparent,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFF62D1EA),
                                            width: 2.0
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Free",
                                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                              "7 days",
                                              textAlign: TextAlign.center
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Visibility(
                              visible: _selected == 2,
                              child: ClipPath(
                                clipper: ClipperStack(),
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  color: Color(0xFF62D1EA),
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 4.0, 4.0, 0.0),
                                        child: Icon(Icons.check, color: Colors.white),
                                      )
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selected = 2;
                                });
                              },
                              child: Container(
                                height: 150.0,
                                width: 150.0,
                                color: Colors.transparent,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFF62D1EA),
                                            width: 2.0
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "\$8",
                                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                              "30 days",
                                              textAlign: TextAlign.center
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Stack(
                          children: [
                            Visibility(
                              visible: _selected == 3,
                              child: ClipPath(
                                clipper: ClipperStack(),
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  color: Color(0xFF62D1EA),
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 4.0, 4.0, 0.0),
                                        child: Icon(Icons.check, color: Colors.white),
                                      )
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selected = 3;
                                });
                              },
                              child: Container(
                                height: 150.0,
                                width: 150.0,
                                color: Colors.transparent,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFF62D1EA),
                                            width: 2.0
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "\$14",
                                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                              "60 days",
                                              textAlign: TextAlign.center
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Visibility(
                              visible: _selected == 4,
                              child: ClipPath(
                                clipper: ClipperStack(),
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  color: Color(0xFF62D1EA),
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 4.0, 4.0, 0.0),
                                        child: Icon(Icons.check, color: Colors.white),
                                      )
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selected = 4;
                                });
                              },
                              child: Container(
                                height: 150.0,
                                width: 150.0,
                                color: Colors.transparent,
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFF62D1EA),
                                            width: 2.0
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "\$199",
                                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                              "One time",
                                              textAlign: TextAlign.center
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: 200.0,
                      child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              _checkout = true;
                            });
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)
                          ),
                          elevation: 0.0,
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    Color(0xFF62D1EA),
                                    Color(0xFF00d4ff)
                                  ]
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Container(
                              constraints: BoxConstraints(maxWidth: 200.0, minHeight: 40.0),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: SvgPicture.asset(
                                      "assets/images/svg/credit-card.svg",
                                      color: Colors.white,
                                      width: 32.0,
                                      height: 32.0,
                                    ),
                                  ),
                                  Text("Credit card",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight:FontWeight.bold
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 12.0
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: 200.0,
                      child: RaisedButton(
                          onPressed: () {
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)
                          ),
                          elevation: 0.0,
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    Color(0xFF62D1EA),
                                    Color(0xFF00d4ff)
                                  ]
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Container(
                              constraints: BoxConstraints(maxWidth: 200.0, minHeight: 40.0),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: SvgPicture.asset(
                                      "assets/images/svg/PayPal.svg",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 12.0
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                      ),
                    )
                  ],
                ),
              )
            ]
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}

class ClipperStack extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width - 50, 0.0);
    path.lineTo(size.width, 50.0);
    path.lineTo(size.width, 20.0);
    path.arcToPoint(Offset(size.width - 20, 0.0), radius: Radius.circular(20.0), clockwise: false);
    path.lineTo(size.width - 20, 0.0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}