import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/main.dart';
import 'package:koumishop/pages/menu/menu_controller.dart';
import 'package:koumishop/pages/panier/panier.dart';
import 'package:koumishop/pages/panier/panier_controller.dart';
import 'package:koumishop/pages/profil/profil_controller.dart';
import 'package:koumishop/widgets/carte_produit.dart';
import 'package:shimmer/shimmer.dart';

import 'details.dart';

class Menu extends StatefulWidget {
  //List listeProduit;
  Menu({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _Menu();
  }
}

class _Menu extends State<Menu> {
  //String subcategory_id;
  PanierController panierController = Get.find();
  ProfilController profilController = Get.find();
  MenuController menuController = Get.find();
  RxString epuise = "Epuisé".obs;

  //
  RxDouble btm = 0.0.obs;

  //
  // Menu(this.listeProduit, {Key? key}) : super(key: key) {
  //   print("Le menu type...");
  //   //Timer(const Duration(seconds: 2), () {
  //   //controller.getMenu(subcategory_id);
  //   //});
  // }
  @override
  Widget build(BuildContext context) {
    //print("je suis dans menu...");
    stateMenu = this;
    //
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [
            //     Color.fromRGBO(255, 137, 147, 1),
            //     Color(0xFFFFFFFF),
            //   ],
            //   begin: FractionalOffset(0.0, 0.0),
            //   end: FractionalOffset(1.0, 1.0),
            //   stops: [0.0, 1.0],
            //   tileMode: TileMode.clamp,
            // ),
            ), // Color.fromARGB(255, 255, 232, 235),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Obx(
                () => GridView.count(
                  controller: ScrollController(),
                  padding: const EdgeInsets.only(
                    left: 1.5,
                    right: 1.5,
                    bottom: 30,
                  ),
                  crossAxisCount: 2,
                  mainAxisSpacing: 0.1,
                  crossAxisSpacing: 0.1,
                  childAspectRatio: 0.55,
                  children: List.generate(menuController.listeProduit.length,
                      (index) {
                    //
                    Map produit = menuController.listeProduit[index];

                    return CarteProduit(produit, index);
                    //Map produit = listeProduit[index];
                  }),
                ),
              ),
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.only(
                  bottom: menuController.showMiniPanier.value
                      ? Get.size.height / 4
                      : 0,
                ),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Obx(
        () => menuController.showMiniPanier.value
            ? BottomSheet(
                onClosing: () {
                  //
                },
                //constraints: BoxConstraints.expand(width: 10, height: 10),
                clipBehavior: Clip.none,
                //backgroundColor: Colors.black,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                builder: (c) {
                  return Container(
                    height: Get.size.height / 4,
                    decoration: const BoxDecoration(
                      //color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 0,
                            right: 0,
                            bottom: 50,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Obx(
                              () => ListView(
                                padding: const EdgeInsets.only(
                                  top: 13,
                                  left: 10,
                                  right: 10,
                                  bottom: 10,
                                ),
                                children: List.generate(
                                  panierController.listeDeElement.length,
                                  (index) {
                                    Map produit =
                                        panierController.listeDeElement[index];
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      //height: 70,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${index + 1}.",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          Text(
                                            "${produit['name']}".length >= 10
                                                ? "${produit['name']}"
                                                        .characters
                                                        .getRange(0, 8)
                                                        .string +
                                                    "..."
                                                : "${produit['name']}",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          Text(
                                            "  ${produit['variants'][0]['measurement']} ${produit['variants'][0]['measurement_unit_name']}: ${produit["nombre"]}",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, right: 5),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                menuController.showMiniPanier.value = false;
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.red.shade700,
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 30,
                            left: 25,
                            right: 25,
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () {
                                menuController.showMiniPanier.value = false;
                                Get.to(Panier(this));
                              },
                              child: Container(
                                height: 35,
                                //width: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.red.shade700,
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  ),
                                ),
                                child: const Text(
                                  "Passer la commande",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : Container(
                height: 0,
                width: 0,
              ),
      ),
    );
  }

  //
}

/*
Widget Shimm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Card(
          elevation: 1,
          color: Colors.grey,
          child: Container(
            height: 100,
            width: 100,
          ),
        ),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: Card(
            elevation: 1,
            child: Container(
              height: 10,
              width: 100,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: Card(
            elevation: 1,
            child: Container(
              height: 10,
              width: 100,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: Card(
            elevation: 1,
            child: Container(
              height: 10,
              width: 100,
            ),
          ),
        ),
      ],
    );
  }
*/