// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koumishop/main.dart';
import 'package:koumishop/controllers/menu_controller.dart' as menu;
import 'package:koumishop/screens/cart.dart';
import 'package:koumishop/controllers/cart_controller.dart';
import 'package:koumishop/controllers/profile_controller.dart';
import 'package:koumishop/widgets/carte_produit.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _Menu();
  }
}

class _Menu extends State<Menu> {
  CartController cartController = Get.find();
  ProfilController profilController = Get.find();
  menu.MenuController menuController = Get.find();
  RxString epuise = "Epuisé".obs;
  RxDouble btm = 0.0.obs;

  @override
  Widget build(BuildContext context) {
    stateMenu = this;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Obx(
                () => GridView.count(
                  controller: ScrollController(),
                  padding: const EdgeInsets.only(
                    left: 1.5,
                    right: 1.5,
                    bottom: 30,
                  ),
                  crossAxisCount: 2,
                  mainAxisSpacing: 0.1,
                  crossAxisSpacing: 0.1,
                  childAspectRatio: 0.55,
                  children:
                      List.generate(menuController.itemList.length, (index) {
                    Map produit = menuController.itemList[index];
                    return CarteProduit(produit, index);
                  }),
                ),
              ),
            ),
            Obx(
              () => Padding(
                padding: EdgeInsets.only(
                  bottom: menuController.showMiniCart.value
                      ? Get.size.height / 4
                      : 0,
                ),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Obx(
        () => menuController.showMiniCart.value
            ? BottomSheet(
                onClosing: () {},
                clipBehavior: Clip.none,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                builder: (c) {
                  return Container(
                    height: Get.size.height / 4,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 0,
                            right: 0,
                            bottom: 50,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Obx(
                              () => ListView(
                                padding: const EdgeInsets.only(
                                  top: 13,
                                  left: 10,
                                  right: 10,
                                  bottom: 10,
                                ),
                                children: List.generate(
                                  cartController.itemList.length,
                                  (index) {
                                    Map produit =
                                        cartController.itemList[index];
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 5),
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
                                            "${produit['name']}".length >= 10
                                                ? "${"${produit['name']}".characters.getRange(0, 8).string}..."
                                                : "${produit['name']}",
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
                                menuController.showMiniCart.value = false;
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
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 30,
                            left: 25,
                            right: 25,
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: InkWell(
                              onTap: () {
                                menuController.showMiniCart.value = false;
                                Get.to(Cart(this));
                              },
                              child: Container(
                                height: 35,
                                //width: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.red.shade700,
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  ),
                                ),
                                child: const Text(
                                  "Passer la commande",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
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
            : const SizedBox(
                height: 0,
                width: 0,
              ),
      ),
    );
  }
}
