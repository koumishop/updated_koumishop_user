// ignore_for_file: invalid_use_of_protected_member, duplicate_ignore

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/components/cart/time_slots.dart';
import 'package:koumishop/components/cart/payment_method.dart';
import 'package:koumishop/components/cart/mobile_payment.dart';
import 'package:koumishop/controllers/cart_controller.dart';
import 'package:koumishop/components/adress/show_adresses.dart';
import 'package:koumishop/screens/login.dart';
import 'package:koumishop/controllers/profile_controller.dart';

// ignore: must_be_immutable
class OrderAgain extends StatefulWidget {
  List listeC;
  bool f;
  OrderAgain(this.listeC, this.f, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _OrderAgain();
  }
}

class _OrderAgain extends State<OrderAgain> {
  CartController cartController = Get.find();
  ProfilController profilController = Get.find();
  RxList nL = [].obs;
  RxDouble r = 0.0.obs;
  var x = 0.0;
  RxDouble taux = 1.0.obs;
  RxBool load = true.obs;
  List adresses = [];
  final box = GetStorage();
  getTaux() async {
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('https://webadmin.koumishop.com/api-firebase/settings.php'));
    request.fields.addAll(
        {'settings': '1', 'get_payment_methods': '1', 'accesskey': '90336'});

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String rep = await response.stream.bytesToString();
      Map r = jsonDecode(rep);
      taux.value = double.parse(r['daily_rate']);
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }
  }

  @override
  void initState() {
    List<int> lcheck = [];
    for (var i = 0; i < widget.listeC.length; i++) {
      lcheck.add(
          int.parse(widget.listeC[i][widget.f ? 'id' : 'product_variant_id']));
    }
    String t = jsonEncode(lcheck);
    checkProduits(t.substring(1, t.length - 1));

    Timer(const Duration(seconds: 1), () {
      loading();
      getTaux();
    });
    super.initState();
  }

  loading() async {
    setState(() {
      r = widget.f ? getTo2_() : getTo1_();
      adresses = box.read('adresses') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red, // Status bar color
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 232, 235),
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
                          Get.back();
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
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
                                widget.f
                                    ? "Passe la commande"
                                    : "Refaire la commande",
                                style: const TextStyle(
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
                  flex: 4,
                  child: Obx(
                    () => load.value
                        ? const Center(
                            child: SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.red,
                                strokeWidth: 7,
                              ),
                            ),
                          )
                        : ListView(
                            children: List.generate(
                              nL.length,
                              (index) {
                                Map produit = nL[index];
                                //
                                RxInt nombres =
                                    RxInt(int.parse(nL[index]["quantity"]));
                                RxInt p = 0.obs;
                                double prix = double.parse(produit['price']);
                                p.value = prix.round();
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 15),
                                  height: 90,
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
                                          alignment: Alignment.centerLeft,
                                          child: Column(
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
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                    (int.parse(produit[
                                                                    'stock']) <=
                                                                0 ||
                                                            produit['serve_for'] ==
                                                                "Sold Out")
                                                        ? 'Epuisé'
                                                        : '',
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
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          child: int.parse(produit[
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
                                                                        if (nombres >
                                                                            1) {
                                                                          nombres =
                                                                              nombres - 1;
                                                                          setState(
                                                                              () {
                                                                            nL[index]["quantity"] =
                                                                                "$nombres";
                                                                          });
                                                                        } else {
                                                                          setState(
                                                                              () {
                                                                            nL.removeAt(index);
                                                                          });
                                                                        }
                                                                        r = widget.f
                                                                            ? getTo2_()
                                                                            : getTo1_();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            26,
                                                                        width:
                                                                            26,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                            13,
                                                                          ),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.grey.shade300,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .remove,
                                                                          size:
                                                                              17,
                                                                          color:
                                                                              Colors.red,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Obx(
                                                                      () =>
                                                                          Text(
                                                                        "$nombres",
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    InkWell(
                                                                      onTap:
                                                                          () {
                                                                        if (int.parse(produit['stock']) >
                                                                            nombres.value) {
                                                                          nombres =
                                                                              nombres + 1;
                                                                          setState(
                                                                              () {
                                                                            nL[index]["quantity"] =
                                                                                "$nombres";
                                                                          });
                                                                          r = widget.f
                                                                              ? getTo2_()
                                                                              : getTo1_();
                                                                        } else {
                                                                          Get.snackbar(
                                                                              "Stock",
                                                                              "Le stock est limité");
                                                                        }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            26,
                                                                        width:
                                                                            26,
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: Colors
                                                                              .red
                                                                              .shade700,
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                            13,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .add,
                                                                          size:
                                                                              17,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : const Text(
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
                                                      "FC ${p.value * nombres.value}",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        color:
                                                            Colors.red.shade700,
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
                                              MainAxisAlignment.start,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  nL.removeAt(index);
                                                  //
                                                  r = widget.f
                                                      ? getTo2_()
                                                      : getTo1_();
                                                });
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
                                );
                              },
                            ),
                          ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    height: Get.size.height / 2,
                    width: Get.size.width,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 232, 235),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Card(
                            elevation: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ListTile(
                                  onTap: () {
                                    Map p = box.read("profile") ?? RxMap();
                                    if (p['name'] == null) {
                                      Get.to(LoginScreen(this));
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (c) {
                                          return Material(
                                            color: Colors.transparent,
                                            child: Center(
                                              child: SizedBox(
                                                height: Get.size.height / 2,
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 50,
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: ShowAdresses(this),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                    //
                                  },
                                  leading: const Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                  ),
                                  title: Obx(
                                    () => Text(
                                      cartController
                                                  // ignore: invalid_use_of_protected_member
                                                  .adress
                                                  .value['address'] ==
                                              null
                                          ? "Veuillez sélectionner l'adresse de livraison"
                                          // ignore: invalid_use_of_protected_member
                                          : "${cartController.adress.value['landmark']} / ${cartController.adress.value['pincode']} - ${cartController.adress.value['city']}",
                                      style: const TextStyle(fontSize: 11),
                                    ),
                                  ),
                                  trailing: const Icon(
                                    Icons.edit,
                                    color: Colors.red,
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    //
                                    if (cartController
                                            // ignore: invalid_use_of_protected_member
                                            .adress
                                            .value['address'] ==
                                        null) {
                                      Get.snackbar("Erreur",
                                          "Veuillez sélectionner l'adresse de livraison");
                                    } else {
                                      Map p = box.read("profile") ?? RxMap();
                                      if (p['name'] == null) {
                                        Get.to(LoginScreen(this));
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (c) {
                                            return Material(
                                              color: Colors.transparent,
                                              child: Center(
                                                child: Container(
                                                  color: Colors.white,
                                                  height: Get.size.height / 1.2,
                                                  child: TimeSlots(this),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    }
                                  },
                                  leading: const Icon(
                                    Icons.calendar_month,
                                    color: Colors.red,
                                  ),
                                  title: Obx(
                                    () => Text(
                                      // ignore: invalid_use_of_protected_member
                                      cartController.deliveryDate
                                                  .value['heure'] ==
                                              null
                                          ? "Veuillez sélectionner le jour de livraison"
                                          // ignore: invalid_use_of_protected_member
                                          : "${cartController.deliveryDate.value['date']}  ${cartController.deliveryDate.value['heure']}",
                                      style: const TextStyle(fontSize: 11),
                                    ),
                                  ),
                                  trailing: const Icon(
                                    Icons.edit,
                                    color: Colors.red,
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    if (cartController
                                            // ignore: invalid_use_of_protected_member
                                            .adress
                                            .value['address'] ==
                                        null) {
                                      Get.snackbar("Erreur",
                                          "Veuillez sélectionner le jour de livraison");
                                    } else {
                                      Map p = box.read("profile") ?? RxMap();
                                      if (p['name'] == null) {
                                        Get.to(LoginScreen(this));
                                      } else {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (c) {
                                            //return Details();
                                            return Material(
                                              color: Colors.transparent,
                                              child: Center(
                                                child: Container(
                                                  color: Colors.white,
                                                  height: Get.size.height / 2,
                                                  child: PaymentMethod(this),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    }
                                  },
                                  leading: const Icon(
                                    Icons.payment,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    cartController.paymentMethod.value == ""
                                        ? "Veuillez sélectionner le mode de paiement"
                                        : cartController.paymentMethod.value,
                                    style: const TextStyle(fontSize: 11),
                                  ),
                                  trailing: const Icon(
                                    Icons.edit,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Sous total",
                                      style: styleDeMenu(),
                                    ),
                                    Obx(
                                      () => Text(
                                        "$r FC",
                                        style: styleDeMenu2(),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Frais de livraison",
                                      style: styleDeMenu(),
                                    ),
                                    Obx(
                                      () => Text(
                                        // ignore: invalid_use_of_protected_member
                                        "${cartController.adress.value['delivery_charges'] ?? ''} FC",
                                        style: styleDeMenu2(),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Total final",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Obx(
                                      () => Text(
                                        // ignore: invalid_use_of_protected_member
                                        "${int.parse(cartController.adress.value['delivery_charges'] ?? "0") + r.value} FC",
                                        style: styleDeMenu2(),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Obx(
                                      () {
                                        double t = double.parse(cartController
                                                .adress
                                                // ignore: invalid_use_of_protected_member
                                                .value['delivery_charges'] ??
                                            "0");
                                        x = (t + r.value) / taux.value;
                                        return Text(
                                          "\$ ${taux.value != 1 ? x : ''}"
                                              .characters
                                              .getRange(0, 4)
                                              .toString(),
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                Colors.red,
                              ),
                              overlayColor: MaterialStateProperty.all(
                                Colors.red.shade100,
                              ),
                            ),
                            onPressed: () async {
                              //
                              bool v = false;
                              for (var produit in nL) {
                                //
                                if (int.parse(produit['stock']) <= 0 ||
                                    produit['serve_for'] == "Sold Out") {
                                  v = true;
                                }
                              }
                              if (v) {
                                Get.snackbar(
                                  "Stock",
                                  "Vous avez des produits qui ne sont plus en stock veuillez les supprimer.",
                                  duration: const Duration(
                                    seconds: 7,
                                  ),
                                );
                              } else {
                                //
                                if (cartController
                                    .paymentMethod.value.isEmpty) {
                                  Get.snackbar("Erreur",
                                      "Selectionnez le mode de payemant");
                                } else if (cartController
                                        // ignore: invalid_use_of_protected_member
                                        .deliveryDate
                                        .value['heure'] ==
                                    null) {
                                  Get.snackbar("Erreur",
                                      "Selectionnez la date et l'heure");
                                } else if (cartController
                                        // ignore: invalid_use_of_protected_member
                                        .adress
                                        .value['address'] ==
                                    null) {
                                  Get.snackbar("Erreur",
                                      "Selectionnez l'adresse de livraison");
                                } else {
                                  Get.dialog(
                                    const Center(
                                      child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.red,
                                          strokeWidth: 7,
                                        ),
                                      ),
                                    ),
                                  );
                                  //
                                  if (true) {
                                    //
                                    Get.dialog(
                                      const Center(
                                        child: SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: CircularProgressIndicator(
                                            backgroundColor: Colors.red,
                                            strokeWidth: 7,
                                          ),
                                        ),
                                      ),
                                    );
                                    //
                                    var headers = {
                                      'Authorization':
                                          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg',
                                      'Cookie':
                                          'PHPSESSID=3d673c385319a7c1570963dcb99ee8f8'
                                    };
                                    var request = http.MultipartRequest(
                                        'POST',
                                        Uri.parse(
                                            'https://webadmin.koumishop.com/api-firebase/get-user-data.php'));
                                    request.fields.addAll({
                                      'get_user_data': '1',
                                      'accesskey': '90336',
                                      'user_id':
                                          '${profilController.data['user_id']}'
                                    });

                                    request.headers.addAll(headers);

                                    http.StreamedResponse response =
                                        await request.send();

                                    if (response.statusCode == 200) {
                                      String rep =
                                          await response.stream.bytesToString();
                                      Map map = json.decode(rep);
                                      if ("${map['data'][0]['status']}"
                                          .contains("1")) {
                                        List l = [];
                                        for (var produit in nL) {
                                          l.add(produit['id']);
                                        }
                                        List ll = [];
                                        for (var produit in nL) {
                                          ll.add(produit['quantity']);
                                        }
                                        Map<String, String> commande = {};
                                        if (cartController
                                                .paymentMethod.value ==
                                            "Paiement cash") {
                                          commande = {
                                            'order_note': '',
                                            'total': '${r.value}',
                                            'quantity': '$ll',
                                            'delivery_charge':
                                                // ignore: invalid_use_of_protected_member
                                                '${cartController.adress.value['delivery_charges']}',
                                            'user_id':
                                                '${profilController.data['user_id']}',
                                            'final_total':
                                                // ignore: invalid_use_of_protected_member
                                                '${int.parse(cartController.adress.value['delivery_charges']) + r.value}',
                                            'address_id':
                                                '${cartController.adress.value['id']}',
                                            'place_order': '1',
                                            'wallet_balance': '0.0',
                                            'delivery_time':
                                                '${cartController.deliveryDate.value['date']} - ${cartController.deliveryDate.value['heure']}',
                                            'product_variant_id': '$l',
                                            'payment_method': cartController
                                                .paymentMethod.value,
                                            'accesskey': '90336'
                                          };
                                          // ignore: use_build_context_synchronously
                                          cartController.paiement(
                                              commande, context);
                                          //
                                        } else if (cartController
                                                .paymentMethod.value
                                                .split("/")
                                                .first ==
                                            "Mobile money") {
                                          //
                                          commande = {
                                            'order_note': '',
                                            'total': '${r.value}',
                                            'quantity': '$ll',
                                            'delivery_charge':
                                                '${cartController.adress.value['delivery_charges']}',
                                            'user_id':
                                                '${profilController.data['user_id']}',
                                            'final_total': '$x',
                                            'address_id':
                                                '${cartController.adress.value['id']}',
                                            'place_order': '1',
                                            'wallet_balance': '0.0',
                                            'delivery_time':
                                                '${cartController.deliveryDate.value['date']} - ${cartController.deliveryDate.value['heure']}',
                                            'product_variant_id': '$l',
                                            'payment_method': "mobile money",
                                            'accesskey': '90336'
                                          };
                                          sendMobilePayment(
                                              commande,
                                              double.parse(
                                                  commande['final_total']!),
                                              cartController.paymentMethod.value
                                                  .split("/")[1],
                                              false);
                                        } else {
                                          commande = {
                                            'order_note': '',
                                            'total': '${r.value}',
                                            'quantity': '$ll',
                                            'delivery_charge':
                                                '${cartController.adress.value['delivery_charges']}',
                                            'user_id':
                                                '${profilController.data['user_id']}',
                                            'final_total': '$x',
                                            //'${int.parse(cartController.adresse.value['delivery_charges']) + r.value}',
                                            'address_id':
                                                '${cartController.adress.value['id']}',
                                            'place_order': '1',
                                            'wallet_balance': '0.0',
                                            'delivery_time':
                                                '${cartController.deliveryDate.value['date']} - ${cartController.deliveryDate.value['heure']}',
                                            'product_variant_id': '$l',
                                            'payment_method': "visa",
                                            'accesskey': '90336'
                                          };
                                          sendMobilePayment(
                                              commande,
                                              double.parse(
                                                  commande['final_total']!),
                                              "visa",
                                              true);
                                        }

                                        // ignore: use_build_context_synchronously
                                      } else {
                                        Get.back();
                                        Get.snackbar(
                                          "Bloqué",
                                          "Votre status est désactivé",
                                          duration: const Duration(
                                            seconds: 7,
                                          ),
                                        );
                                      }
                                    } else {
                                      if (kDebugMode) {
                                        print(response.reasonPhrase);
                                      }
                                    }
                                    // ignore: dead_code
                                  } else {}
                                }
                                //
                              }
                            },
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                widget.f
                                    ? "PASSER LA COMMANDE"
                                    : "CONFIRMER LA COMMANDE",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
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

  sendMobilePayment(Map<String, String> commande, double montant, String devise,
      bool visa) async {
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
    };
    var numero = profilController.data['mobile'];
    http.MultipartRequest request;
    if (visa) {
      var uxx = getCode();
      Get.to(
        VisaMobilePayment(
          "https://koumishop.com/pay/traitement.ajax.php?phone=243$numero&reference=$uxx}",
          commande,
          visa,
          'https://koumishop.com/pay/getAwayCard.php?phone=+243$numero&reference=$uxx&amount=$montant&description=nom',
        ),
      );
    } else {
      request = http.MultipartRequest('POST', Uri.parse(//815824641
          'https://koumishop.com/pay/?phone=+243$numero&reference=${getCode()}&amount=$montant&currency=$devise'));
      //
      request.fields.addAll({
        'promotion': '1',
        'accesskey': '90336',
        'mobile': '813999922',
        ' type': 'verify-user'
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String rep = await response.stream.bytesToString();
        Map r = json.decode(rep);
        if (r['error']) {
          Get.back();
          Get.snackbar("Erreur", "${r['data']['message']}");
        } else {
          Get.back();
          Get.to(
            VisaMobilePayment(
              "https://koumishop.com/pay/traitement.ajax.php?phone=243$numero&reference=${r['data']['orderNumber']}}",
              commande,
              visa,
              "",
            ),
          );
        }
      } else {
        Get.back();
        Get.snackbar("Erreur", '${response.reasonPhrase}');
      }
    }
  }

  checkProduits(String ps) async {
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://webadmin.koumishop.com/api-firebase/get-products.php'));
    request.fields.addAll(
        {'product_verification': '1', 'product_ids': ps, 'accesskey': '90336'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String rep = await response.stream.bytesToString();
      Map r = jsonDecode(rep);

      if (!r['error']) {
        List ln = r['data'];
        for (var i = 0; i < ln.length; i++) {
          for (var x = 0; x < widget.listeC.length; x++) {
            if (widget.listeC[x][widget.f ? 'id' : 'product_variant_id'] ==
                ln[i]['id']) {
              widget.listeC[x]['id'] = ln[i]['id'];
              widget.listeC[x]['price'] = ln[i]['price'];
              widget.listeC[x]['stock'] = ln[i]['stock'];
              widget.listeC[x]['serve_for'] = ln[i]['serve_for'];
              if (int.parse(
                      widget.listeC[x][widget.f ? 'nombre' : 'quantity']) >
                  int.parse(ln[i]['stock'])) {
                widget.listeC[x]['quantity'] = "1";
              }
              nL.add(widget.listeC[x]);
            }
          }
        }
        loading();
        getTaux();
      }
      load.value = false;
    } else {
      load.value = false;
    }
  }

  String getCode() {
    String n = "";
    var rng = Random();
    for (var i = 0; i < 17; i++) {
      n = "$n${rng.nextInt(9)}";
    }
    return n;
  }

  RxDouble getTo1_() {
    RxDouble x = 0.0.obs;
    RxInt p = 0.obs;
    for (var produit in nL) {
      double prix = double.parse(produit['price']);
      if (produit['discounted_price'] == "" ||
          produit['discounted_price'] == "0") {
        prix = prix + (prix * double.parse(produit['tax_percentage']) / 100);
        prix = prix * int.parse(produit['quantity']);
        p.value = (p.value + prix.round());
      } else {
        prix = double.parse(produit['discounted_price']) +
            (double.parse(produit['discounted_price']) *
                double.parse(produit['tax_percentage']) /
                100);
        prix = prix * int.parse(produit['quantity']);
        p.value = (p.value + prix.round());
      }
    }
    x = (x.value + p.value).obs;
    return x;
  }

  RxDouble getTo2_() {
    RxDouble x = 0.0.obs;
    RxInt p = 0.obs;
    for (var produit in nL) {
      double prix = double.parse(produit['variants'][0]['price']);
      if (produit['variants'][0]['discounted_price'] == "" ||
          produit['variants'][0]['discounted_price'] == "0") {
        prix = prix + (prix * double.parse(produit['tax_percentage']) / 100);
        prix = prix * int.parse(produit['quantity']);
        p.value = (p.value + prix.round());
      } else {
        prix = double.parse(produit['variants'][0]['discounted_price']) +
            (double.parse(produit['variants'][0]['discounted_price']) *
                double.parse(produit['tax_percentage']) /
                100);
        prix = prix * int.parse(produit['quantity']);
        p.value = (p.value + prix.round());
      }
    }
    x = (x.value + p.value).obs;
    return x;
  }

  TextStyle styleDeMenu() {
    return const TextStyle(
      color: Colors.grey,
      fontSize: 13,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle styleDeMenu2() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 17,
      fontWeight: FontWeight.normal,
    );
  }
}
