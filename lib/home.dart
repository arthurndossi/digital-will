import 'package:dibu/client_profile.dart';
import 'package:flutter/services.dart';

import 'add_account.dart';
import 'add_beneficiary.dart';
import 'beneficiaries.dart';
import 'commons.dart';
import 'constants.dart';
import 'home_page.dart';
import 'models/keys.dart';
import 'notifications.dart';
import 'providers/default_bar.dart';
import 'subscription.dart';
import 'widget/circular_button.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final String uid;

  const Home({required this.uid});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  late AnimationController animationController;
  late Animation degOneTransAnim, degTwoTransAnim;
  late Animation fabAnimation, rotationAnimation;

  late DateTime _lastQuitTime;

  @override
  void initState() {
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
    Size size = MediaQuery.of(context).size;

    return ChangeNotifierProvider(
      create: (context) => DefaultBar(),
      child: Consumer<DefaultBar>(
        builder: (context, defaultBar, child) {
          return WillPopScope(
            onWillPop: () async {
              if (NavKey.innerNavKey.currentState!.canPop()) {
                NavKey.innerNavKey.currentState!.maybePop();
                return false;
              } else {
                if (DateTime.now().difference(_lastQuitTime).inSeconds > 1) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Press again back button to exit')));
                  _lastQuitTime = DateTime.now();
                  return false;
                } else {
                  SystemNavigator.pop(animated: true);
                  // Navigator.of(context, rootNavigator: true).maybePop();
                  return true;
                }
              }
            },
            child: Scaffold(
              appBar: defaultBar.getCurrentBar == 'AppBar' ? AppBar(
                title: Text(
                  'Digital Will',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.people_alt_rounded, color: Colors.white,),
                    onPressed: () {
                      NavKey.innerNavKey.currentState!.push(
                          MaterialPageRoute(builder: (context) =>
                              Beneficiaries(uid: widget.uid))
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.notifications, color: Colors.white,),
                    onPressed: () {
                      NavKey.innerNavKey.currentState!.push(
                          MaterialPageRoute(builder: (context) =>
                              Notifications(uid: widget.uid))
                      );
                    },
                  ),
                  PopupMenuButton(
                      icon: Icon(Icons.more_vert, color: Colors.white,),
                      onSelected: (item) {
                        if (item == 'Logout') {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text("Logging out"),
                              content: Text("Are you sure you want to log out?"),
                              actions: [
                                FlatButton(
                                  child: Text("OK"),
                                  onPressed: () { Commons().logout(context); },
                                ),
                                FlatButton(
                                  child: Text("Cancel"),
                                  onPressed: () { Navigator.pop(context); },
                                ),
                              ],
                            )
                          );
                        } else if (item == "My Profile") {
                          NavKey.innerNavKey.currentState!.push(
                              MaterialPageRoute(builder: (context) =>
                                  ClientProfile(uid: widget.uid))
                          );
                        } else if (item == "Subscription") {
                          NavKey.innerNavKey.currentState!.push(
                              MaterialPageRoute(builder: (context) =>
                                  Subscription(uid: widget.uid))
                          );
                        }
                      },
                      itemBuilder: (context) {
                        return Constants.choices.map((String choice) {
                          return PopupMenuItem(child: Text(choice), value: choice,);
                        }).toList();
                      }
                  )
                ],
                backgroundColor: Color(0xFF62D1EA),
                automaticallyImplyLeading: false,
              ) : AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white,),
                  onPressed: () {
                    defaultBar.setCurrentBar('AppBar');
                    defaultBar.clearSelected();
                  },
                ),
                title: Text(
                  defaultBar.getCounter,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
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
              ),
              body: Container(
                width: size.width,
                height: size.height,
                child: Stack(
                  children: <Widget>[
                    Navigator(
                      key: NavKey.innerNavKey,
                      initialRoute: 'screen/home',
                      onGenerateRoute: (RouteSettings settings) {
                        WidgetBuilder builder;
                        switch (settings.name) {
                          case 'screen/home':
                            builder = (BuildContext _) => HomePage(uid: widget.uid);
                            break;
                          case 'screen/add/account':
                            builder = (BuildContext _) =>
                                AddAccount(
                                    isInstalled: false, uid: widget.uid
                                );
                            break;
                          case 'screen/add/beneficiary':
                            builder = (BuildContext _) => AddBeneficiary(uid: widget.uid);
                            break;
                          case 'screen/beneficiaries':
                            builder = (BuildContext _) => Beneficiaries(uid: widget.uid);
                            break;
                          // case 'screen/account':
                          //   builder = (BuildContext _) => AppAccount();
                          //   break;
                          default:
                            throw Exception('Invalid route: ${settings.name}');
                        }
                        return MaterialPageRoute(builder: builder, settings: settings);
                      },
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
                                      toggleFab(),
                                      NavKey.innerNavKey.currentState!.push(
                                          MaterialPageRoute(builder: (context) =>
                                              AddAccount(isInstalled: false, uid: widget.uid))
                                      )
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
                                      toggleFab(),
                                      NavKey.innerNavKey.currentState!.push(
                                          MaterialPageRoute(builder: (context) =>
                                              AddBeneficiary(uid: widget.uid))
                                      )
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