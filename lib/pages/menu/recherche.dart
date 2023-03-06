import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/pages/menu/details.dart';
import 'package:koumishop/pages/menu/menu_controller.dart';
import 'package:koumishop/pages/menu/recherche_controller.dart';
import 'package:flutter/material.dart';
import 'package:koumishop/pages/panier/panier_controller.dart';
import 'package:shimmer/shimmer.dart';

class Recherche extends StatefulWidget {
  String text;
  int idService;
  Recherche(this.text, this.idService);
  @override
  State<StatefulWidget> createState() {
    return _Recherche();
  }
}

class _Recherche extends State<Recherche> {
  //
  RechercheController controller = Get.find();
  //
  PanierController panierController = Get.find();
  MenuController menuController = Get.find();
  //

  @override
  void initState() {
    //

    controller.getRecherche(widget.text, widget.idService);
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red, //
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(255, 137, 147, 1),
                  Color(0xFFFFFFFF),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          //
                          Get.back();
                          //
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          //width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: Colors.red,
                              ),
                              Text(
                                "Recherche",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                    // ignore: sort_child_properties_last
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          child: Card(
                            child: Container(
                              alignment: Alignment.center,
                              child: TextField(
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.search,
                                onSubmitted: (text) {
                                  //
                                  controller.getRecherche(
                                      text, widget.idService);
                                  //
                                },
                                decoration: const InputDecoration(
                                    fillColor: Colors.red,
                                    focusColor: Colors.red,
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 5),
                                    hintText: 'Recherche',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                    ),
                                    border: InputBorder.none
                                    // border: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.circular(20),
                                    //   borderSide: const BorderSide(
                                    //     color: Colors.white,
                                    //     width: 1,
                                    //   ),
                                    // ),
                                    ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: controller.obx(
                            (state) => Container(
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                crossAxisCount: 3,
                                mainAxisSpacing: 0.1,
                                crossAxisSpacing: 0.1,
                                childAspectRatio: 0.6,
                                children: List.generate(state!.length, (index) {
                                  //print('truc:--------');
                                  Map produit = state[index];
                                  RxString epuise = "epuise".obs;
                                  RxInt nombre = 0.obs;
                                  //Map e = menuController.listeProduit.elementAt(i);
                                  //print("le produit: $e");
                                  // Map p = box.read('${produit["id"]}');
                                  //produit["nombre"] = p["nombre"];
                                  nombre.value = getNombreProduitByListePanier(
                                      produit["id"]);
                                  //int.parse(produit["nombre"] ?? "0");
                                  //print("execution de truc... ${e["id"]}");
                                  print(
                                      "execution de truc... ${produit["id"]}");
                                  //print(
                                  //  "execution de truc... ${e["id"] == produit["id"]}");
                                  print(
                                      "execution de truc... ${produit["name"]}");
                                  print(
                                      "execution de truc... ${produit["nombre"]}");
                                  //print("execution de truc*** ${e}");
                                  print("execution de truc... ${nombre.value}");
                                  //

                                  print('truc:--------');
                                  int p = 0;
                                  double prix = double.parse(
                                      produit['variants'][0]['price']);
                                  //
                                  if (produit['variants'][0]
                                              ['discounted_price'] ==
                                          "" ||
                                      produit['variants'][0]
                                              ['discounted_price'] ==
                                          "0") {
                                    prix = prix +
                                        (prix *
                                            double.parse(
                                                produit['tax_percentage']) /
                                            100);
                                    p = prix.round();
                                  } else {
                                    prix = double.parse(produit['variants'][0]
                                            ['discounted_price']) +
                                        (double.parse(produit['variants'][0]
                                                ['discounted_price']) *
                                            double.parse(
                                                produit['tax_percentage']) /
                                            100);
                                    p = prix.round();
                                  }
                                  //Map produit = listeProduit[index];
                                  return Card(
                                    elevation: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                backgroundColor:
                                                    Colors.transparent,
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
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                            ),
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                height: 50,
                                                                child:
                                                                    Container(),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              10),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              10),
                                                                    ),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            50,
                                                                        child:
                                                                            Row(
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
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(10),
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
                                                      alignment:
                                                          Alignment.center,
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
                                                backgroundColor:
                                                    Colors.transparent,
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
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              topRight: Radius
                                                                  .circular(10),
                                                            ),
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                height: 50,
                                                                child:
                                                                    Container(),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              10),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              10),
                                                                    ),
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            50,
                                                                        child:
                                                                            Row(
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
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.all(10),
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                                Text(
                                                  "${produit['variants'][0]['measurement']} ${produit['variants'][0]['measurement_unit_name']}",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                ), //"${produit['price']} FC",
                                                Text(
                                                  "$p FC",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    if (int.parse(produit[
                                                                    'variants']
                                                                [0]['stock']) <=
                                                            0 ||
                                                        produit['variants'][0]
                                                                ['serve_for'] ==
                                                            "Sold Out") {
                                                      Get.snackbar("Oups!",
                                                          "Le stock est épuisé");
                                                    } else {
                                                      if (panierController
                                                          .listeDeElement
                                                          .isNotEmpty) {
                                                        menuController
                                                            .showMiniPanier
                                                            .value = true;
                                                      }
                                                      if (nombre.value > 0) {
                                                        nombre.value--;
                                                        produit["nombre"] =
                                                            "${nombre.value}";
                                                        //
                                                        bool v = false;
                                                        //
                                                        for (var i = 0;
                                                            i <
                                                                panierController
                                                                    .listeDeElement
                                                                    .length;
                                                            i++) {
                                                          if (panierController
                                                                      .listeDeElement[
                                                                  i]['id'] ==
                                                              produit["id"]) {
                                                            panierController
                                                                    .listeDeElement[
                                                                i] = produit;
                                                            v = true;
                                                          }
                                                        }
                                                        if (!v) {
                                                          panierController
                                                              .listeDeElement
                                                              .add(produit);
                                                        }
                                                        panierController
                                                            .listeDeElement
                                                            .add(produit);
                                                        panierController
                                                                .listeDeElement
                                                                .value =
                                                            panierController
                                                                .listeDeElement
                                                                .toSet()
                                                                .toList()
                                                                .obs;
                                                      }
                                                      if (nombre.value == 0) {
                                                        panierController
                                                            .listeDeElement
                                                            .remove(produit);
                                                        //
                                                        var box = GetStorage();
                                                        box.write(
                                                            "panier",
                                                            panierController
                                                                .listeDeElement);
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        14,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors
                                                            .grey.shade300,
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
                                                  () => (int.parse(produit[
                                                                      'variants'][0]
                                                                  ['stock']) <=
                                                              0 ||
                                                          produit['variants'][0]
                                                                  [
                                                                  'serve_for'] ==
                                                              "Sold Out")
                                                      ? Text(
                                                          " $epuise ",
                                                          style: TextStyle(
                                                            fontSize: 6,
                                                            color: Colors
                                                                .red.shade700,
                                                          ),
                                                        )
                                                      : Text("${nombre.value}"),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    if (int.parse(produit[
                                                                    'variants']
                                                                [0]['stock']) <=
                                                            0 ||
                                                        produit['variants'][0]
                                                                ['serve_for'] ==
                                                            "Sold Out") {
                                                      Get.snackbar("Oups!",
                                                          "Le stock est épuisé");
                                                    } else {
                                                      if (int.parse(produit[
                                                                  'variants'][0]
                                                              ['stock']) <=
                                                          nombre.value) {
                                                        Get.snackbar("Oups!",
                                                            "Le stock est épuisé");
                                                      } else {
                                                        menuController
                                                            .showMiniPanier
                                                            .value = true;
                                                        nombre.value++;
                                                        produit["nombre"] =
                                                            "${nombre.value}";
                                                        print(nombre);
                                                        //box.write('${produit["id"]}',
                                                        //  jsonEncode(produit));
                                                        bool v = false;
                                                        //
                                                        for (var i = 0;
                                                            i <
                                                                panierController
                                                                    .listeDeElement
                                                                    .length;
                                                            i++) {
                                                          if (panierController
                                                                      .listeDeElement[
                                                                  i]['id'] ==
                                                              produit["id"]) {
                                                            panierController
                                                                    .listeDeElement[
                                                                i] = produit;
                                                            v = true;
                                                          }
                                                        }
                                                        if (!v) {
                                                          panierController
                                                              .listeDeElement
                                                              .add(produit);
                                                        }
                                                        panierController
                                                                .listeDeElement
                                                                .value =
                                                            panierController
                                                                .listeDeElement
                                                                .toSet()
                                                                .toList()
                                                                .obs;
                                                        //
                                                        var box = GetStorage();
                                                        box.write(
                                                            "panier",
                                                            panierController
                                                                .listeDeElement);
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
                                                      color:
                                                          Colors.red.shade700,
                                                      borderRadius:
                                                          BorderRadius.circular(
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
                            onLoading: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              direction: ShimmerDirection.ttb,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(flex: 4, child: Shimm()),
                                      Expanded(flex: 4, child: Shimm()),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(flex: 4, child: Shimm()),
                                      Expanded(flex: 4, child: Shimm()),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(flex: 4, child: Shimm()),
                                      Expanded(flex: 4, child: Shimm()),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                            onEmpty: Container(
                              padding: const EdgeInsets.only(top: 20),
                              alignment: Alignment.topCenter,
                              child: const Text(
                                "Aucune donnée trouvé",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            onError: (erreur) => const Center(
                              child: Icon(
                                Icons.cloud_download_outlined,
                                size: 150,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
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

  //
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
}
