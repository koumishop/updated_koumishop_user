import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/pages/accueil.dart';
import 'package:koumishop/pages/accueil_controller.dart';
import 'package:koumishop/pages/menu/details_controller.dart';
import 'package:koumishop/pages/menu/menu_controller.dart';
import 'package:koumishop/pages/menu/recherche_controller.dart';
import 'package:koumishop/pages/menu/sous_categorie_controller.dart';
import 'package:koumishop/pages/panier/creno_controller.dart';
import 'package:koumishop/pages/panier/paiement_mobile_controller.dart';
import 'package:koumishop/pages/panier/panier_controller.dart';
import 'package:koumishop/pages/profil/commande/commande.dart';
import 'package:koumishop/pages/profil/log/inscription.dart';
import 'package:koumishop/pages/profil/log/mdp_oublie.dart';
import 'package:koumishop/pages/profil/log/miseajour.dart';
import 'package:koumishop/pages/profil/log/log.dart';
import 'package:koumishop/pages/profil/mode_paiement/mode_paiement.dart';
import 'package:koumishop/pages/profil/profil.dart';
import 'package:koumishop/pages/profil/profil_controller.dart';
import 'package:koumishop/utils/notification_service.dart';
import 'package:shimmer/shimmer.dart';
import 'favorits/favorit_controller.dart';
import 'panier/paiement_mobile.dart';
import 'profil/commande/details_commande_controller.dart';
import 'profil/autres/autre_controller.dart';
import 'profil/commande/commande_controller.dart';
import 'profil/notifications/notification_controller.dart';

class SplashtScreen extends StatelessWidget {
  SplashtScreen() {
    //
    registerNotification();
    //
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
      CommandeController commandeController = Get.put(CommandeController());
      //
      RechercheController rechercheController = Get.put(RechercheController());
      //
      SousCategorieController sousCategorieController =
          Get.put(SousCategorieController());
      //
      CrenoHoraireController crenoHoraireController =
          Get.put(CrenoHoraireController());
      //
      DetailsCommandeController detailsCommandeController =
          Get.put(DetailsCommandeController());
      //
      PaiementMobileController paiementMobileController =
          Get.put(PaiementMobileController());
      //
      var box = GetStorage();
      profilController.infos.value = box.read("profile") ?? RxMap();
      print("---------------------------- ${profilController.infos}");
      //
      //Get.off(PaiementMobile("", {})); //PaiementMobile
      Get.off(Accueil(true)); //PaiementMobile
      //
      //Get.off(Inscription("815381693", "+243"));
      //
    });
  }
  //
  NotificationService ns = NotificationService();
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
      //
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        //message
        Map m = jsonDecode(message.data['data']);
        print("Message réçu: ${message}");
        print("Message réçu: ${message.category}");
        print("Message réçu: ${message.messageId}");
        print("Message title: ${m['title']}");
        print("Message message: ${m['message']}");
        print("Message réçu: ${message.from}");
        //
        ns.setup(
            id: 1,
            title: "${m['title']}",
            body: "${m['message']}",
            payload: "");
        //("${m['title']}", "${m['message']}");
        print("Message réçu: ${message.notification!.body}");
      });
      //
    } else {
      print('User declined or has not accepted permission');
    }
  }

  //
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
