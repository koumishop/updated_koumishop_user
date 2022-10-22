class Produit {
  //
}

/**
child: controller.obx(
                      (l) {
                        RxList nL = RxList(l!);
                        return ListView(
                          children: List.generate(
                            nL.length,
                            (index) {
                              Map produit = nL[index];
                              //
                              RxInt nombre = 1.obs;
                              print("... $produit");
                              int p = 0;
                              double prix =
                                  double.parse(produit['variants'][0]['price']);
                              //
                              if (produit['variants'][0]['discounted_price'] ==
                                      "" ||
                                  produit['variants'][0]['discounted_price'] ==
                                      "0") {
                                prix = prix +
                                    (prix *
                                        double.parse(
                                            produit['tax_percentage'] ?? "1") /
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
                              //
                              return Card(
                                elevation: 1,
                                child: InkWell(
                                  onTap: () {
                                    print("le produit: $produit");
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    height: 90,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(35),
                                          ),
                                          elevation: 2,
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 0,
                                            ),
                                            height: 70,
                                            width: 70,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    "${produit['image']}"),
                                                fit: BoxFit.cover,
                                              ),
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              border: Border.all(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(5),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        "${produit['name']}",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "FC  ${p}",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        color: Colors
                                                            .grey.shade700,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      (int.parse(produit['variants']
                                                                          [0][
                                                                      'stock']) <=
                                                                  0 ||
                                                              produit['variants']
                                                                          [0][
                                                                      'serve_for'] ==
                                                                  "Sold Out")
                                                          ? 'Epuisé'
                                                          : '',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        color: Colors
                                                            .grey.shade700,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 7,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 5,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Expanded(
                                                          flex: 1,
                                                          child: SizedBox(),
                                                        ),
                                                        Expanded(
                                                          flex: 5,
                                                          child: Container(
                                                            //width: 100,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: int.parse(produit[
                                                                            'variants'][0]
                                                                        [
                                                                        'stock']) >
                                                                    0
                                                                ? Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          if (int.parse(produit['variants'][0]['stock']) <= 0 ||
                                                                              produit['variants'][0]['serve_for'] == "Sold Out") {
                                                                            Get.snackbar("Oups!",
                                                                                "Le stock est épuisé");
                                                                          } else {
                                                                            if (panierController.listeDeElement.isNotEmpty) {
                                                                              menuController.showMiniPanier.value = true;
                                                                            }
                                                                            if (nombre.value >
                                                                                0) {
                                                                              nombre.value--;
                                                                              produit["nombre"] = "${nombre.value}";
                                                                              //
                                                                              for (var i = 0; i < panierController.listeDeElement.length; i++) {
                                                                                if (panierController.listeDeElement[i]['id'] == produit["id"]) {
                                                                                  panierController.listeDeElement[i] = produit;
                                                                                  break;
                                                                                }
                                                                              }
                                                                              panierController.listeDeElement.add(produit);
                                                                              panierController.listeDeElement.value = panierController.listeDeElement.toSet().toList().obs;
                                                                            }
                                                                            if (nombre.value ==
                                                                                0) {
                                                                              panierController.listeDeElement.remove(produit);
                                                                              //
                                                                              var box = GetStorage();
                                                                              box.write("panier", panierController.listeDeElement);
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
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              28,
                                                                          width:
                                                                              28,
                                                                          alignment:
                                                                              Alignment.center,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.white,
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                              14,
                                                                            ),
                                                                            border:
                                                                                Border.all(
                                                                              color: Colors.grey.shade300,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              const Icon(
                                                                            Icons.remove,
                                                                            size:
                                                                                19,
                                                                            color:
                                                                                Colors.red,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Obx(
                                                                        () => (int.parse(produit['variants'][0]['stock']) <= 0 ||
                                                                                produit['variants'][0]['serve_for'] == "Sold Out")
                                                                            ? Text(
                                                                                " epuise ",
                                                                                style: TextStyle(
                                                                                  fontSize: 6,
                                                                                  color: Colors.red.shade700,
                                                                                ),
                                                                              )
                                                                            : Text("${nombre.value}"),
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          if (int.parse(produit['variants'][0]['stock']) <= 0 ||
                                                                              produit['variants'][0]['serve_for'] == "Sold Out") {
                                                                            Get.snackbar("Oups!",
                                                                                "Le stock est épuisé");
                                                                          } else {
                                                                            if (int.parse(produit['variants'][0]['stock']) <=
                                                                                nombre.value) {
                                                                              Get.snackbar("Oups!", "Le stock est épuisé");
                                                                            } else {
                                                                              menuController.showMiniPanier.value = true;
                                                                              nombre.value++;
                                                                              produit["nombre"] = "${nombre.value}";
                                                                              //box.write('${produit["id"]}',
                                                                              //  jsonEncode(produit));
                                                                              bool v = false;
                                                                              //panierController.listeDeElement.
                                                                              for (var i = 0; i < panierController.listeDeElement.length; i++) {
                                                                                if (panierController.listeDeElement[i]['id'] == produit["id"]) {
                                                                                  panierController.listeDeElement[i] = produit;
                                                                                  break;
                                                                                }
                                                                              }
                                                                              panierController.listeDeElement.add(produit);
                                                                              panierController.listeDeElement.value = panierController.listeDeElement.toSet().toList().obs;
                                                                              //
                                                                              var box = GetStorage();
                                                                              box.write("panier", panierController.listeDeElement);
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
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              28,
                                                                          width:
                                                                              28,
                                                                          alignment:
                                                                              Alignment.center,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.red.shade700,
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                              14,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              const Icon(
                                                                            Icons.add,
                                                                            size:
                                                                                20,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : Text(
                                                                    "Epuisé"),
                                                          ),
                                                        ),
                                                        const Expanded(
                                                          flex: 1,
                                                          child: SizedBox(),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Obx(
                                                      () => Text(
                                                        "FC ${p * nombre.value}",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          color: Colors
                                                              .red.shade700,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  //setState(() {
                                                  //nL.removeAt(index);
                                                  supprimerFavoris(
                                                      produit["id"]);
                                                  //
                                                },
                                                icon: const Icon(
                                                  Icons.delete_forever,
                                                  size: 30,
                                                  color: Colors.red,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                      onLoading: const Center(
                          child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.red,
                          strokeWidth: 7,
                        ),
                      )),
                    ),
 */