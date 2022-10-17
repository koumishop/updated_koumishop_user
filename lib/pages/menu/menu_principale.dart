import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:koumishop/pages/menu/menu.dart';
import 'package:koumishop/pages/menu/menu_controller.dart';
import 'package:koumishop/pages/menu/recherche.dart';
import 'package:koumishop/pages/menu/sous_categorie.dart';
import 'package:koumishop/pages/menu/sous_categorie_controller.dart';
import 'package:koumishop/pages/panier/panier.dart';
import 'package:koumishop/pages/panier/panier_controller.dart';
import 'package:shimmer/shimmer.dart';

class MenuPrincipal extends StatefulWidget {
  //
  List data;
  //
  MenuPrincipal(this.data);
  //
  @override
  State<StatefulWidget> createState() {
    return _MenuPrincipal();
  }
}

class _MenuPrincipal extends State<MenuPrincipal> {
  RxInt i = 0.obs;
  int n = 2;
  //MenuController menuController = Get.find();
  RxBool load = true.obs;
  //
  MenuController menuController = Get.find();
  //
  SousCategorieController sousCategorieController = Get.find();
  //
  PanierController panierController = Get.find();
  //
  Rx vue = Rx(Container);
  //
  List options = [
    {"nom": "Fruit & légume", "logo": "fruit.jpeg"},
    {"nom": "Boisson", "logo": "jus1.jpeg"},
    {"nom": "Coin pour bébé", "logo": "bebe1.jpeg"},
    {"nom": "Viande", "logo": "viande1.jpeg"},
    {"nom": "Pain", "logo": "pain2.jpeg"},
    {"nom": "Produit laitié", "logo": "lait.jpeg"},
    {"nom": "Charcuteir", "logo": "saucisse1.jpeg"},
    {"nom": "Poisson", "logo": "poisson1.jpeg"},
    {"nom": "Cuisine", "logo": "cuisine1.png"},
    {"nom": "Produit menager", "logo": "menage1.png"},
    {"nom": "Scnack", "logo": "pain1.png"},
  ];
  //
  RxList sousCat = [].obs;
  RxInt sousCatIndex = 0.obs;

