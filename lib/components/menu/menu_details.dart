// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koumishop/controllers/favorites_controller.dart';
import 'package:koumishop/controllers/menu_controller.dart' as menu;
import 'package:koumishop/screens/cart.dart';
import 'package:koumishop/controllers/cart_controller.dart';
import 'package:koumishop/pages/profil/log/log.dart';
import 'package:koumishop/controllers/profile_controller.dart';
import 'package:shimmer/shimmer.dart';

import 'package:koumishop/controllers/details_controller.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  State st;
  Map produit;
  int idx;
  Details(this.produit, this.st, this.idx, {super.key});
  @override
  State<StatefulWidget> createState() {
    return _Details();
  }
}

class _Details extends State<Details> {
  RxBool contient = false.obs;
  RxString epuise = "epuise".obs;
  CartController panierController = Get.find();
  FavoritesController favoritesController = Get.put(FavoritesController());
  DetailsController controller = Get.find();
  menu.MenuController menuController = Get.find();
  ProfilController profilController = Get.find();
  RxInt nombre = 0.obs;
  var box = GetStorage();
  int x = 0;
  Map produit = {};

  @override
  void initState() {
    try {
      produit = widget.produit;
      isLike(produit['id']);
      Timer(const Duration(seconds: 1), () {
        List lf = box.read("favoris") ?? [];

        for (var i = 0; i < lf.length; i++) {
          if (lf[i]['id'] == produit["id"]) {}
        }
      });
      // ignore: empty_catches
    } catch (e) {}
    nombre.value = nombre.value = getNombreProduitByListePanier(produit["id"]);
    for (var i = 0; i < panierController.itemList.length; i++) {
      Map e = panierController.itemList.elementAt(i);
      if (e["id"] == produit["id"]) {
        break;
      } else {}
      x++;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: Get.size.height / 5,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                elevation: 2,
                child: Container(
                  height: 120,
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("${produit['image']}"),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "${produit['name']}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "${produit['variants'][0]['measurement']} ${produit['variants'][0]['measurement_unit_name']}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.comicNeue(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(
                              flex: 2,
                              child: SizedBox(),
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.red,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (panierController
                                            .itemList.isNotEmpty) {
                                          menuController.showMiniCart.value =
                                              true;
                                        }
                                        if (nombre.value > 0) {
                                          nombre.value--;
                                          produit["nombre"] = "${nombre.value}";
                                          panierController.itemList[widget.idx]
                                              ['nombre'] = "${nombre.value}";
                                          //
                                          bool v = false;
                                          //
                                          for (var i = 0;
                                              i <
                                                  panierController
                                                      .itemList.length;
                                              i++) {
                                            if (panierController.itemList[i]
                                                    ['id'] ==
                                                produit["id"]) {
                                              panierController.itemList[i] =
                                                  produit;
                                              v = true;
                                            }
                                          }
                                          if (!v) {
                                            panierController.itemList
                                                .add(produit);
                                          }
                                          panierController.itemList.value =
                                              panierController.itemList
                                                  .toSet()
                                                  .toList()
                                                  .obs;
                                          for (int x = 0;
                                              x <
                                                  menuController
                                                      .itemList.length;
                                              x++) {
                                            if (menuController.itemList.value[x]
                                                    ['id'] ==
                                                produit['id']) {
                                              menuController.itemList.value[x]
                                                      ['nombre'] =
                                                  "${nombre.value}";
                                            }
                                          }
                                        }
                                        if (nombre.value == 0) {
                                          panierController.itemList
                                              .remove(produit);
                                          //
                                          var box = GetStorage();
                                          box.write("panier",
                                              panierController.itemList);
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
                                      () => (int.parse(produit['variants'][0]
                                                      ['stock']) <=
                                                  0 ||
                                              produit['variants'][0]
                                                      ['serve_for'] ==
                                                  "Sold Out")
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
                                        menuController.showMiniCart.value =
                                            true;

                                        if (int.parse(produit['variants'][0]
                                                    ['stock']) <=
                                                0 ||
                                            produit['variants'][0]
                                                    ['serve_for'] ==
                                                "Sold Out") {
                                          Get.snackbar("Oups!", "stock épuisé");
                                        } else {
                                          if (int.parse(produit['variants'][0]
                                                  ['stock']) <=
                                              nombre.value) {
                                            Get.snackbar(
                                                "Oups!", "Le stock est épuisé");
                                          } else {
                                            nombre.value++;
                                            produit["nombre"] =
                                                "${nombre.value}";
                                            bool v = false;
                                            for (var i = 0;
                                                i <
                                                    panierController
                                                        .itemList.length;
                                                i++) {
                                              if (panierController.itemList[i]
                                                      ['id'] ==
                                                  produit["id"]) {
                                                panierController.itemList[i] =
                                                    produit;
                                                v = true;
                                              }
                                            }
                                            if (!v) {
                                              panierController.itemList
                                                  .add(produit);
                                            }

                                            panierController.itemList.value =
                                                panierController.itemList
                                                    .toSet()
                                                    .toList()
                                                    .obs;
                                            for (int x = 0;
                                                x <
                                                    menuController
                                                        .itemList.length;
                                                x++) {
                                              if (menuController.itemList
                                                      .value[x]['id'] ==
                                                  produit['id']) {
                                                menuController.itemList.value[x]
                                                        ['nombre'] =
                                                    "${nombre.value}";
                                              }
                                            }

                                            var box = GetStorage();
                                            box.write("panier",
                                                panierController.itemList);
                                          }
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
                            const Expanded(
                              flex: 2,
                              child: SizedBox(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () async {
                        Map p = box.read("profile") ?? RxMap();
                        if (p['name'] == null) {
                          Get.to(Log(this));
                        } else {
                          if (!contient.value) {
                            List lf = box.read("favoris") ?? [];
                            produit["nombre"] = "1";
                            lf.add(produit);
                            lf = lf.toSet().toList().obs; //
                            contient.value = true;
                            box.write("favoris", lf);
                            addFavorites(produit["id"]);
                          } else {
                            List lf = box.read("favoris") ?? [];

                            for (var i = 0; i < lf.length; i++) {
                              if (lf[i]["id"] == produit['id']) {
                                lf.removeAt(i);
                              }
                            }
                            lf = lf.toSet().toList().obs; //
                            contient.value = false;
                            box.write("favoris", lf);
                            deleteFavorites(produit["id"]);
                          }
                        }
                      },
                      icon: Obx(
                        () => Icon(
                          contient.value
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: Colors.red,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Produits similaires",
              style: TextStyle(
                color: Colors.grey.shade500,
              ),
            )
          ],
        ),
        Container(
          height: 100,
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(color: Colors.white),
          child: FutureBuilder(
            future: controller.getSimilaire("${produit['category_id']}",
                "${produit['variants'][0]['product_id']}"),
            builder: (context, t) {
              if (t.hasData) {
                List l1 = t.data as List;
                return ListView(
                  scrollDirection: Axis.horizontal,
                  controller: ScrollController(),
                  children: List.generate(l1.length, (index) {
                    Map p1 = l1[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          elevation: 2,
                          child: InkWell(
                            onTap: () {
                              Get.back();
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
                                                        MainAxisAlignment.start,
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
                                                              icon: const Icon(
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
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Details(p1,
                                                              widget.st, index),
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
                              height: 70,
                              width: 70,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage("${p1['image']}"),
                                  fit: BoxFit.cover,
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(35),
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("${p1['name']}"),
                      ],
                    );
                  }),
                );
              } else if (t.hasError) {
                return Container();
              }
              return SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    Container(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    Container(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    Container(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    Container(
                      width: 10,
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    Container(
                      width: 10,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Produits complementaires",
              style: TextStyle(
                color: Colors.grey.shade500,
              ),
            )
          ],
        ),
        Container(
          height: 100,
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(color: Colors.white),
          child: FutureBuilder(
            future: controller.getComplementaire("${produit['category_id']}",
                "${produit['variants'][0]['product_id']}"),
            builder: (context, t) {
              if (t.hasData) {
                List l1 = t.data as List;
                return ListView(
                  scrollDirection: Axis.horizontal,
                  controller: ScrollController(),
                  children: List.generate(l1.length, (index) {
                    Map p1 = l1[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          elevation: 2,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (c) {
                                  //return Details();
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
                                                        MainAxisAlignment.start,
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
                                                              icon: const Icon(
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
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Details(p1,
                                                              widget.st, index),
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
                              height: 70,
                              width: 70,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage("${p1['image']}"),
                                  fit: BoxFit.cover,
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(35),
                                border: Border.all(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("${p1['name']}"),
                      ],
                    );
                  }),
                );
              } else if (t.hasError) {
                return Container();
              }
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                direction: ShimmerDirection.ttb,
                child: SizedBox(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      Container(
                        width: 10,
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      Container(
                        width: 10,
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      Container(
                        width: 10,
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      Container(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Card(
          child: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(
                Colors.red.shade100,
              ),
            ),
            onPressed: () {
              Get.back();
              Get.to(Cart(this));
            },
            child: SizedBox(
              width: Get.size.width / 1.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(
                    () => nombre.value != 0
                        ? Text(
                            "FC ${nombre.value * double.parse(produit['price'])}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            "FC ${produit['price']}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  Container(
                    height: 34,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    child: const Text(
                      "    Aller au panier    ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  deleteFavorites(String id) async {
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('https://webadmin.koumishop.com/api-firebase/favorites.php'));
    request.fields.addAll({
      'accesskey': '90336',
      'remove_from_favorites': '1',
      'product_id': id,
      'user_id ': '${profilController.data['user_id']}',
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(await response.stream.bytesToString());
      }
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }
  }

  addFavorites(String id) async {
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('https://webadmin.koumishop.com/api-firebase/favorites.php'));
    request.fields.addAll({
      'accesskey': '90336',
      'user_id': '${profilController.data['user_id']}',
      'product_id': id,
      'add_to_favorites': '1'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(await response.stream.bytesToString());
      }
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }
  }

  @override
  void dispose() {
    //
    Timer(const Duration(milliseconds: 500), () {
      //print("J'ai quitté l'interface détails");
      widget.st.setState(() {});
    });
    //
    super.dispose();
  }

  isLike(String id) async {
    //contient.value
    //
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg',
      'Cookie': 'PHPSESSID=12aa9d01877bc697e052e8483dd51afb'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://webadmin.koumishop.com/api-firebase/get-products.php'));
    request.fields.addAll({
      'accesskey': '90336',
      'subcategory_id': '7',
      'offset': '0',
      'limit': '10',
      'get_all_products': "1",
      'user_id': '${profilController.data['user_id']}',
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String rep = await response.stream.bytesToString();
      if (kDebugMode) {
        print("la reponse du serveur: $rep");
      }
      Map r = jsonDecode(rep);
      if (!r["error"]) {
        List l = r["data"]; //[0]["is_favorite"];
        for (var element in l) {
          if (element['id'] == id && element['is_favorite'] == true) {
            contient.value = true;
          }
        }
      }
      if (kDebugMode) {
        print(r);
      }
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }
  }

  int getNombreProduitByListePanier(String id) {
    //
    int n = 0;
    bool v = false;
    for (var element in panierController.itemList) {
      if ("${element['id']}" == id) {
        n = int.parse("${element['nombre']}");
        v = true;
      }
    }

    if (v) {}
    return n;
  }
}
