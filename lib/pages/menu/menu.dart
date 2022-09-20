import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/pages/menu/menu_controller.dart';
import 'package:koumishop/pages/panier/panier_controller.dart';
import 'package:shimmer/shimmer.dart';

import 'details.dart';

class Menu extends GetView<MenuController> {
  //String subcategory_id;
  PanierController panierController = Get.find();
  MenuController menuController = Get.find();
  RxString epuise = "Epuisé".obs;
  List listeProduit;
  Menu(this.listeProduit, {Key? key}) : super(key: key) {
    print("Le menu type...");
    //Timer(const Duration(seconds: 2), () {
    //controller.getMenu(subcategory_id);
    //});
  }
  @override
  Widget build(BuildContext context) {
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
        child: GridView.count(
          controller: ScrollController(),
          padding: const EdgeInsets.symmetric(horizontal: 3),
          crossAxisCount: 2,
          mainAxisSpacing: 0.1,
          crossAxisSpacing: 0.1,
          childAspectRatio: 0.6,
          children: List.generate(listeProduit.length, (index) {
            //
            Map produit = listeProduit[index];

            RxInt nombre = 0.obs;
            for (var i = 0; i < panierController.listeDeElement.length; i++) {
              Map e = panierController.listeDeElement.elementAt(i);
              print("le produit: $e");
              if (e["id"] == produit["id"]) {
                // Map p = box.read('${produit["id"]}');
                //print("le produit: $p");
                //produit["nombre"] = p["nombre"];
                nombre.value = int.parse(produit["nombre"] ?? "0");
                //
                break;
              } else {
                //
                nombre.value = 0;
                produit["nombre"] = "0";
              }
              //x++;
            }
            print('truc:--------');
            int p = 0;
            double prix = double.parse(produit['variants'][0]['price']);
            //
            if (produit['variants'][0]['discounted_price'] == "" ||
                produit['variants'][0]['discounted_price'] == "0") {
              prix =
                  prix + (prix * double.parse(produit['tax_percentage']) / 100);
              p = prix.round();
            } else {
              prix = double.parse(produit['variants'][0]['discounted_price']) +
                  (double.parse(produit['variants'][0]['discounted_price']) *
                      double.parse(produit['tax_percentage']) /
                      100);
              p = prix.round();
            }
            //Map produit = listeProduit[index];
            return InkWell(
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                icon: Icon(
                                                  Icons.arrow_back_ios,
                                                  color: Colors.black,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Details(produit),
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
              child: Card(
                elevation: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 8,
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
                                child: Image.network("${produit['image']}"),
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
                    Expanded(
                      flex: 4,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "${produit['name']}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                if (nombre.value > 0) {
                                  nombre.value--;
                                  produit["nombre"] = "${nombre.value}";
                                  //box.write(
                                  //  '${produit["id"]}', produit);
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
                                height: 30,
                                width: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                    15,
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
                              () =>
                                  (int.parse(produit['variants'][0]['stock']) !=
                                          0)
                                      ? Text("${nombre.value}")
                                      : Text(
                                          " $epuise ",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: Colors.red.shade700,
                                          ),
                                        ),
                            ),
                            InkWell(
                              onTap: () {
                                if (int.parse(
                                        produit['variants'][0]['stock']) ==
                                    0) {
                                  Get.snackbar("Oups!", "stock épuisé");
                                } else {
                                  nombre.value++;
                                  produit["nombre"] = "${nombre.value}";
                                  //box.write('${produit["id"]}',
                                  //  jsonEncode(produit));
                                  bool v = false;
                                  panierController.listeDeElement.add(produit);
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
                    SizedBox(
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
              ),
            );
          }),
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                builder: (c) {
                  return Container(
                    height: Get.size.height / 4.5,
                    decoration: const BoxDecoration(
                      //color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: Obx(
                              () => ListView(
                                padding: const EdgeInsets.only(top: 5, left: 5),
                                children: List.generate(
                                  panierController.listeDeElement.length,
                                  (index) {
                                    Map produit =
                                        panierController.listeDeElement[index];
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 15),
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
                                            "${produit['name']}",
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