  @override
  void dispose() {
    //panierController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  //
  @override
  void initState() {
    //
    //sousCat.value = ;
    //print("ààààààààààà:${widget.data[0]}");
    List sc = widget.data[0]["childs"].isNotEmpty
        ? widget.data[0]["childs"].keys.toList()
        : [];
    //sc.isNotEmpty
    for (var i = 0; i < sc.length; i++) {
      sousCat.add(widget.data[i]["childs"][sc[i]]);
    }
    loading();
    // sc.forEach((element) {
    //   sousCat.add(widget.data[index]["childs"][element]);
    // });
    super.initState();
  }

  loading() async {
    sousCat.value =
        await sousCategorieController.getMenu("${widget.data[0]['id']}");
    //
    menuController.listeProduit.value =
        await menuController.getMenu("${sousCat[0]['id']}");
    load.value = false;
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
          backgroundColor: const Color.fromARGB(255, 255, 232, 235),
          body: RefreshIndicator(
            onRefresh: () async {
              //print("refresh");
              //
              if (panierController.listeDeElement.isNotEmpty) {
                menuController.showMiniPanier.value = true;
              }
              //
              //
              return Future<void>.delayed(const Duration(seconds: 1));
            },
            color: Colors.red,
            child: Container(
              height: Get.size.height,
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
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 5),
                      height: 55,
                      //color: Color.fromARGB(255, 255, 232, 235),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            elevation: 1,
                            child: InkWell(
                              onTap: () {
                                Get.back();
                                // showM.value == 4 ? showM.value = 0 : showM.value = 4;
                                // n == 2 ? n = 3 : n = 2;
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                    image: ExactAssetImage(
                                      "assets/logo_koumi_squared.png",
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
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
                                    Get.to(Recherche(text));
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
                          Container(
                            height: 50,
                            width: 50,
                            //color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 0),
                              child: InkWell(
                                onLongPress: () => Get.to(Panier()),
                                onTap: () {
                                  //
                                  //print(
                                  //  "Salut........................");
                                  //
                                  Get.to(Panier());
                                  //Get.to(Panier());
                                  //
                                },
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
                                          child: Obx(
                                            () => Text(
                                              "${panierController.listeDeElement.length}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                              ),
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
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 40,
                      child: Obx(
                        () => ListView.separated(
                          scrollDirection: Axis.horizontal,
                          controller: ScrollController(),
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              width: 5,
                            );
                          },
                          itemCount: sousCat.length,
                          itemBuilder: (c, index) {
                            return ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  //
                                  sousCatIndex.value = index;
                                  //
                                });
                                //
                                //print("${sousCatIndex.value}");
                                //
                                load.value = true;
                                menuController.listeProduit.value =
                                    await menuController
                                        .getMenu("${sousCat[index]['id']}");

                                load.value = false;
                                // sousCat.value = menuController.getMenu(
                                //     "${sousCat[index]["category_id"]}");
                                // menuController.vue = Rx(
                                //   Menu(
                                //     "${state[index]["category_id"]}",
                                //     key: UniqueKey(),
                                //   ),
                                // );
                                //
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    sousCatIndex.value == index
                                        ? Colors.grey
                                        : Colors.white),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              child: Container(
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  "${sousCat[index]['name'] ?? ''}",
                                  style: TextStyle(
                                    color: sousCatIndex.value == index
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.only(top: 3),
                        //color: Color.fromARGB(255, 255, 232, 235),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Card(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: ListView(
                                    padding: const EdgeInsets.all(10),
                                    controller: ScrollController(),
                                    children: List.generate(widget.data.length,
                                        (index) {
                                      //
                                      //print(
                                      //  "::::::::::${widget.data[index]}");
                                      //
                                      return InkWell(
                                        onTap: () async {
                                          //
                                          // sousCat.clear();
                                          // List sc = widget
                                          //         .data[index]["childs"]
                                          //         .isNotEmpty
                                          //     ? widget.data[index]["childs"]
                                          //         .keys
                                          //         .toList()
                                          //     : [];
                                          //sc.isNotEmpty
                                          load.value = true;
                                          sousCat.value =
                                              await sousCategorieController.getMenu(
                                                  "${widget.data[index]['id']}");
                                          //
                                          if (sousCat.isNotEmpty) {
                                            menuController.listeProduit.value =
                                                await menuController.getMenu(
                                                    "${sousCat[0]['id']}");
                                            load.value = false;
                                            //print(sousCat[0]);
                                          } else {
                                            menuController.listeProduit.value =
                                                [];
                                            load.value = false;
                                          }
                                          //
                                          // listeProduit.value =
                                          //     await menuController.getMenu(
                                          //         "${sousCat[0]['id']}");
                                          //
                                          i.value = index;
                                          //
                                        },
                                        child: Obx(
                                          () => Container(
                                            height: 60,
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 4,
                                                  child: Image.network(
                                                      "${widget.data[index]['image']}"),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  flex: 7,
                                                  child: Text(
                                                    "${widget.data[index]['name']}",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: i.value == index
                                                          ? Colors.black
                                                          : Colors.grey,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Obx(
                                () => load.value
                                    ? Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        direction: ShimmerDirection.ttb,
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                    flex: 4, child: Shimm()),
                                                Expanded(
                                                    flex: 4, child: Shimm()),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                    flex: 4, child: Shimm()),
                                                Expanded(
                                                    flex: 4, child: Shimm()),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                    flex: 4, child: Shimm()),
                                                Expanded(
                                                    flex: 4, child: Shimm()),
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
                                      )
                                    : menuController.listeProduit.value.isEmpty
                                        ? Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Aucun produit trouvé",
                                            ),
                                          )
                                        //menuController.listeProduit
                                        : Menu(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     //
          //   },
          //   child: Obx(
          //     () => Text(
          //       //panierController.listeDeElement
          //       "${length([])}",
          //       style: const TextStyle(
          //         fontSize: 11,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }

  //
  // RxInt length(List l) {
  //   int t = 0;
  //   panierController.listeDeElement.forEach((element) {
  //     t++;
  //   });
  //   print("Salut)))))))");
  //   return t.obs;
  // }

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
