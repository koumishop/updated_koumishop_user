import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/pages/menu/details.dart';
import 'package:koumishop/pages/menu/menu_controller.dart' as menu;
import 'package:koumishop/pages/panier/panier_controller.dart';
import 'package:koumishop/pages/profil/profil_controller.dart';

class CarteProduit extends StatefulWidget {
  Map produit;
  int idx;

  CarteProduit(this.produit, this.idx);

  @override
  State<StatefulWidget> createState() {
    return _CarteProduit();
  }
  //
}

class _CarteProduit extends State<CarteProduit> {
  //
  PanierController panierController = Get.find();
  ProfilController profilController = Get.find();
  menu.MenuController menuController = Get.find();
  RxString epuise = "Epuisé".obs;

  RxInt nombre = 0.obs;
  Map produit = {};
  int p = 0;

  @override
  void initState() {
    //
    produit = widget.produit;
    //print("le produit: $e");
    // Map p = box.read('${produit["id"]}');
    //produit["nombre"] = p["nombre"];
    nombre.value = getNombreProduitByListePanier(produit["id"]);
    //int.parse(produit["nombre"] ?? "0");
    // //

    double prix = double.parse(produit['variants'][0]['price']);
    //
    if (produit['variants'][0]['discounted_price'] == "" ||
        produit['variants'][0]['discounted_price'] == "0") {
      prix = prix + (prix * double.parse(produit['tax_percentage']) / 100);
      p = prix.round();
    } else {
      prix = double.parse(produit['variants'][0]['discounted_price']) +
          (double.parse(produit['variants'][0]['discounted_price']) *
              double.parse(produit['tax_percentage']) /
              100);
      p = prix.round();
    }
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    nombre.value = getNombreProduitByListePanier(produit["id"]);
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
                                            child: Details(
                                                produit, this, widget.idx),
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
                                            child: Details(
                                                produit, this, widget.idx),
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      if (int.parse(produit['variants'][0]['stock']) <= 0 ||
                          produit['variants'][0]['serve_for'] == "Sold Out") {
                        Get.snackbar("Oups!", "Le stock est épuisé");
                      } else {
                        if (panierController.listeDeElement.isNotEmpty) {
                          menuController.showMiniPanier.value = true;
                        }
                        if (nombre.value > 0) {
                          nombre.value--;
                          produit["nombre"] = "${nombre.value}";
                          //
                          bool v = false;
                          //
                          for (var i = 0;
                              i < panierController.listeDeElement.length;
                              i++) {
                            if (panierController.listeDeElement[i]['id'] ==
                                produit["id"]) {
                              panierController.listeDeElement[i] = produit;
                              v = true;
                            }
                          }
                          if (!v) {
                            panierController.listeDeElement.add(produit);
                          }
                          panierController.listeDeElement.add(produit);
                          panierController.listeDeElement.value =
                              panierController.listeDeElement
                                  .toSet()
                                  .toList()
                                  .obs;
                        }
                        if (nombre.value == 0) {
                          panierController.listeDeElement.remove(produit);
                          //
                          var box = GetStorage();
                          box.write("panier", panierController.listeDeElement);
                          // box.write(
                          //     'paniers',
                          //     panierController
                          //         .listeDeElement);
                          //panierController.listeDeElement
                          //  .clear();
                          //panierController
                          //  .listeDeElement.value = paniers;
                        }
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
                    () => (int.parse(produit['variants'][0]['stock']) <= 0 ||
                            produit['variants'][0]['serve_for'] == "Sold Out")
                        ? Text(
                            " $epuise ",
                            style: TextStyle(
                              fontSize: 6,
                              color: Colors.red.shade700,
                            ),
                          )
                        : Text("${nombre.value}"),
                  ),
                  InkWell(
                    onTap: () {
                      if (int.parse(produit['variants'][0]['stock']) <= 0 ||
                          produit['variants'][0]['serve_for'] == "Sold Out") {
                        Get.snackbar("Oups!", "Le stock est épuisé");
                      } else {
                        if (int.parse(produit['variants'][0]['stock']) <=
                            nombre.value) {
                          Get.snackbar("Oups!", "Le stock est épuisé");
                        } else {
                          menuController.showMiniPanier.value = true;
                          nombre.value++;
                          produit["nombre"] = "${nombre.value}";
                          print(nombre);
                          //box.write('${produit["id"]}',
                          //  jsonEncode(produit));
                          bool v = false;
                          //
                          for (var i = 0;
                              i < panierController.listeDeElement.length;
                              i++) {
                            if (panierController.listeDeElement[i]['id'] ==
                                produit["id"]) {
                              panierController.listeDeElement[i] = produit;
                              v = true;
                            }
                          }
                          if (!v) {
                            panierController.listeDeElement.add(produit);
                          }
                          panierController.listeDeElement.value =
                              panierController.listeDeElement
                                  .toSet()
                                  .toList()
                                  .obs;
                          //
                          var box = GetStorage();
                          box.write("panier", panierController.listeDeElement);
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
  }

  int getNombreProduitByListePanier(String id) {
    //
    int n = 0;
    bool v = false;
    panierController.listeDeElement.forEach((element) {
      //
      print("$element");
      //
      if ("${element['id']}" == id) {
        print("${element['product_id']} ----------------------------- $id");
        n = int.parse("${element['nombre']}");
        v = true;
      }
    });

    if (v) {}
    return n;
  }
}
