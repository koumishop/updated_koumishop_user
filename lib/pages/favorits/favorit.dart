import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/pages/accueil.dart';
import 'package:koumishop/controllers/menu_controller.dart' as menu;
import 'package:koumishop/pages/panier/panier_controller.dart';
import 'package:koumishop/pages/profil/profil_controller.dart';
import 'favorit_controller.dart';

class Favorit extends GetView<FavoritController> {
  FavoritController favoritController = Get.find();
  //ProfilController profilController = Get.find();
  //favoritController
  RxBool load = true.obs;
  //
  var box = GetStorage();
  //
  List listeE = [];
  //
  RxList nL = [].obs;
  //
  checkProduits(String ps) async {
    //
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://webadmin.koumishop.com/api-firebase/get-products.php'));
    request.fields.addAll({
      'product_verification': '1',
      'product_ids': "$ps",
      'accesskey': '90336'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String rep = await response.stream.bytesToString();
      Map r = jsonDecode(rep);

      if (!r['error']) {
        List ln = r['data'];
        //print('liste0: $ln');
        for (var i = 0; i < ln.length; i++) {
          //print('liste1: $i');
          for (var x = 0; x < listeE.length; x++) {
            //print(
            //  'liste2: $x == ${listeE[x]['product_variant_id'] == ln[i]['id']}');
            //print(
            //  'liste2: $x == ${listeE[x]['product_variant_id']} == ${ln[i]['id']}');
            if (listeE[x]['id'] == ln[i]['id']) {
              listeE[x]['id'] = ln[i]['id'];
              listeE[x]['price'] = ln[i]['price'];
              listeE[x]['stock'] = ln[i]['stock'];
              listeE[x]['serve_for'] = ln[i]['serve_for'];
              if (int.parse(listeE[x]['nombre']) > int.parse(ln[i]['stock'])) {
                listeE[x]['nombre'] = "1";
              }
              //nL.add(listeE[x]);
            }
          }
        }
        //
        //loading();
        //
        //print('liste3: $nL');
      }

      //print(r);
      load.value = false;
    } else {
      //print(response.reasonPhrase);
      load.value = false;
    }
  }

  //
  Favorit() {
    //Timer(Duration(seconds: 1), () {
    loading();
    //});
    //
    //print("Cool!...");
  }

  loading() async {
    //
    controller.checkProduits();
    //
  }

  //
  PanierController panierController = Get.find();
  List listeProduit = [];
  ProfilController profilController = Get.find();
  menu.MenuController menuController = Get.find();
  //
  @override
  Widget build(BuildContext context) {
    loading();
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
                                "Accueil",
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
                    child: controller.obx(
                      (l) {
                        RxList nL = RxList(l!);
                        return ListView(
                          children: List.generate(
                            controller.listeDeElement.length,
                            (index) {
                              Map produit = controller.listeDeElement[index];
                              //
                              String idR = produit["product_id"];
                              produit["id"] = produit["product_id"];
                              //RxInt nombre = 0.obs;
                              RxInt nombre =
                                  getNombreProduitByListePanier(produit["id"])
                                      .obs;
                              //RxInt(int.parse(
                              //  controller.listeDeElement[index]["nombre"]));
                              RxInt p = 0.obs;
                              //double prix = double.parse(produit['price']);
                              //
                              //print("... $produit");
                              // print('truc:--------');
                              //int p = 0;
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
                                            produit['tax_percentage']) /
                                        100);
                                p.value = prix.round();
                              } else {
                                prix = double.parse(produit['variants'][0]
                                        ['discounted_price']) +
                                    (double.parse(produit['variants'][0]
                                            ['discounted_price']) *
                                        double.parse(
                                            produit['tax_percentage']) /
                                        100);
                                p.value = prix.round();
                              }
                              //
                              p.value = prix.round();
                              RxString epuise = "epuise".obs;
                              //
                              return Card(
                                elevation: 1,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 15,
                                    top: 5,
                                  ),
                                  height: 115,
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
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
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
                                                    "FC  ${p.value}",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade700,
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
                                                    '${produit['variants'][0]['measurement']} ${produit['variants'][0]['measurement_unit_name']}',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade700,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  int.parse(produit['variants']
                                                                      [0]
                                                                  ['stock']) <=
                                                              0 ||
                                                          produit['variants'][0]
                                                                  [
                                                                  'serve_for'] ==
                                                              "Sold Out"
                                                      ? Text(
                                                          'Epuisé',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey.shade700,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        )
                                                      : Container(),
                                                ],
                                              ),
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
                                                  child: Obx(
                                                    () => Text(
                                                      "FC ${p.value * (nombre.value == 0 ? 1 : nombre.value)}",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        color:
                                                            Colors.red.shade700,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      width: 100,
                                                      height: 30,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.red),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child:
                                                          // int.parse(produit[
                                                          //                 'variants']
                                                          //             [0]['stock']) >
                                                          //         0
                                                          //     ?
                                                          Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              if (int.parse(produit['variants']
                                                                              [
                                                                              0]
                                                                          [
                                                                          'stock']) <=
                                                                      0 ||
                                                                  produit['variants']
                                                                              [
                                                                              0]
                                                                          [
                                                                          'serve_for'] ==
                                                                      "Sold Out") {
                                                                Get.snackbar(
                                                                    "Oups!",
                                                                    "Le stock est épuisé");
                                                              } else {
                                                                if (panierController
                                                                    .listeDeElement
                                                                    .isNotEmpty) {
                                                                  menuController
                                                                      .showMiniCart
                                                                      .value = true;
                                                                }
                                                                if (nombre
                                                                        .value >
                                                                    0) {
                                                                  nombre
                                                                      .value--;
                                                                  produit["nombre"] =
                                                                      "${nombre.value}";
                                                                  //
                                                                  bool v =
                                                                      false;
                                                                  //panierController.listeDeElement.
                                                                  for (var i =
                                                                          0;
                                                                      i <
                                                                          panierController
                                                                              .listeDeElement
                                                                              .length;
                                                                      i++) {
                                                                    if (panierController.listeDeElement[i]
                                                                            [
                                                                            'product_id'] ==
                                                                        produit[
                                                                            "id"]) {
                                                                      panierController.listeDeElement[i]
                                                                              [
                                                                              "nombre"] =
                                                                          "${nombre.value}";
                                                                      v = true;
                                                                    }
                                                                  }
                                                                  if (!v) {
                                                                    panierController
                                                                        .listeDeElement
                                                                        .add(
                                                                            produit);
                                                                  }
                                                                  //panierController.listeDeElement.add(produit);
                                                                  panierController
                                                                          .listeDeElement
                                                                          .value =
                                                                      panierController
                                                                          .listeDeElement
                                                                          .toSet()
                                                                          .toList()
                                                                          .obs;
                                                                }
                                                                if (nombre
                                                                        .value ==
                                                                    0) {
                                                                  panierController
                                                                      .listeDeElement
                                                                      .remove(
                                                                          produit);
                                                                  //
                                                                  var box =
                                                                      GetStorage();
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
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  14,
                                                                ),
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300,
                                                                ),
                                                              ),
                                                              child: const Icon(
                                                                Icons.remove,
                                                                size: 19,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                          Obx(
                                                            () => (int.parse(produit['variants'][0]
                                                                            [
                                                                            'stock']) <=
                                                                        0 ||
                                                                    produit['variants'][0]
                                                                            [
                                                                            'serve_for'] ==
                                                                        "Sold Out")
                                                                ? Text(
                                                                    " $epuise",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          6,
                                                                      color: Colors
                                                                          .red
                                                                          .shade700,
                                                                    ),
                                                                  )
                                                                : Text(
                                                                    "${nombre.value}"),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              if (int.parse(produit['variants']
                                                                              [
                                                                              0]
                                                                          [
                                                                          'stock']) <=
                                                                      0 ||
                                                                  produit['variants']
                                                                              [
                                                                              0]
                                                                          [
                                                                          'serve_for'] ==
                                                                      "Sold Out") {
                                                                Get.snackbar(
                                                                    "Oups!",
                                                                    "Le stock est épuisé");
                                                              } else {
                                                                if (int.parse(produit[
                                                                            'variants'][0]
                                                                        [
                                                                        'stock']) <=
                                                                    nombre
                                                                        .value) {
                                                                  Get.snackbar(
                                                                      "Oups!",
                                                                      "Le stock est épuisé");
                                                                } else {
                                                                  menuController
                                                                      .showMiniCart
                                                                      .value = true;
                                                                  nombre
                                                                      .value++;
                                                                  produit["nombre"] =
                                                                      "${nombre.value}";
                                                                  //box.write('${produit["id"]}',
                                                                  //  jsonEncode(produit));
                                                                  bool v =
                                                                      false;
                                                                  produit["id"] =
                                                                      produit[
                                                                          "product_id"];
                                                                  //panierController.listeDeElement.
                                                                  for (var i =
                                                                          0;
                                                                      i <
                                                                          panierController
                                                                              .listeDeElement
                                                                              .length;
                                                                      i++) {
                                                                    if (panierController.listeDeElement[i]
                                                                            [
                                                                            'id'] ==
                                                                        produit[
                                                                            "id"]) {
                                                                      panierController.listeDeElement[i]
                                                                              [
                                                                              "nombre"] =
                                                                          "${nombre.value}";
                                                                      v = true;
                                                                    }
                                                                  }
                                                                  if (!v) {
                                                                    panierController
                                                                        .listeDeElement
                                                                        .add(
                                                                            produit);
                                                                  }
                                                                  //
                                                                  panierController
                                                                          .listeDeElement
                                                                          .value =
                                                                      panierController
                                                                          .listeDeElement
                                                                          .toSet()
                                                                          .toList()
                                                                          .obs;
                                                                  //
                                                                  var box =
                                                                      GetStorage();
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
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .red
                                                                    .shade700,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  14,
                                                                ),
                                                              ),
                                                              child: const Icon(
                                                                Icons.add,
                                                                size: 20,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                      //: Text("Epuisé"),
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
                                                listeE =
                                                    box.read("favoris") ?? [];
                                                for (var i = 0;
                                                    i < listeE.length;
                                                    i++) {
                                                  if (listeE[i]['id'] ==
                                                      produit['id']) {
                                                    listeE.removeAt(i);
                                                  }
                                                }
                                                //
                                                box.write("favoris", listeE);
                                                //
                                                //nL.removeAt(index);
                                                //
                                                print(idR);
                                                print(produit["id"]);
                                                supprimerFavoris(idR);
                                                //

                                                listeE =
                                                    box.read("favoris") ?? [];
                                                //
                                                for (var i = 0;
                                                    i < listeE.length;
                                                    i++) {
                                                  if (produit['id'] ==
                                                          listeE[i]['id'] ||
                                                      produit['id'] ==
                                                          listeE[i]['id']) {
                                                    listeE.removeAt(i);
                                                  }
                                                }
                                                //
                                                box.write("favoris", listeE);
                                                listeE =
                                                    listeE.toSet().toList();
                                                List<int> lcheck = [];
                                                //checkProduits();
                                                for (var i = 0;
                                                    i < listeE.length;
                                                    i++) {
                                                  lcheck.add(int.parse(
                                                      listeE[i]['id']));
                                                }
                                                String t = jsonEncode(lcheck);
                                                //print(t);

                                                //widget.listeC.value = box.read("panier");
                                                // box.write(
                                                //     "panier",
                                                //     panierController
                                                //         .listeDeElement);
                                                //});
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
                              );
                            },
                          ),
                        );
                      },
                      onEmpty: Container(),
                      onLoading: const Center(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.red,
                            strokeWidth: 7,
                          ),
                        ),
                      ),
                    ),
                    //  Obx(
                    //   () => load.value
                    //       ? const Center(
                    //           child: SizedBox(
                    //             height: 50,
                    //             width: 50,
                    //             child: CircularProgressIndicator(
                    //               backgroundColor: Colors.red,
                    //               strokeWidth: 7,
                    //             ),
                    //           ),
                    //         )
                    //       : ListView(
                    //           children: List.generate(
                    //             nL.length,
                    //             (index) {
                    //               Map produit = nL[index];
                    //               //
                    //               RxInt nombres =
                    //                   RxInt(int.parse(nL[index]["nombre"]));
                    //               RxInt p = 0.obs;
                    //               double prix = double.parse(produit['price']);
                    //               //
                    //               p.value = prix.round();
                    //               //
                    //               return Container(
                    //                 margin: const EdgeInsets.only(bottom: 15),
                    //                 height: 90,
                    //                 child: Row(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.spaceBetween,
                    //                   children: [
                    //                     Card(
                    //                       shape: RoundedRectangleBorder(
                    //                         borderRadius:
                    //                             BorderRadius.circular(35),
                    //                       ),
                    //                       elevation: 2,
                    //                       child: Container(
                    //                         margin: const EdgeInsets.symmetric(
                    //                           horizontal: 0,
                    //                         ),
                    //                         height: 70,
                    //                         width: 70,
                    //                         alignment: Alignment.center,
                    //                         decoration: BoxDecoration(
                    //                           image: DecorationImage(
                    //                             image: NetworkImage(
                    //                                 "${produit['image']}"),
                    //                             fit: BoxFit.cover,
                    //                           ),
                    //                           color: Colors.white,
                    //                           borderRadius:
                    //                               BorderRadius.circular(35),
                    //                           border: Border.all(
                    //                             color: Colors.white,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     Expanded(
                    //                       flex: 4,
                    //                       child: Container(
                    //                         alignment: Alignment.centerLeft,
                    //                         child: Column(
                    //                           children: [
                    //                             Row(
                    //                               mainAxisAlignment:
                    //                                   MainAxisAlignment.start,
                    //                               children: [
                    //                                 Expanded(
                    //                                   flex: 1,
                    //                                   child: Text(
                    //                                     "${produit['name']}",
                    //                                     maxLines: 2,
                    //                                     overflow: TextOverflow
                    //                                         .ellipsis,
                    //                                     style: const TextStyle(
                    //                                       color: Colors.black,
                    //                                       fontSize: 20,
                    //                                       fontWeight:
                    //                                           FontWeight.w500,
                    //                                     ),
                    //                                   ),
                    //                                 )
                    //                               ],
                    //                             ),
                    //                             Row(
                    //                               mainAxisAlignment:
                    //                                   MainAxisAlignment.start,
                    //                               children: [
                    //                                 Text(
                    //                                   "FC  ${p.value}",
                    //                                   textAlign: TextAlign.left,
                    //                                   style: TextStyle(
                    //                                     color: Colors
                    //                                         .grey.shade700,
                    //                                     fontSize: 15,
                    //                                     fontWeight:
                    //                                         FontWeight.w300,
                    //                                   ),
                    //                                 ),
                    //                               ],
                    //                             ),
                    //                             Row(
                    //                               mainAxisAlignment:
                    //                                   MainAxisAlignment.start,
                    //                               children: [
                    //                                 Text(
                    //                                   (int.parse(produit[
                    //                                                   'stock']) <=
                    //                                               0 ||
                    //                                           produit['serve_for'] ==
                    //                                               "Sold Out")
                    //                                       ? 'Epuisé'
                    //                                       : '',
                    //                                   textAlign: TextAlign.left,
                    //                                   style: TextStyle(
                    //                                     color: Colors
                    //                                         .grey.shade700,
                    //                                     fontSize: 15,
                    //                                     fontWeight:
                    //                                         FontWeight.w300,
                    //                                   ),
                    //                                 ),
                    //                               ],
                    //                             )
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     Expanded(
                    //                       flex: 7,
                    //                       child: Container(
                    //                         alignment: Alignment.centerLeft,
                    //                         child: Column(
                    //                           mainAxisAlignment:
                    //                               MainAxisAlignment.start,
                    //                           children: [
                    //                             Expanded(
                    //                               flex: 5,
                    //                               child: Container(
                    //                                 alignment: Alignment.center,
                    //                                 child: Row(
                    //                                   mainAxisAlignment:
                    //                                       MainAxisAlignment
                    //                                           .center,
                    //                                   children: [
                    //                                     const Expanded(
                    //                                       flex: 1,
                    //                                       child: SizedBox(),
                    //                                     ),
                    //                                     Expanded(
                    //                                       flex: 5,
                    //                                       child: Container(
                    //                                         //width: 100,
                    //                                         alignment: Alignment
                    //                                             .center,
                    //                                         decoration:
                    //                                             BoxDecoration(
                    //                                           borderRadius:
                    //                                               BorderRadius
                    //                                                   .circular(
                    //                                                       20),
                    //                                         ),
                    //                                         child: int.parse(
                    //                                                     produit[
                    //                                                         'stock']) >
                    //                                                 0
                    //                                             ? Row(
                    //                                                 mainAxisAlignment:
                    //                                                     MainAxisAlignment
                    //                                                         .spaceBetween,
                    //                                                 children: [
                    //                                                   InkWell(
                    //                                                     onTap:
                    //                                                         () {
                    //                                                       // int t = int.parse(
                    //                                                       //     produit[
                    //                                                       //         'nombre']);

                    //                                                       if (nombres >
                    //                                                           1) {
                    //                                                         nombres =
                    //                                                             nombres - 1;
                    //                                                         //setState(() {
                    //                                                         nL[index]["nombre"] =
                    //                                                             "$nombres";
                    //                                                         //});
                    //                                                       } else {
                    //                                                         //setState(() {
                    //                                                         nL.removeAt(index);
                    //                                                         //});
                    //                                                       }
                    //                                                       //
                    //                                                     },
                    //                                                     child:
                    //                                                         Container(
                    //                                                       height:
                    //                                                           26,
                    //                                                       width:
                    //                                                           26,
                    //                                                       alignment:
                    //                                                           Alignment.center,
                    //                                                       decoration:
                    //                                                           BoxDecoration(
                    //                                                         color:
                    //                                                             Colors.white,
                    //                                                         borderRadius:
                    //                                                             BorderRadius.circular(
                    //                                                           13,
                    //                                                         ),
                    //                                                         border:
                    //                                                             Border.all(
                    //                                                           color: Colors.grey.shade300,
                    //                                                         ),
                    //                                                       ),
                    //                                                       child:
                    //                                                           const Icon(
                    //                                                         Icons.remove,
                    //                                                         size:
                    //                                                             17,
                    //                                                         color:
                    //                                                             Colors.red,
                    //                                                       ),
                    //                                                     ),
                    //                                                   ),
                    //                                                   Obx(
                    //                                                     () =>
                    //                                                         Text(
                    //                                                       "$nombres",
                    //                                                       style:
                    //                                                           const TextStyle(
                    //                                                         color:
                    //                                                             Colors.black,
                    //                                                         fontSize:
                    //                                                             15,
                    //                                                         fontWeight:
                    //                                                             FontWeight.bold,
                    //                                                       ),
                    //                                                     ),
                    //                                                   ),
                    //                                                   InkWell(
                    //                                                     onTap:
                    //                                                         () {
                    //                                                       //int t = int.parse(
                    //                                                       //  produit[
                    //                                                       //    'nombre']);
                    //                                                       if (int.parse(produit['stock']) >
                    //                                                           nombres.value) {
                    //                                                         nombres =
                    //                                                             nombres + 1;
                    //                                                         print(nombres);
                    //                                                         //p.value++;
                    //                                                         //setState(() {
                    //                                                         nL[index]["nombre"] =
                    //                                                             "$nombres";
                    //                                                         //});
                    //                                                         //
                    //                                                       } else {
                    //                                                         Get.snackbar("Stock",
                    //                                                             "Le stock est limité");
                    //                                                       }
                    //                                                     },
                    //                                                     child:
                    //                                                         Container(
                    //                                                       height:
                    //                                                           26,
                    //                                                       width:
                    //                                                           26,
                    //                                                       alignment:
                    //                                                           Alignment.center,
                    //                                                       decoration:
                    //                                                           BoxDecoration(
                    //                                                         color:
                    //                                                             Colors.red.shade700,
                    //                                                         borderRadius:
                    //                                                             BorderRadius.circular(
                    //                                                           13,
                    //                                                         ),
                    //                                                       ),
                    //                                                       child:
                    //                                                           Icon(
                    //                                                         Icons.add,
                    //                                                         size:
                    //                                                             17,
                    //                                                         color:
                    //                                                             Colors.white,
                    //                                                       ),
                    //                                                     ),
                    //                                                   ),
                    //                                                 ],
                    //                                               )
                    //                                             : Text(
                    //                                                 "Epuisé"),
                    //                                       ),
                    //                                     ),
                    //                                     const Expanded(
                    //                                       flex: 1,
                    //                                       child: SizedBox(),
                    //                                     )
                    //                                   ],
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                             Expanded(
                    //                               flex: 4,
                    //                               child: Container(
                    //                                 alignment: Alignment.center,
                    //                                 child: Obx(
                    //                                   () => Text(
                    //                                     "FC ${p.value * nombres.value}",
                    //                                     textAlign:
                    //                                         TextAlign.left,
                    //                                     style: TextStyle(
                    //                                       color: Colors
                    //                                           .red.shade700,
                    //                                       fontSize: 15,
                    //                                       fontWeight:
                    //                                           FontWeight.w500,
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     Expanded(
                    //                       flex: 2,
                    //                       child: Column(
                    //                         mainAxisAlignment:
                    //                             MainAxisAlignment.start,
                    //                         children: [
                    //                           IconButton(
                    //                             onPressed: () {
                    //                               //setState(() {
                    //                               nL.removeAt(index);
                    //                               //
                    //                               //widget.listeC.value = box.read("panier");
                    //                               // box.write(
                    //                               //     "panier",
                    //                               //     panierController
                    //                               //         .listeDeElement);
                    //                               //});
                    //                             },
                    //                             icon: const Icon(
                    //                               Icons.delete_forever,
                    //                               size: 30,
                    //                               color: Colors.red,
                    //                             ),
                    //                           )
                    //                         ],
                    //                       ),
                    //                     )
                    //                   ],
                    //                 ),
                    //               );
                    //             },
                    //           ),
                    //         ),
                    // ),
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
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () async {
          //     //
          //     var headers = {
          //       'Authorization':
          //           'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg',
          //       'Cookie': 'PHPSESSID=12aa9d01877bc697e052e8483dd51afb'
          //     };
          //     var request = http.MultipartRequest(
          //         'POST',
          //         Uri.parse(
          //             'https://webadmin.koumishop.com/api-firebase/get-products.php'));
          //     request.fields.addAll({
          //       'accesskey': '90336',
          //       'subcategory_id': '7',
          //       'offset': '0',
          //       'limit': '100',
          //       'get_all_products': '1',
          //       'user_id': '${profilController.infos['user_id']}'
          //     });

          //     request.headers.addAll(headers);

          //     http.StreamedResponse response = await request.send();

          //     if (response.statusCode == 200) {
          //       print(await response.stream.bytesToString());
          //     } else {
          //       print(response.reasonPhrase);
          //     }

          //     //
          //   },
          //   backgroundColor: Colors.red.shade700,
          //   child: Container(
          //     height: 50,
          //     width: 50,
          //     //color: Colors.white,
          //     child: Padding(
          //       padding: EdgeInsets.only(bottom: 0),
          //       child: Stack(
          //         children: [
          //           Card(
          //             elevation: 1,
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(20),
          //             ),
          //             child: Container(
          //               height: 50,
          //               width: 50,
          //               alignment: Alignment.center,
          //               child: const Icon(
          //                 Icons.shopping_cart,
          //                 color: Colors.red,
          //               ),
          //             ),
          //           ),
          //           Align(
          //             alignment: Alignment.bottomRight,
          //             //width: 10,
          //             //height: 20,

          //             child: Card(
          //               elevation: 0,
          //               child: Container(
          //                 decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(
          //                     3,
          //                   ),
          //                   color: Colors.yellow.shade700,
          //                 ),
          //                 child: Text(
          //                   "${listeProduit.length}",
          //                   style: const TextStyle(
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 17,
          //                   ),
          //                 ),
          //                 // child: Obx(
          //                 //   () => Text(
          //                 //     "${length(panierController.listeDeElement)}",
          //                 //     style: const TextStyle(
          //                 //       fontSize: 11,
          //                 //       fontWeight: FontWeight.bold,
          //                 //     ),
          //                 //   ),
          //                 // ),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }

  int getNombreProduitByListePanier(String id) {
    //
    int n = 0;
    panierController.listeDeElement.forEach((element) {
      //
      //print("${element['id']}" == id);
      //print("$id");
      //print("$element");

      if ("${element['id']}" == id) {
        //print("-----------------------------------------------------1");
        n = int.parse("${element['nombre']}");
      }
    });
    return n;
  }

  supprimerFavoris(String id) async {
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('https://webadmin.koumishop.com/api-firebase/favorites.php'));
    request.fields.addAll({
      'accesskey': '90336',
      'remove_from_favorites': '1',
      'product_id': id,
      'user_id': '${profilController.infos['user_id']}',
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      loading();
      //print(await response.stream.bytesToString());
    } else {
      Get.snackbar("Erreur", "Pas pu supprimer l'historique");
      //print(response.reasonPhrase);
    }
  }
}
