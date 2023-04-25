import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/screens/homepage.dart';
import 'package:koumishop/controllers/profile_controller.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key}) {
    Timer(const Duration(seconds: 3), () {
      ProfilController profilController = Get.put(ProfilController());
      var box = GetStorage();
      profilController.data.value = box.read("profile") ?? RxMap();
      Get.off(Homepage(true)); //PaiementMobile//true
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: 250,
          alignment: Alignment.center,
          child: Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.yellow,
            child: const Text(
              "KOUMISHOP",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
