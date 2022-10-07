import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/pages/panier/creno_horaire.dart';
import 'package:koumishop/pages/panier/mode_paiement.dart';
import 'package:koumishop/pages/panier/paiement_mobile.dart';
import 'package:koumishop/pages/panier/panier_controller.dart';
import 'package:koumishop/pages/profil/adresse/adresse_show.dart';
import 'package:koumishop/pages/profil/log/log.dart';
import 'package:koumishop/pages/profil/profil_controller.dart';

class RefaireCommande extends StatefulWidget {
  List listeC;
  RefaireCommande(this.listeC, {Key? key}) : super(key: key);
  //
  @override
  State<StatefulWidget> createState() {
    return _RefaireCommande();
  }
}

class _RefaireCommande extends State<RefaireCommande> {
  //
  PanierController panierController = Get.find();
  ProfilController profilController = Get.find();
  RxList nL = [].obs;
  //
  RxDouble r = 0.0.obs;
  //
  List adresses = [];
  final box = GetStorage();
  //
  //
  @override
  void initState() {
    //
    //r = getTo1();

    nL = widget.listeC.obs;
    //
    Timer(Duration(seconds: 1), () {
      loading();
    });
    //
    super.initState();
  }

  loading() async {
    //
    setState(() {
      r = getTo1();
      print("total: $r");
      //
      adresses = box.read('adresses') ?? [];
    });
  }

