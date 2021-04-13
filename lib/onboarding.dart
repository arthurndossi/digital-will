import 'package:dibu/intro_widget.dart';
import 'package:flutter/material.dart';

import 'models/intro.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// _setPreferences() async {
//   SharedPreferences preferences = await SharedPreferences.getInstance();
//   // bool counter = preferences.getBool('new_user');
//   await preferences.setBool('new_user', false);
// }

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {

  PageController _pageController = PageController();

  int currentPageValue = 0;

  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Intro> introList = [
      Intro('Discover Digital Will', 'assets/images/svg/onboarding1.svg', 'Discover how you can setup your digital inheritance plan', 'Continue'),
      Intro('Create an Inventory', 'assets/images/svg/onboarding2.svg', 'List all your digital assets and decide who will get access to your assets', 'Continue'),
      Intro('Keep your Digital Will safe', 'assets/images/svg/onboarding3.svg', 'Your data will be safe with us until it will be passed on', 'Finish'),
    ];

    return Scaffold(
      body: Stack(
          children: <Widget>[
            PageView(
              controller: _pageController,
              onPageChanged: onChangedFunction,
              children: <Widget>[
                for (var intro in introList)
                  IntroWidget(intro)
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 120.0, horizontal: 20.0),
            //   child: Align(
            //     alignment: Alignment.bottomCenter,
            //     child: Container(
            //         child: Row(
            //           mainAxisSize: MainAxisSize.max,
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: <Widget>[
            //             // if (currentPageValue != 0)
            //               InkWell(
            //                 onTap: () => previousFunction(),
            //                 child: Text(
            //                     "Previous",
            //                     style: TextStyle(
            //                       color: Color(0xFF62D1EA),
            //                       fontSize: 24,
            //                       fontWeight: FontWeight.bold,
            //                     )
            //                 ),
            //               ),
            //             SizedBox(width: 50,),
            //             InkWell(
            //               onTap: () => nextFunction(),
            //               child: Text(
            //                   "Next",
            //                   style: TextStyle(
            //                     color: Color(0xFF62D1EA),
            //                     fontSize: 24,
            //                     fontWeight: FontWeight.bold,
            //                   )
            //               ),
            //             )
            //           ],
            //         ),
            //       )
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(bottom: 60.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Indicator(
                        positionIndex: 0,
                        currentIndex: currentPageValue,
                      ),
                      SizedBox(width: 10,),
                      Indicator(
                        positionIndex: 1,
                        currentIndex: currentPageValue,
                      ),
                      SizedBox(width: 10,),
                      Indicator(
                        positionIndex: 2,
                        currentIndex: currentPageValue,
                      ),
                    ],
                  )
              )
            )
          ]
        ),
    );
  }

  onChangedFunction(int value) {
    setState(() {
      currentPageValue = value;
    });
  }

  previousFunction() {
    _pageController.previousPage(duration: _kDuration, curve: _kCurve);
  }

  nextFunction() {
    _pageController.nextPage(duration: _kDuration, curve: _kCurve);
  }
}

class Indicator extends StatelessWidget {

  final int positionIndex, currentIndex;

  const Indicator({required this.currentIndex, required this.positionIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF62D1EA)),
        color: positionIndex == currentIndex ? Color(0xFF62D1EA) : Colors.transparent,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
