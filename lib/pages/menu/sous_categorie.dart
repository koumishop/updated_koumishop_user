import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koumishop/pages/menu/menus_controller.dart' as menu;
import 'package:shimmer/shimmer.dart';

import 'details.dart';
import 'menu.dart';
import 'sous_categorie_controller.dart';

class SousCategorie extends GetView<SousCategorieController> {
  String id;
  SousCategorie(this.id, {Key? key}) : super(key: key) {
    print("Le menu type...");
    //Timer(const Duration(seconds: 2), () {
    controller.getMenu(id);
    //});
  }
  menu.MenuController menuController = Get.find();
  late RxInt sousCatIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => Container(
        height: 35,
        alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(
            //color: Color.fromARGB(255, 255, 232, 235),
            ),
        child: Obx(
          () => ListView.separated(
            scrollDirection: Axis.horizontal,
            controller: ScrollController(),
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 5,
              );
            },
            itemCount: state!.length,
            itemBuilder: (c, index) {
              return Obx(
                () => ElevatedButton(
                  onPressed: () {
                    //
                    print("${state[index]}");
                    //
                    menuController.getMenu("${state[index]["category_id"]}");
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
                        sousCatIndex == index ? Colors.grey : Colors.white),
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
                      "${state[index]['name']}",
                      style: TextStyle(
                          color: sousCatIndex == index
                              ? Colors.white
                              : Colors.black),
                    ),
                  ),
                ),
              );
            },
          ),
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
      onEmpty: const Center(
        child: Icon(
          Icons.cloud_download_outlined,
          size: 150,
          color: Colors.black,
        ),
      ),
      onError: (erreur) => const Center(
        child: Icon(
          Icons.cloud_download_outlined,
          size: 150,
          color: Colors.black,
        ),
      ),
    );
  }

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
