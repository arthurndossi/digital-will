import 'package:dibu/commons.dart';
import 'package:dibu/home.dart';
import 'package:dibu/login.dart';
import 'package:dibu/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'digital_will_channel',
    'Digital Will Notifications',
    'Channel for Digital Will Notifications',
    importance: Importance.high
);

final FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Will',
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color(0xFF62D1EA)),
      ),
      home: FutureBuilder(
          future: Future.wait([
            Commons().checkLoginStatus(),
            Commons().getUid(),
          ]),
          builder: (context, snapshot) {
            double height = MediaQuery.of(context).size.height;
            double width = MediaQuery.of(context).size.width;
            if (snapshot.connectionState == ConnectionState.active
                || snapshot.connectionState == ConnectionState.waiting)
              return Scaffold(
                body: Container(
                  height: height,
                  width: width,
                  child: Center(child: CircularProgressIndicator())
                ),
              );
            else if (snapshot.connectionState == ConnectionState.done &&
                (snapshot.hasError || !snapshot.hasData))
              return Scaffold(
                body: Container(
                  height: height,
                  width: width,
                  child: Center(child: Text(snapshot.error as String))
                ),
              );
            else if (snapshot.hasData) {
              List<String> list = snapshot.data as List<String>;
              if (list[0] == "logged_out")
                return Login();
              else if (list[0] == "logged_in")
                return Home(uid: list[1]);
              else
                return Onboarding();
            } else {
                return Onboarding();
            }
          }
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1
      );
    });
    return MaterialColor(color.value, swatch);
  }
}