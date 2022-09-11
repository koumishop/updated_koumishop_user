import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/pages/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  //

  //
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'KoumiShop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
              colorScheme: const ColorScheme.light(), textTheme: TextTheme())
          .copyWith(
        // floatingActionButtonTheme: FloatingActionButtonThemeData(
        //     backgroundColor: Colors.yellow,
        //     sizeConstraints: BoxConstraints.loose(Size(40, 40))),
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
