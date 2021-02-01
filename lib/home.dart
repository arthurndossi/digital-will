import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_account.dart';
import 'add_beneficiary.dart';
import 'beneficiaries.dart';
import 'constants.dart';
import 'home_page.dart';
import 'widget/circular_button.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  GlobalKey<NavigatorState> _key = GlobalKey();

  String _currentPage;

  DateTime _lastQuitTime;

  AnimationController animationController;
  Animation degOneTransAnim, degTwoTransAnim;
  Animation fabAnimation, rotationAnimation;

  AppBar _defaultBar;
  AppBar _selectBar;
  AppBar _appBar;

  // Beneficiary _beneficiary;

  _setBar(currentBar) {
    setState(() {
      if (currentBar == 'AppBar')
        _appBar = _defaultBar;
      else
        _appBar = _selectBar;
    });
  }

  _setPage(page) {
    setState(() {
      _currentPage = page;
    });
  }

  // _setBeneficiary(String page, Beneficiary beneficiary) {
  //   setState(() {
  //     _currentPage = page;
  //     _beneficiary = beneficiary;
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    _currentPage = 'HomePage';
    _defaultBar = AppBar(
      title: Text(
        'DIBU',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.people_alt_rounded, color: Colors.white,),
          onPressed: () {
            setState(() {
              _currentPage = 'BeneficiariesPage';
            });
          },
        ),
        PopupMenuButton(
          icon: Icon(Icons.more_vert, color: Colors.white,),
          onSelected: (_) {},
          itemBuilder: (context) {
            return Constants.choices.map((String choice) {
              return PopupMenuItem(child: Text(choice), value: choice,);
            }).toList();
          }
        )
      ],
      backgroundColor: Color(0xFF62D1EA),
      automaticallyImplyLeading: false,
    );
    _selectBar = AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white,),
        onPressed: () {
          _setBar('AppBar');
        },
      ),
      title: Text(
        '1',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.delete, color: Colors.white,),
          onPressed: () {

          },
        ),
        PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Colors.white,),
            onSelected: (_) {},
            itemBuilder: (context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem(child: Text(choice), value: choice,);
              }).toList();
            }
        )
      ],
      backgroundColor: Color(0xFF3B7D8C),
    );
    _appBar = _defaultBar;
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTransAnim = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0)
    ]).animate(animationController);
    degTwoTransAnim = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 1.4), weight: 35.0),
      TweenSequenceItem(tween: Tween<double>(begin: 1.4, end: 1.0), weight: 65.0)
    ]).animate(animationController);
    // degOneTransAnim = Tween(begin: 0.0, end: 1.0).animate(animationController);
    fabAnimation = Tween(begin: 180.0, end: 45.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut)
    );
    rotationAnimation = Tween(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut)
    );

    super.initState();

    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        if (_key.currentState.canPop()) {
          _key.currentState.pop();
          return false;
        } else {
          if (_lastQuitTime == null || DateTime.now().difference(_lastQuitTime).inSeconds > 1) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Press again back button to exit')));
            _lastQuitTime = DateTime.now();
            return false;
          } else {
            Navigator.of(context, rootNavigator: true).pop(true);
            return true;
          }
        }
      },
      child: Scaffold(
        appBar: _appBar,
        body: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: <Widget>[
              Column(
                children: [
                  Expanded(
                      child: Navigator(
                        key: _key,
                        onGenerateRoute: (RouteSettings settings) =>
                            MaterialPageRoute(builder: (context) {
                              if (_currentPage == 'HomePage')
                                return HomePage(
                                  setBar: _setBar,
                                  appBar: _appBar == _defaultBar ? 'AppBar' : 'SelectBar'
                                );
                              else if (_currentPage == 'AddAccountPage')
                                return AddAccount(page: _setPage);
                              else if (_currentPage == 'AddBeneficiaryPage')
                                return AddBeneficiary(page: _setPage);
                              else if (_currentPage == 'BeneficiariesPage')
                                return Beneficiaries(page: _setPage,);
                              // else if (_currentPage == 'BeneficiaryPage')
                              //   return BeneficiaryProfile(
                              //     beneficiary: _beneficiary,
                              //   );
                              else
                                return HomePage(
                                    setBar: _setBar,
                                    appBar: _appBar == _defaultBar ? 'AppBar' : 'SelectBar'
                                );
                            }),
                    )
                  ),
                ],
              ),
              Positioned(
                right: 20,
                bottom: 30,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    IgnorePointer(
                      child: Container(
                        color: Colors.transparent,
                        height: 150.0,
                        width: 150.0,
                      ),
                    ),
                    Transform.translate(
                      offset: Offset.fromDirection(getRadiansFromDegree(180), degOneTransAnim.value * 100),
                      child: Transform(
                        transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(degOneTransAnim.value),
                        alignment: Alignment.center,
                        child: CircularButton(
                            color: Color(0xFF62D1EA),
                            width: 50,
                            height: 50,
                            icon: Icon(Icons.account_circle, color: Colors.white,),
                            onClick: () => {
                              setState(() {
                                _currentPage = 'AddAccountPage';
                              }),
                              toggleFab()
                            }
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset.fromDirection(getRadiansFromDegree(225), degTwoTransAnim.value * 100),
                      child: Transform(
                        transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(degTwoTransAnim.value),
                        alignment: Alignment.center,
                        child: CircularButton(
                            color: Color(0xFF62D1EA),
                            width: 50,
                            height: 50,
                            icon: Icon(Icons.person_add, color: Colors.white,),
                            onClick: () => {
                              setState(() {
                                _currentPage = 'AddBeneficiaryPage';
                              }),
                              toggleFab()
                            }
                        ),
                      ),
                    ),
                    Transform(
                      transform: Matrix4.rotationZ(getRadiansFromDegree(fabAnimation.value)),
                      alignment: Alignment.center,
                      child: CircularButton(
                        color: Color(0xFF62D1EA),
                        width: 60,
                        height: 60,
                        icon: Icon(Icons.add, color: Colors.white,),
                        onClick: () => {
                          toggleFab()
                        }
                      ),
                    )
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree/unitRadian;
  }

  toggleFab() {
    if (animationController.isCompleted) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }
}