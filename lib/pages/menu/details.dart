import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koumishop/pages/favorits/favorit_controller.dart';
import 'package:koumishop/pages/panier/panier_controller.dart';

import 'details_controller.dart';

class Details extends GetView<DetailsController> {
  //
  Map produit;
  RxBool contient = false.obs;
  //
  PanierController panierController = Get.find();
  FavoritController favoritController = Get.find();
  //
  List produitS = [
    {"nom": "Soupe", "logo": "cuisine2.jpg"},
    {"nom": "Poisson", "logo": "poisson1.jpeg"},
    {"nom": "Cuisine", "logo": "cuisine1.png"},
    {"nom": "Produit menager", "logo": "menage1.png"},
    {"nom": "Scnack", "logo": "pain1.png"},
    {"nom": "Fruit & légume", "logo": "cuisine3.jpeg"},
  ];
  //
  RxInt nombre = 0.obs;
  int x = 0;
  //final box = GetStorage();
  //List paniers = [];
  //
  List produitC = [
    {"nom": "Produit menager", "logo": "menage1.png"},
    {"nom": "Viande", "logo": "viande1.jpeg"},
    {"nom": "Pain", "logo": "pain1.png"},
    {"nom": "Produit laitié", "logo": "lait.jpeg"},
    {"nom": "Charcuteir", "logo": "saucisse1.jpeg"},
  ];
  //
  Details(this.produit) {
    //
    //panierController.listeDeElement.value = box.read('paniers') ?? [];
    Timer(Duration(seconds: 1), () {
      contient.value = favoritController.listeDeElement.contains(produit);
      print(contient.value);
      for (var i = 0; i < panierController.listeDeElement.length; i++) {
        if (panierController.listeDeElement[i]['id'] == produit["id"]) {
          contient.value = true;
        }
      }
      //
      print(contient.value);
      //panierController.listeDeElement.addAll(box.read('paniers') ?? []);
    });
    //
    print("la liste: ${panierController.listeDeElement.value}");
    //paniers.add(produit);
    //box.write('paniers', paniers);
    //
    for (var i = 0; i < panierController.listeDeElement.length; i++) {
      Map e = panierController.listeDeElement.elementAt(i);
      print("le produit: $e");
      if (e["id"] == produit["id"]) {
        // Map p = box.read('${produit["id"]}');
        //print("le produit: $p");
        //produit["nombre"] = p["nombre"];
        nombre.value = int.parse(produit["nombre"]);
        //
        break;
      } else {
        //
        nombre.value = 0;
        produit["nombre"] = "0";
      }
      x++;
    }
    //
    //
  }
  //

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 170,
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
                  //padding: const EdgeInsets.symmetric(horizontal: 10),
                  //margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 120,
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage("assets/${produit['logo']}"),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  //child: Image.asset("assets/${produit['logo']}"),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "${produit['nom']}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
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
                            "4 gm",
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
                              Expanded(
                                flex: 3,
                                child: SizedBox(),
                              ),
                              Expanded(
                                flex: 5,
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
                                          if (nombre.value > 0) {
                                            nombre.value--;
                                            produit["nombre"] =
                                                "${nombre.value}";
                                            //box.write(
                                            //  '${produit["id"]}', produit);
                                          }
                                          if (nombre.value == 0) {
                                            panierController.listeDeElement
                                                .remove(produit);
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
                                        () => Text("${nombre.value}"),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          nombre.value++;
                                          produit["nombre"] = "${nombre.value}";
                                          //box.write('${produit["id"]}',
                                          //  jsonEncode(produit));
                                          bool v = false;
                                          panierController.listeDeElement
                                              .add(produit);
                                          panierController.listeDeElement =
                                              panierController.listeDeElement
                                                  .toSet()
                                                  .toList()
                                                  .obs;

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
                              Expanded(
                                flex: 3,
                                child: SizedBox(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () async {
                        if (!contient.value) {
                          favoritController.listeDeElement.add(produit);
                          favoritController.listeDeElement = favoritController
                              .listeDeElement
                              .toSet()
                              .toList()
                              .obs; //
                          contient.value = true;
                        } else {
                          favoritController.listeDeElement.remove(produit); //
                          contient.value = false;
                          //
                        }
                        //print(favoritController.listeDeElement);
                        print(contient.value);
                        //print(
                        //  favoritController.listeDeElement.contains(produit));
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
        SizedBox(
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
          child: ListView(
            scrollDirection: Axis.horizontal,
            controller: ScrollController(),
            children: List.generate(
              produitS.length,
              (index) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    elevation: 2,
                    child: InkWell(
                      onTap: () {
                        //
                        Get.back();
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
                                                        produitS[index]),
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
                        //padding: const EdgeInsets.symmetric(horizontal: 10),
                        //margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 70,
                        width: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage(
                                "assets/${produitS[index]['logo']}"),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35),
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        //child: Image.asset("assets/${produit['logo']}"),
                      ),
                    ),
                  ),
                  Text("${produitS[index]['nom']}"),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
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
          child: ListView(
            scrollDirection: Axis.horizontal,
            controller: ScrollController(),
            children: List.generate(
              produitC.length,
              (index) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                    elevation: 2,
                    child: InkWell(
                      onTap: () {
                        //
                        Get.back();
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
                                                        produitC[index]),
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
                        //padding: const EdgeInsets.symmetric(horizontal: 10),
                        //margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 70,
                        width: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage(
                                "assets/${produitC[index]['logo']}"),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35),
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        //child: Image.asset("assets/${produit['logo']}"),
                      ),
                    ),
                  ),
                  Text("${produitC[index]['nom']}"),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Card(
          child: TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(
                Colors.red.shade100,
              ),
            ),
            onPressed: () {},
            child: Container(
              width: Get.size.width / 1.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "${produit['devise']} ${produit['price']}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 34,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    child: Text(
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
}
