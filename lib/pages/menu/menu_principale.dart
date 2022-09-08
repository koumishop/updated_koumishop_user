import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koumishop/pages/menu/menu.dart';
import 'package:koumishop/pages/panier/panier.dart';

class MenuPrincipal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MenuPrincipal();
  }
}

class _MenuPrincipal extends State<MenuPrincipal> {
  RxInt i = 0.obs;
  int n = 2;
  //
  List l = [
    "Banane",
    "Choux",
    "Tomate",
    "Lait",
    "Poisson",
    "Beure",
    "Mayonnaise"
  ];
  RxList categories = ["Banane"].obs;
  //
  late Rx vue;
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
  @override
  void initState() {
    vue = Rx(Menu(
      key: UniqueKey(),
    ));
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
          backgroundColor: Color.fromARGB(255, 255, 232, 235),
          body: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 5),
                  height: 55,
                  color: Color.fromARGB(255, 255, 232, 235),
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
                              alignment: Alignment.center,
                              child: const Text(
                                "K",
                                style: TextStyle(fontSize: 30),
                              ),
                            )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Card(
                          child: Container(
                            alignment: Alignment.center,
                            child: const TextField(
                              style: TextStyle(
                                fontSize: 20,
                              ),
                              decoration: InputDecoration(
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
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Align(
                                alignment: Alignment.center,
                                child: Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      //
                                      print("Salut........................");
                                      //
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(builder: (c) {
                                        return Panier();
                                      }));
                                      //Get.to(Panier());
                                      //
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.shopping_cart,
                                      size: 22,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow.shade700,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  //alignment: Alignment.center,
                                  child: InkWell(
                                    onLongPress: () => Get.to(Panier()),
                                    onTap: () {
                                      //
                                      print("Salut........................");
                                      //
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(builder: (c) {
                                        return Panier();
                                      }));
                                      //Get.to(Panier());
                                      //
                                    },
                                    child: Text("100"),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 35,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 232, 235),
                  ),
                  child: Obx(
                    () => ListView(
                      scrollDirection: Axis.horizontal,
                      controller: ScrollController(),
                      children: List.generate(
                        categories.length,
                        (index) => Card(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                            child: Text("${categories[index]}"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.only(top: 3),
                    color: Color.fromARGB(255, 255, 232, 235),
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
                                children: List.generate(
                                  options.length,
                                  (index) => InkWell(
                                    onTap: () {
                                      //
                                      i.value = index;
                                      //
                                      var rng = Random();
                                      int c1 = rng.nextInt(6);
                                      //
                                      categories.clear();
                                      for (var i = 0; i < c1; i++) {
                                        categories.add('${l[i]}');
                                      }
                                      //
                                      vue = Rx(
                                        Menu(
                                          key: UniqueKey(),
                                        ),
                                      );
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: 4,
                                              child: Image.asset(
                                                  "assets/${options[index]['logo']}"),
                                            ),
                                            Expanded(
                                              flex: 7,
                                              child: Center(
                                                child: Text(
                                                  "${options[index]['nom']}",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: i.value == index
                                                        ? Colors.black
                                                        : Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: vue.value,
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
    );
  }
}
