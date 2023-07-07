// ignore_for_file: must_be_immutable, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'menu.dart';
import 'package:koumishop/controllers/menu_controller.dart' as menu;
import 'package:koumishop/components/menu/search.dart';
import 'package:koumishop/controllers/subcategory_controller.dart';
import 'package:koumishop/screens/cart.dart';
import 'package:koumishop/controllers/cart_controller.dart';
import 'package:shimmer/shimmer.dart';

class MainMenu extends StatefulWidget {
  List data;
  int idService;
  MainMenu(this.data, this.idService, {super.key});
  @override
  State<StatefulWidget> createState() {
    return _MainMenu();
  }
}

class _MainMenu extends State<MainMenu> {
  RxInt i = 0.obs;
  int n = 2;
  RxBool load = true.obs;
  menu.MenuController menuController = Get.put(menu.MenuController());
  SubcategoryController subcategoryController =
      Get.put(SubcategoryController());
  CartController cartController = Get.put(CartController());
  Rx vue = Rx(Container);
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

  RxList subcategory = [].obs;
  RxInt subcategoryIndex = 0.obs;


  @override
  void initState() {
    List sc = widget.data[0]["childs"].isNotEmpty
        ? widget.data[0]["childs"].keys.toList()
        : [];
    for (var i = 0; i < sc.length; i++) {}
    loading();
    super.initState();
  }

  loading() async {
    subcategory.value =
        await subcategoryController.getMenu("${widget.data[0]['id']}");
    menuController.itemList.value =
        await menuController.getMenu("${subcategory[0]['id']}");
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
              if (cartController.itemList.isNotEmpty) {
                menuController.showMiniCart.value = true;
              }
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            elevation: 1,
                            child: InkWell(
                              onTap: () {
                                Get.back();
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
                                    Get.to(Recherche(text, widget.idService));
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
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 50,
                            //color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 0),
                              child: InkWell(
                                onTap: () {
                                  Get.to(Cart(this));
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
                                              "${cartController.itemList.length}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
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
                          itemCount: subcategory.length,
                          itemBuilder: (c, index) {
                            return ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  subcategoryIndex.value = index;
                                });
                                load.value = true;
                                menuController.itemList.value =
                                    await menuController
                                        .getMenu("${subcategory[index]['id']}");
                                load.value = false;
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    subcategoryIndex.value == index
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
                                  "${subcategory[index]['name'] ?? ''}",
                                  style: TextStyle(
                                    color: subcategoryIndex.value == index
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
                                      return InkWell(
                                        onTap: () async {
                                          load.value = true;
                                          subcategory.value =
                                              await subcategoryController.getMenu(
                                                  "${widget.data[index]['id']}");
                                          if (subcategory.isNotEmpty) {
                                            menuController.itemList.value =
                                                await menuController.getMenu(
                                                    "${subcategory[0]['id']}");
                                            load.value = false;
                                          } else {
                                            menuController.itemList.value = [];
                                            load.value = false;
                                          }
                                          i.value = index;
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
                                                const SizedBox(
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
                                    : menuController.itemList.value.isEmpty
                                        ? Container(
                                            alignment: Alignment.center,
                                            child: const Text(
                                              "Aucun produit trouvé",
                                            ),
                                          )
                                        : const Menu(),
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
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Shimm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Card(
          elevation: 1,
          color: Colors.grey,
          child: SizedBox(
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
          child: const Card(
            elevation: 1,
            child: SizedBox(
              height: 10,
              width: 100,
            ),
          ),
        ),
      ],
    );
  }
}
