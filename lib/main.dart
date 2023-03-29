import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/pages/splash.dart';
import 'package:http/http.dart' as http;
import 'utils/notification_service.dart';

BuildContext? contextApp;
State? stateMenu;
State? statePanier;
BuildContext? c;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  //

  //Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
  Firebase.initializeApp();
  //

  //
  registerNotification();
  //
  runApp(Koimishope());
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
    print("Rep: ok! ${await response.stream.bytesToString()}");
  } else {
    print("Rep: erreur! ${response.reasonPhrase}");
  }
}

//
void registerNotification() async {
  // 1. Initialize the Firebase app
  await Firebase.initializeApp();
  // 2. Instantiate Firebase Messaging
  var _messaging = FirebaseMessaging.instance;

  // 3. On iOS, this helps to take the user permissions
  NotificationSettings settings = await _messaging.requestPermission(
    alert: true,
    badge: true,
    provisional: false,
    sound: true,
  );
  //
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
    var fcmToken = await FirebaseMessaging.instance.getToken();
    //
    registerNewToken(fcmToken!);
    //
    print('User tocken $fcmToken');
    /*
    
    */
    //FirebaseMessaging.on
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    //
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //message

      print("Message réçu: ${message.data}");
      //print("Message réçu: ${message.from}");
      print("Message réçu: ${message.from}");
      print("Message réçu: ${message.category}");
      print("Message réçu: ${message.messageType}");
      print("Message réçu: ${message.messageId}");
      print("Message réçu: ${message.senderId}");
      //print("Message réçu: ${message.notification!.title}");
      //print("Message réçu: ${message.notification!.body}");

      Map m = {"title": "Jojo", "message": "Comment ?"};
      try {
        m = jsonDecode(message.data['data'] ?? '');
        print("Message réçu: ${message}");
        print("Message réçu: ${message.category}");
        print("Message réçu: ${message.messageId}");
        print("Message title: ${m['title']}");
        print("Message message: ${m['message']}");
        print("Message réçu: ${message.from}");
      } catch (e) {
        print(e);
      }

      //
      ns.setup(
          id: 1,
          title: "${m['title']}",
          body: "${m['message'] ?? 'Echec'}",
          payload: "");
      //("${m['title']}", "${m['message']}");
      //print("Message réçu: ${message.notification!.body}");
    });
    //
  } else {
    print(' Message ré User declined or has not accepted permission');
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  //
  Map m = jsonDecode(message.data['data']);
  print("Message réçu: ${message}");
  print("Message réçu: ${message.category}");
  print("Message réçu: ${message.messageId}");
  print("Message title: ${m['title']}");
  print("Message message: ${m['message']}");
  print("Message réçu: ${message.from}");
  //
  ns.setup(id: 1, title: "${m['title']}", body: "${m['message']}", payload: "");
  //("${m['title']}", "${m['message']}");
  print("Message réçu: ${message.notification!.body}");

  print("Handling a background message: ${message.messageId}");
}

class Koimishope extends StatelessWidget {
  //
  const Koimishope({Key? key}) : super(key: key);
  //
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
              colorScheme: const ColorScheme.light(), textTheme: TextTheme())
          .copyWith(
        // floatingActionButtonTheme: FloatingActionButtonThemeData(
        //     backgroundColor: Colors.yellow,
        //     sizeConstraints: BoxConstraints.loose(Size(40, 40))),
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
            primary: Colors.blue,
          ),
        ),
        cardTheme: CardTheme(
            color: Colors.white,
            elevation: 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.red,
            primary: Colors.white,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: Colors.purple,
            backgroundColor: Colors.green,
          ),
        ),
      ),
      home: SplashtScreen(),
    );
  }
}
