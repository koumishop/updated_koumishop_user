import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koumishop/pages/accueil.dart';
import 'package:koumishop/pages/accueil_controller.dart';
import 'package:koumishop/pages/menu/details_controller.dart';
import 'package:koumishop/pages/menu/menu_controller.dart';
import 'package:koumishop/pages/panier/panier.dart';
import 'package:koumishop/pages/panier/panier_controller.dart';
import 'package:koumishop/pages/profil/adresse/nouvelle_adresse.dart';
import 'package:koumishop/pages/profil/log/log.dart';
import 'package:koumishop/pages/profil/profil.dart';
import 'package:koumishop/pages/profil/profil_controller.dart';
import 'package:shimmer/shimmer.dart';

import 'favorits/favorit_controller.dart';
import 'menu/menu_principale.dart';
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
      //
      //
      Get.off(Accueil());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.red.shade700,
            direction: ShimmerDirection.ttb,
            child: Text(
              "Koumishop",
              style: TextStyle(fontSize: 23),
            )),
      ),
    );
  }
}
