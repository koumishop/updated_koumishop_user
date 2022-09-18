import 'package:get/get.dart';
import 'package:koumishop/pages/menu/details.dart';
import 'package:koumishop/pages/menu/recherche_controller.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Recherche extends GetView<RechercheController> {
  String text;
  Recherche(this.text) {
    controller.getRecherche(text);
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
                                  controller.getRecherche(text);
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
                                  return InkWell(
                                    onTap: () {
                                      //PanierController
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
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.transparent,
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
                                                        child: Container(),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.white,
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
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        Get.back();
                                                                      },
                                                                      icon:
                                                                          Icon(
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
                                                                      EdgeInsets
                                                                          .all(
                                                                              10),
                                                                  child: Details(
                                                                      produit),
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
                                    child: Card(
                                      elevation: 2,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 8,
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
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  Text(
                                                    "${produit['name']}",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${produit['variants'][0]['measurement']} ${produit['variants'][0]['measurement_unit_name']}",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${produit['price']} FC",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // InkWell(
                                                  //   onTap: () {},
                                                  //   child: Container(
                                                  //     height: 20,
                                                  //     width: 20,
                                                  //     alignment: Alignment.center,
                                                  //     decoration: BoxDecoration(
                                                  //       color: Colors.white,
                                                  //       borderRadius: BorderRadius.circular(
                                                  //         10,
                                                  //       ),
                                                  //       border: Border.all(
                                                  //         color: Colors.grey.shade300,
                                                  //       ),
                                                  //     ),
                                                  //     child: Icon(
                                                  //       Icons.remove,
                                                  //       size: 19,
                                                  //       color: Colors.red,
                                                  //     ),
                                                  //   ),
                                                  // ),

                                                  Text(
                                                    "En stock",
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  // InkWell(
                                                  //   onTap: () {},
                                                  //   child: Container(
                                                  //     height: 20,
                                                  //     width: 20,
                                                  //     alignment: Alignment.center,
                                                  //     decoration: BoxDecoration(
                                                  //       color: Colors.red.shade700,
                                                  //       borderRadius: BorderRadius.circular(
                                                  //         10,
                                                  //       ),
                                                  //     ),
                                                  //     child: Icon(
                                                  //       Icons.add,
                                                  //       size: 20,
                                                  //       color: Colors.white,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
