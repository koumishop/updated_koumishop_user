import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/pages/accueil.dart';
import 'package:koumishop/pages/menu/details.dart';
import 'package:koumishop/pages/panier/panier.dart';
import 'package:koumishop/pages/panier/panier_controller.dart';
import 'package:koumishop/pages/profil/commande/refaire_commande.dart';

import 'favorit_controller.dart';

class Favorit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Favorit();
  }
}

class _Favorit extends State<Favorit> {
  FavoritController favoritController = Get.find();
  //favoritController
  var box = GetStorage();
  //
  List listeE = [];
  //
  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
      loading();
    });
    //
    super.initState();
  }

  loading() async {
    //
    setState(() {
      listeE = box.read("favoris") ?? [];
      listeE = listeE.toSet().toList();
    });
    //
  }

  //
  PanierController panierController = Get.find();
  List listeProduit = [];

  //
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red, // Status bar color
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Scaffold(
          //appBar: AppBar(),
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
                          index.value = 0;
                          //
                          controllerP!.animateToPage(
                            0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.ease,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: Colors.red,
                              ),
                              Text(
                                "Favoris",
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
                    child: ListView(
                      children: List.generate(listeE.length, (index) {
                        Map favoris = listeE[index];
                        favoris['nombre'] = "1";
                        RxInt nombre = 1.obs;
                        print(favoris);
                        return Card(
                          elevation: 1,
                          child: SizedBox(
                            height: 110,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    //padding: EdgeInsets.all(5),
                                    height: 100,
                                    width: 100,
                                    child: Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "${favoris['image']}"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: ListTile(
                                              title: Text(
                                                "${favoris['name']}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              subtitle: Text.rich(
                                                  textAlign: TextAlign.left,
                                                  TextSpan(
                                                    text:
                                                        "${favoris['price']} FC\n",
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            '${favoris['variants'][0]['measurement']} ${favoris['variants'][0]['measurement_unit_name']}',
                                                        style: TextStyle(
                                                          color: Colors
                                                              .grey.shade700,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      )
                                                    ],
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade700,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  )),
                                              trailing: IconButton(
                                                onPressed: () {
                                                  //
                                                  setState(() {
                                                    //RxList l =
                                                    listeE.removeAt(index);
                                                    //l.removeAt(index);
                                                    //favoritController.listeDeElement = l;
                                                    box.write(
                                                        "favoris", listeE);
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                //nombre.value++;

                                                setState(() {
                                                  favoris["quantity"] =
                                                      "${nombre.value}";
                                                  print(favoris);
                                                  //menuController.showMiniPanier.value = false;
                                                  //Get.to(Panier());
                                                  listeProduit.add(favoris);
                                                  //

                                                  listeProduit = listeProduit
                                                      .toSet()
                                                      .toList()
                                                      .obs;
                                                  //
                                                });
                                                //
                                                Get.snackbar("Panier",
                                                    "Produit ajouté au panier.");
                                                // showModalBottomSheet(
                                                //   context: context,
                                                //   isScrollControlled: true,
                                                //   backgroundColor:
                                                //       Colors.transparent,
                                                //   builder: (c) {
                                                //     //return Details();
                                                //     return Column(
                                                //       children: [
                                                //         const SizedBox(
                                                //           height: 50,
                                                //         ),
                                                //         Expanded(
                                                //           flex: 1,
                                                //           child: Container(
                                                //             decoration:
                                                //                 const BoxDecoration(
                                                //               color: Colors
                                                //                   .transparent,
                                                //               borderRadius:
                                                //                   BorderRadius
                                                //                       .only(
                                                //                 topLeft: Radius
                                                //                     .circular(
                                                //                         10),
                                                //                 topRight: Radius
                                                //                     .circular(
                                                //                         10),
                                                //               ),
                                                //             ),
                                                //             child: Column(
                                                //               mainAxisAlignment:
                                                //                   MainAxisAlignment
                                                //                       .start,
                                                //               children: [
                                                //                 SizedBox(
                                                //                   height: 50,
                                                //                   child:
                                                //                       Container(),
                                                //                 ),
                                                //                 Expanded(
                                                //                   flex: 1,
                                                //                   child:
                                                //                       Container(
                                                //                     decoration:
                                                //                         const BoxDecoration(
                                                //                       color: Colors
                                                //                           .white,
                                                //                       borderRadius:
                                                //                           BorderRadius
                                                //                               .only(
                                                //                         topLeft:
                                                //                             Radius.circular(10),
                                                //                         topRight:
                                                //                             Radius.circular(10),
                                                //                       ),
                                                //                     ),
                                                //                     child:
                                                //                         Column(
                                                //                       mainAxisAlignment:
                                                //                           MainAxisAlignment
                                                //                               .start,
                                                //                       children: [
                                                //                         SizedBox(
                                                //                           height:
                                                //                               50,
                                                //                           child:
                                                //                               Row(
                                                //                             mainAxisAlignment:
                                                //                                 MainAxisAlignment.start,
                                                //                             children: [
                                                //                               IconButton(
                                                //                                 onPressed: () {
                                                //                                   Get.back();
                                                //                                 },
                                                //                                 icon: Icon(
                                                //                                   Icons.arrow_back_ios,
                                                //                                   color: Colors.black,
                                                //                                 ),
                                                //                               )
                                                //                             ],
                                                //                           ),
                                                //                         ),
                                                //                         Expanded(
                                                //                           flex:
                                                //                               1,
                                                //                           child:
                                                //                               Padding(
                                                //                             padding:
                                                //                                 EdgeInsets.all(10),
                                                //                             child: Details(
                                                //                                 favoris,
                                                //                                 this,
                                                //                                 index),
                                                //                           ),
                                                //                         )
                                                //                       ],
                                                //                     ),
                                                //                   ),
                                                //                 )
                                                //               ],
                                                //             ),
                                                //           ),
                                                //         )
                                                //       ],
                                                //     );
                                                //   },
                                                // );
                                                // //
                                              },
                                              child: Container(
                                                height: 35,
                                                //width: 30,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.red.shade700,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    15,
                                                  ),
                                                ),
                                                child: const Text(
                                                  "  Ajouter au panier  ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 11),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //
              List l = listeProduit;
              //print(l);
              if (l.isNotEmpty) {
                Get.to(
                  RefaireCommande(
                    l,
                    true,
                    key: UniqueKey(),
                  ),
                );
              } else {
                Get.snackbar("Panier", "Le panier est vide");
              }
              //
            },
            backgroundColor: Colors.red.shade700,
            child: true
                ? Container(
                    height: 50,
                    width: 50,
                    //color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 0),
                      child: Stack(
                        children: [
                          Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              height: 50,
                              width: 50,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.shopping_cart,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            //width: 10,
                            //height: 20,

                            child: Card(
                              elevation: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    3,
                                  ),
                                  color: Colors.yellow.shade700,
                                ),
                                child: Text(
                                  "${listeProduit.length}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                // child: Obx(
                                //   () => Text(
                                //     "${length(panierController.listeDeElement)}",
                                //     style: const TextStyle(
                                //       fontSize: 11,
                                //       fontWeight: FontWeight.bold,
                                //     ),
                                //   ),
                                // ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    );
  }
}
