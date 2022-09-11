import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/pages/accueil.dart';
import 'package:koumishop/pages/accueil_controller.dart';
import 'package:koumishop/pages/menu/details_controller.dart';
import 'package:koumishop/pages/menu/menu_controller.dart';
import 'package:koumishop/pages/panier/panier_controller.dart';
import 'package:koumishop/pages/profil/profil.dart';
import 'package:koumishop/pages/profil/profil_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'favorits/favorit_controller.dart';
import 'profil/autres/autre_controller.dart';
import 'profil/notifications/notification_controller.dart';

class SplashtScreen extends StatelessWidget {
  SplashtScreen() {
    Timer(const Duration(seconds: 3), () {
      //
      //
      AccueilController accueilController = Get.put(AccueilController());
      FavoritController favoritController = Get.put(FavoritController());
      PanierController panierController = Get.put(PanierController());
      ProfilController profilController = Get.put(ProfilController());
      DetailsController detailsController = Get.put(DetailsController());
      MenuController menuController = Get.put(MenuController());
      NotificationController notificationController =
          Get.put(NotificationController());
      AutreController autreController = Get.put(AutreController());
      //
      var box = GetStorage();
      profilController.infos.value = box.read("profile") ?? RxMap();
      print("---------------------------- ${profilController.infos}");
      //
      Get.off(Profil());
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
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
