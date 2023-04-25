import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/screens/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'utils/notification_service.dart';

BuildContext? contextApp;
State? stateMenu;
State? statePanier;
BuildContext? c;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Firebase.initializeApp();

  registerNotification();
  //
  runApp(const Koumishop());
}

NotificationService ns = NotificationService();
//
registerNewToken(String token) async {
  //
  var box = GetStorage();
  Map x = box.read("profile") ?? {};
  //
  var headers = {
    'Authorization':
        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
  };
  var request = http.MultipartRequest('POST',
      Uri.parse('https://webadmin.koumishop.com/api-firebase/login.php'));
  request.fields.addAll({
    'accesskey': '90336',
    "type": "register-device",
    'user_id': x['user_id'] ?? "",
    'token': token,
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    if (kDebugMode) {
      print("Rep: ok! ${await response.stream.bytesToString()}");
    }
  } else {
    if (kDebugMode) {
      print("Rep: erreur! ${response.reasonPhrase}");
    }
  }
}

void registerNotification() async {
  // 1. Initialize the Firebase app
  await Firebase.initializeApp();
  // 2. Instantiate Firebase Messaging
  var messaging = FirebaseMessaging.instance;

  // 3. On iOS, this helps to take the user permissions
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    var fcmToken = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Map m = {"title": "Jojo", "message": "Comment ?"};
      try {
        m = jsonDecode(message.data['data'] ?? '');
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
      ns.setup(
          id: 1,
          title: "${m['title']}",
          body: "${m['message'] ?? 'Echec'}",
          payload: "");
    });
  } else {
    if (kDebugMode) {
      print(' Message ré User declined or has not accepted permission');
    }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  Map m = jsonDecode(message.data['data']);
  ns.setup(id: 1, title: "${m['title']}", body: "${m['message']}", payload: "");
}

class Koumishop extends StatelessWidget {
  const Koumishop({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    contextApp = context;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: 'KoumiShop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
              colorScheme: const ColorScheme.light(),
              textTheme: const TextTheme())
          .copyWith(
        bottomSheetTheme: const BottomSheetThemeData(
          modalBackgroundColor: Colors.transparent,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ),
        primaryColor: Colors.red,
        appBarTheme: const AppBarTheme(
          color: Colors.red,
          elevation: 0,
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: Colors.yellow.shade700,
          linearMinHeight: 1.5,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue,
          ),
        ),
        cardTheme: CardTheme(
            color: Colors.white,
            elevation: 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.red,
            backgroundColor: Colors.white,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.purple,
            backgroundColor: Colors.green,
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
