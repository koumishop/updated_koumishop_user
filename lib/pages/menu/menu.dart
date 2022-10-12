import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/pages/menu/menu_controller.dart';
import 'package:koumishop/pages/panier/panier.dart';
import 'package:koumishop/pages/panier/panier_controller.dart';
import 'package:koumishop/pages/profil/profil_controller.dart';
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

                    RxInt nombre = 0.obs;
                    //Map e = menuController.listeProduit.elementAt(i);
                    //print("le produit: $e");
                    // Map p = box.read('${produit["id"]}');
                    //produit["nombre"] = p["nombre"];
                    nombre.value = getNombreProduitByListePanier(produit["id"]);
                    //int.parse(produit["nombre"] ?? "0");
                    //print("execution de truc... ${e["id"]}");
                    print("execution de truc... ${produit["id"]}");
                    //print(
                    //  "execution de truc... ${e["id"] == produit["id"]}");
                    print("execution de truc... ${produit["name"]}");
                    print("execution de truc... ${produit["nombre"]}");
                    //print("execution de truc*** ${e}");
                    print("execution de truc... ${nombre.value}");
                    //

                    print('truc:--------');
                    int p = 0;
                    double prix = double.parse(produit['variants'][0]['price']);
                    //
                    if (produit['variants'][0]['discounted_price'] == "" ||
                        produit['variants'][0]['discounted_price'] == "0") {
                      prix = prix +
                          (prix *
                              double.parse(produit['tax_percentage']) /
                              100);
                      p = prix.round();
                    } else {
                      prix = double.parse(
                              produit['variants'][0]['discounted_price']) +
                          (double.parse(
                                  produit['variants'][0]['discounted_price']) *
                              double.parse(produit['tax_percentage']) /
                              100);
                      p = prix.round();
                    }
                    //Map produit = listeProduit[index];
                    return Card(
                      elevation: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 7,
                            child: InkWell(
                              onTap: () {
                                //PanierController
                                //
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (c) {
                                    //return Details();
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 50,
                                                  child: Container(),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 50,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              IconButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .arrow_back_ios,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Details(
                                                                produit,
                                                                this,
                                                                index),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Stack(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Image.network(
                                            "${produit['image']}"),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: EdgeInsets.all(2),
                                    //   child: Align(
                                    //     alignment: Alignment.topRight,
                                    //     child: IconButton(
                                    //       icon: const Icon(
                                    //         Icons.favorite_outline,
                                    //         size: 20,
                                    //       ),
                                    //       color: Colors.red,
                                    //       onPressed: () {
                                    //         //
                                    //       },
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: InkWell(
                              onTap: () {
                                //PanierController
                                //
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (c) {
                                    //return Details();
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 50,
                                                  child: Container(),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 50,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              IconButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .arrow_back_ios,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            child: Details(
                                                                produit,
                                                                this,
                                                                index),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Text(
                                    "${produit['name']}",
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    "${produit['variants'][0]['measurement']} ${produit['variants'][0]['measurement_unit_name']}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 10,
                                    ),
                                  ), //"${produit['price']} FC",
                                  Text(
                                    "$p FC",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (panierController
                                          .listeDeElement.isNotEmpty) {
                                        menuController.showMiniPanier.value =
                                            true;
                                      }
                                      if (nombre.value > 0) {
                                        nombre.value--;
                                        produit["nombre"] = "${nombre.value}";
                                        //
                                        for (var i = 0;
                                            i <
                                                panierController
                                                    .listeDeElement.length;
                                            i++) {
                                          if (panierController.listeDeElement[i]
                                                  ['id'] ==
                                              produit["id"]) {
                                            panierController.listeDeElement[i] =
                                                produit;
                                            break;
                                          }
                                        }
                                        panierController.listeDeElement
                                            .add(produit);
                                        panierController.listeDeElement.value =
                                            panierController.listeDeElement
                                                .toSet()
                                                .toList()
                                                .obs;
                                      }
                                      if (nombre.value == 0) {
                                        panierController.listeDeElement
                                            .remove(produit);
                                        //
                                        var box = GetStorage();
                                        box.write("panier",
                                            panierController.listeDeElement);
                                        // box.write(
                                        //     'paniers',
                                        //     panierController
                                        //         .listeDeElement);
                                        //panierController.listeDeElement
                                        //  .clear();
                                        //panierController
                                        //  .listeDeElement.value = paniers;
                                      }
                                    },
                                    child: Container(
                                      height: 28,
                                      width: 28,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                          14,
                                        ),
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.remove,
                                        size: 19,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => (int.parse(produit['variants'][0]
                                                ['stock']) !=
                                            0)
                                        ? Text("${nombre.value}")
                                        : Text(
                                            " $epuise ",
                                            style: TextStyle(
                                              fontSize: 6,
                                              color: Colors.red.shade700,
                                            ),
                                          ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      menuController.showMiniPanier.value =
                                          true;
                                      if (int.parse(produit['variants'][0]
                                              ['stock']) ==
                                          0) {
                                        Get.snackbar(
                                            "Oups!", "Le stock est épuisé");
                                      } else {
                                        nombre.value++;
                                        produit["nombre"] = "${nombre.value}";
                                        //box.write('${produit["id"]}',
                                        //  jsonEncode(produit));
                                        bool v = false;
                                        //panierController.listeDeElement.
                                        for (var i = 0;
                                            i <
                                                panierController
                                                    .listeDeElement.length;
                                            i++) {
                                          if (panierController.listeDeElement[i]
                                                  ['id'] ==
                                              produit["id"]) {
                                            panierController.listeDeElement[i] =
                                                produit;
                                            break;
                                          }
                                        }
                                        panierController.listeDeElement
                                            .add(produit);
                                        panierController.listeDeElement.value =
                                            panierController.listeDeElement
                                                .toSet()
                                                .toList()
                                                .obs;
                                        //
                                        var box = GetStorage();
                                        box.write("panier",
                                            panierController.listeDeElement);
                                        // panierController.listeDeElement
                                        //     .forEach((element) {});
                                        //
                                        // if (!v) {
                                        //   panierController.listeDeElement
                                        //       .add('${produit["id"]}');
                                        //   box.write(
                                        //       'paniers',
                                        //       panierController
                                        //           .listeDeElement.value);
                                        //   //panierController.listeDeElement
                                        //   //  .clear();
                                        //   //panierController
                                        //   //  .listeDeElement.value = paniers;
                                        // }
                                      }
                                    },
                                    child: Container(
                                      height: 28,
                                      width: 28,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade700,
                                        borderRadius: BorderRadius.circular(
                                          14,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          // Expanded(
                          //   flex: 2,
                          //   child: Container(
                          //     alignment: Alignment.center,
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         // InkWell(
                          //         //   onTap: () {},
                          //         //   child: Container(
                          //         //     height: 20,
                          //         //     width: 20,
                          //         //     alignment: Alignment.center,
                          //         //     decoration: BoxDecoration(
                          //         //       color: Colors.white,
                          //         //       borderRadius: BorderRadius.circular(
                          //         //         10,
                          //         //       ),
                          //         //       border: Border.all(
                          //         //         color: Colors.grey.shade300,
                          //         //       ),
                          //         //     ),
                          //         //     child: Icon(
                          //         //       Icons.remove,
                          //         //       size: 19,
                          //         //       color: Colors.red,
                          //         //     ),
                          //         //   ),
                          //         // ),
                          //         Text(
                          //           "En stock",
                          //           style: TextStyle(
                          //             color: Colors.green,
                          //             fontSize: 17,
                          //             fontWeight: FontWeight.bold,
                          //           ),
                          //         ),
                          //         // InkWell(
                          //         //   onTap: () {},
                          //         //   child: Container(
                          //         //     height: 20,
                          //         //     width: 20,
                          //         //     alignment: Alignment.center,
                          //         //     decoration: BoxDecoration(
                          //         //       color: Colors.red.shade700,
                          //         //       borderRadius: BorderRadius.circular(
                          //         //         10,
                          //         //       ),
                          //         //     ),
                          //         //     child: Icon(
                          //         //       Icons.add,
                          //         //       size: 20,
                          //         //       color: Colors.white,
                          //         //     ),
                          //         //   ),
                          //         // ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    );
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
                                Get.to(Panier());
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
  int getNombreProduitByListePanier(String id) {
    //
    int n = 0;
    panierController.listeDeElement.forEach((element) {
      //
      if (element['id'] == id) {
        n = int.parse("${element['nombre']}");
      }
    });
    return n;
  }
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