import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/components/menu/menu_details.dart';
import 'package:koumishop/controllers/menu_controller.dart' as menu;
import 'package:koumishop/controllers/cart_controller.dart';
import 'package:koumishop/controllers/profile_controller.dart';

// ignore: must_be_immutable
class CarteProduit extends StatefulWidget {
  Map produit;
  int idx;

  CarteProduit(this.produit, this.idx, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _CarteProduit();
  }
}

class _CarteProduit extends State<CarteProduit> {
  CartController cartController = Get.find();
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
    nombre.value = getNombreProduitByListePanier(produit["id"]);
    double prix = double.parse(produit['variants'][0]['price']);

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
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (c) {
                    return Column(
                      children: [
                        const SizedBox(
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
                                                icon: const Icon(
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
                                            padding: const EdgeInsets.all(10),
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
                      padding: const EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.network("${produit['image']}"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (c) {
                    return Column(
                      children: [
                        const SizedBox(
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
                                                icon: const Icon(
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
                                            padding: const EdgeInsets.all(10),
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
                  ),
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
                        if (cartController.itemList.isNotEmpty) {
                          menuController.showMiniCart.value = true;
                        }
                        if (nombre.value > 0) {
                          nombre.value--;
                          produit["nombre"] = "${nombre.value}";
                          bool v = false;
                          for (var i = 0;
                              i < cartController.itemList.length;
                              i++) {
                            if (cartController.itemList[i]['id'] ==
                                produit["id"]) {
                              cartController.itemList[i] = produit;
                              v = true;
                            }
                          }
                          if (!v) {
                            cartController.itemList.add(produit);
                          }
                          cartController.itemList.add(produit);
                          cartController.itemList.value =
                              cartController.itemList.toSet().toList().obs;
                        }
                        if (nombre.value == 0) {
                          cartController.itemList.remove(produit);
                          //
                          var box = GetStorage();
                          box.write("panier", cartController.itemList);
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
                          menuController.showMiniCart.value = true;
                          nombre.value++;
                          produit["nombre"] = "${nombre.value}";
                          bool v = false;
                          for (var i = 0;
                              i < cartController.itemList.length;
                              i++) {
                            if (cartController.itemList[i]['id'] ==
                                produit["id"]) {
                              cartController.itemList[i] = produit;
                              v = true;
                            }
                          }
                          if (!v) {
                            cartController.itemList.add(produit);
                          }
                          cartController.itemList.value =
                              cartController.itemList.toSet().toList().obs;
                          var box = GetStorage();
                          box.write("panier", cartController.itemList);
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
        ],
      ),
    );
  }

  int getNombreProduitByListePanier(String id) {
    //
    int n = 0;
    bool v = false;
    for (var element in cartController.itemList) {
      if ("${element['id']}" == id) {
        n = int.parse("${element['nombre']}");
        v = true;
      }
    }

    if (v) {}
    return n;
  }
}