  //
  //Map produit = {"nom": "Soupe", "logo": "cuisine2.jpg"};
  //
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red, // Status bar color
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 255, 232, 235),
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
                            children: const [
                              Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: Colors.red,
                              ),
                              Text(
                                "Refaire la commande",
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
                  flex: 4,
                  child: Obx(
                    () => ListView(
                      children: List.generate(
                        nL.length,
                        (index) {
                          Map produit = nL[index];
                          //
                          RxInt nombres =
                              RxInt(int.parse(nL[index]["quantity"]));
                          RxInt p = 0.obs;
                          double prix = double.parse(produit['price']);
                          //
                          if (produit['discounted_price'] == "" ||
                              produit['discounted_price'] == "0") {
                            prix = prix +
                                (prix *
                                    double.parse(produit['tax_percentage']) /
                                    100);
                            p.value = prix.round();
                            //p.value = p.value *
                            //  int.parse(widget.listeC[index]
                            //    ["nombre"]);
                          } else {
                            prix = double.parse(produit['discounted_price']) +
                                (double.parse(produit['discounted_price']) *
                                    double.parse(produit['tax_percentage']) /
                                    100);
                            p.value = prix.round();
                          }
                          //
                          return Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            height: 70,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(35),
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
                                        image:
                                            NetworkImage("${produit['image']}"),
                                        fit: BoxFit.cover,
                                      ),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(35),
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
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500,
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
                                                color: Colors.grey.shade700,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300,
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
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Expanded(
                                                  flex: 1,
                                                  child: SizedBox(),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: Container(
                                                    //width: 100,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            // int t = int.parse(
                                                            //     produit[
                                                            //         'nombre']);

                                                            if (nombres > 1) {
                                                              nombres =
                                                                  nombres - 1;
                                                              setState(() {
                                                                nL[index][
                                                                        "quantity"] =
                                                                    "$nombres";
                                                              });
                                                            } else {
                                                              setState(() {
                                                                nL.removeAt(
                                                                    index);
                                                              });
                                                            }
                                                            //
                                                            r = getTo1();
                                                          },
                                                          child: Container(
                                                            height: 26,
                                                            width: 26,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                13,
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
                                                              size: 17,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                        Obx(
                                                          () => Text(
                                                            "$nombres",
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            //int t = int.parse(
                                                            //  produit[
                                                            //    'nombre']);
                                                            nombres =
                                                                nombres + 1;
                                                            print(nombres);
                                                            //p.value++;
                                                            setState(() {
                                                              nL[index][
                                                                      "quantity"] =
                                                                  "$nombres";
                                                            });
                                                            //
                                                            r = getTo1();
                                                          },
                                                          child: Container(
                                                            height: 26,
                                                            width: 26,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .red.shade700,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                13,
                                                              ),
                                                            ),
                                                            child: Icon(
                                                              Icons.add,
                                                              size: 17,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
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
                                                  color: Colors.red.shade700,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            nL.removeAt(index);
                                            //
                                            r = getTo1();
                                            //widget.listeC.value = box.read("panier");
                                            // box.write(
                                            //     "panier",
                                            //     panierController
                                            //         .listeDeElement);
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
                  flex: 4,
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
                                      Get.to(Log(this));
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (c) {
                                          //return Details();
                                          return Material(
                                            color: Colors.transparent,
                                            child: Center(
                                              child: SizedBox(
                                                height: Get.size.height / 2,
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: AdresseShow(),
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
                                      panierController
                                                  .adresse.value['address'] ==
                                              null
                                          ? "Veuillez sélectionner l'adresse de livraison"
                                          : "${panierController.adresse.value['landmark']} / ${panierController.adresse.value['pincode']} - ${panierController.adresse.value['city']}",
                                      style: TextStyle(fontSize: 11),
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
                                    Map p = box.read("profile") ?? RxMap();
                                    if (p['name'] == null) {
                                      Get.to(Log(this));
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
                                                child: CrenoHoraire(this),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  },
                                  leading: const Icon(
                                    Icons.calendar_month,
                                    color: Colors.red,
                                  ),
                                  title: Obx(
                                    () => Text(
                                      //panierController.dateL.value
                                      panierController.dateL.value['heure'] ==
                                              null
                                          ? "Veuillez sélectionner le jour de livraison"
                                          : "${panierController.dateL.value['date']}  ${panierController.dateL.value['heure']}",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                  ),
                                  trailing: const Icon(
                                    Icons.edit,
                                    color: Colors.red,
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    Map p = box.read("profile") ?? RxMap();
                                    if (p['name'] == null) {
                                      Get.to(Log(this));
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
                                                child: ModePaiement(this),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                    //
                                  },
                                  leading: const Icon(
                                    Icons.payment,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    panierController.modeP.value == ""
                                        ? "Veuillez sélectionner le mode de paiement"
                                        : panierController.modeP.value,
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
                            padding: EdgeInsets.all(10),
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
                                        "${panierController.adresse.value['delivery_charges'] ?? ''} FC",
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
                                        "${int.parse(panierController.adresse.value['delivery_charges'] ?? "0") + r.value} FC",
                                        style: styleDeMenu2(),
                                      ),
                                    ),
                                  ],
                                )
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
                              if (panierController.modeP.value.isEmpty) {
                                Get.snackbar("Erreur",
                                    "Selectionnez le mode de payemant");
                              } else if (panierController
                                      .dateL.value['heure'] ==
                                  null) {
                                Get.snackbar("Erreur",
                                    "Selectionnez la date et l'heure");
                              } else if (panierController
                                      .adresse.value['address'] ==
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
                                  final fcmToken = await FirebaseMessaging
                                      .instance
                                      .getToken();
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
                                        '${profilController.infos['user_id']}'
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
                                      //
                                      List l = [];
                                      nL.forEach((produit) {
                                        //
                                        l.add(produit['id']);
                                      });
                                      //
                                      List ll = [];
                                      nL.forEach((produit) {
                                        //
                                        ll.add(produit['nombre']);
                                      });
                                      Map<String, String> commande = {};
                                      if (panierController.modeP.value ==
                                          "Paiement à la livraison") {
                                        //
                                        commande = {
                                          'order_note': '',
                                          'total': '${r.value}',
                                          'quantity': '$ll',
                                          'delivery_charge':
                                              '${panierController.adresse.value['delivery_charges']}',
                                          'user_id':
                                              '${profilController.infos['user_id']}',
                                          'final_total':
                                              '${int.parse(panierController.adresse.value['delivery_charges']) + r.value}',
                                          'address_id':
                                              '${panierController.adresse.value['id']}',
                                          'place_order': '1',
                                          'wallet_balance': '0.0',
                                          'delivery_time':
                                              '${panierController.dateL.value['date']} - ${panierController.dateL.value['heure']}',
                                          'product_variant_id': '$l',
                                          'payment_method':
                                              panierController.modeP.value,
                                          'accesskey': '90336'
                                        };
                                        //
                                        // ignore: use_build_context_synchronously
                                        panierController.paiement_livraison(
                                            commande, context);
                                        //
                                      } else if (panierController.modeP.value
                                              .split("/")
                                              .first ==
                                          "Mobile money") {
                                        //
                                        commande = {
                                          'order_note': '',
                                          'total': '${r.value}',
                                          'quantity': '$ll',
                                          'delivery_charge':
                                              '${panierController.adresse.value['delivery_charges']}',
                                          'user_id':
                                              '${profilController.infos['user_id']}',
                                          'final_total':
                                              '${int.parse(panierController.adresse.value['delivery_charges']) + r.value}',
                                          'address_id':
                                              '${panierController.adresse.value['id']}',
                                          'place_order': '1',
                                          'wallet_balance': '0.0',
                                          'delivery_time':
                                              '${panierController.dateL.value['date']} - ${panierController.dateL.value['heure']}',
                                          'product_variant_id': '$l',
                                          'payment_method':
                                              panierController.modeP.value,
                                          'accesskey': '90336'
                                        };
                                        //
                                        // ignore: use_build_context_synchronously
                                        Get.to(
                                          PaiementMobile(
                                            "https://koumishop.com/pay/?phone=+243815824641&reference=1664189374560281&amount=1000&currency=CDF",
                                            {},
                                          ),
                                        );
                                      } else {
                                        //
                                        commande = {
                                          'order_note': '',
                                          'total': '${r.value}',
                                          'quantity': '$ll',
                                          'delivery_charge':
                                              '${panierController.adresse.value['delivery_charges']}',
                                          'user_id':
                                              '${profilController.infos['user_id']}',
                                          'final_total':
                                              '${int.parse(panierController.adresse.value['delivery_charges']) + r.value}',
                                          'address_id':
                                              '${panierController.adresse.value['id']}',
                                          'place_order': '1',
                                          'wallet_balance': '0.0',
                                          'delivery_time':
                                              '${panierController.dateL.value['date']} - ${panierController.dateL.value['heure']}',
                                          'product_variant_id': '$l',
                                          'payment_method':
                                              panierController.modeP.value,
                                          'accesskey': '90336'
                                        };
                                        //
                                        Get.to(
                                          PaiementMobile(
                                            "https://koumishop.com/pay/getAwayCard.php?phone=+243815824641&reference=1664189374560271&amount=20&description=payement par visa",
                                            {},
                                          ),
                                        );
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
                                    print(response.reasonPhrase);
                                  }
                                } else {
                                  Get.snackbar(
                                      "Téléphone", "Numéro de téléphone vide.");
                                }
                              }
                              //
                            },
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: const Text(
                                "CONFIRMER LA COMMANDE",
                                style: TextStyle(
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

  RxDouble getTo1() {
    RxDouble x = 0.0.obs;
    RxInt p = 0.obs;
    nL.forEach((produit) {
      //
      double prix = double.parse(produit['price']);

      //
      if (produit['discounted_price'] == "" ||
          produit['discounted_price'] == "0") {
        prix = prix + (prix * double.parse(produit['tax_percentage']) / 100);
        prix = prix * int.parse(produit['quantity']);
        p.value = (p.value + prix.round());
        //p.value = p.value *
        //  int.parse(widget.listeC[index]
        //    ["nombre"]);
      } else {
        prix = double.parse(produit['discounted_price']) +
            (double.parse(produit['discounted_price']) *
                double.parse(produit['tax_percentage']) /
                100);
        //p.value = p.value + prix.round();
        prix = prix * int.parse(produit['quantity']);
        p.value = (p.value + prix.round());
      }
      //
    });
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