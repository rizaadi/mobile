import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fpmobilelaptop/agent_page.dart';
import 'package:fpmobilelaptop/login/login_page.dart';
import 'package:fpmobilelaptop/splashscreen_page%20.dart';
import 'package:valpi/valpi.dart';
import 'package:http/http.dart' as http;

//menerima notif ketika app dibackground
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  Valpi instance = Valpi("RGAPI-2bc595fc-fdfd-4ac6-8223-2578044f893a", "ap",);
  print("Server ID: " + await instance.getServerId());
   http.Response valContent = await instance
        .valContent(); //returns all of the data than can be aquired from /val/status/v1/contents in the form of a http response.
    print("Response from /val/content/v1/platform-data: " + valContent.body);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Valorant App",
      home: splashscreen_page(),
      routes: {
        "agent": (_) => AgentPage(),
      },
    );
  }
}
