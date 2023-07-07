// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koumishop/controllers/cart_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class VisaMobilePayment extends StatefulWidget {
  String link;
  bool visa;
  String visaLink;
  Map<String, String> order;
  VisaMobilePayment(this.link, this.order, this.visa, this.visaLink,
      {super.key});

  @override
  _VisaMobilePayment createState() => _VisaMobilePayment();
}

class _VisaMobilePayment extends State<VisaMobilePayment> {
  WebViewController? webViewController;
  Timer? tm;
  RxInt temps = 0.obs;

  @override
  void initState() {
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    temps = widget.visa ? 30.obs : 30.obs;
    if (widget.visa) {
      Timer(
        const Duration(seconds: 1),
        () {
          showDialog(
            context: context,
            builder: (c) {
              return Material(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: WebView(
                        initialUrl: widget.visaLink,
                        javascriptMode: JavascriptMode.unrestricted,
                      ),
                    )
                  ],
                ),
              );
            },
          );
          //
        },
      );
    }
    conter();
    super.initState();
    //
  }

  conter() async {
    tm = Timer.periodic(const Duration(seconds: 1), (t) {
      //
      temps.value = temps.value - 1;
      if (temps.value == 0) {
        sendTest();
      }
    });
  }

  sendTest() async {
    tm!.cancel();
    showDialog(
        context: context,
        builder: (context) {
          return Material(
            child: Compteur(
                widget.link, widget.order, widget.visa, widget.visaLink),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back();
        return Future.value(false);
      },
      child: Container(
        color: Colors.red,
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
                  Expanded(
                    flex: 3,
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "La vérification de votre paiement se fera dans ",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Obx(
                            () => Text(
                              "${temps.value} s",
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Text(
                            "Mais vous pouvez aussi une foi le paiement éffectué lancer la vérification",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      alignment: Alignment.center,
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
                          sendTest();
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text(
                            "Vérification",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
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
      ),
    );
  }

  @override
  void dispose() {
    //
    tm!.cancel();
    //
    super.dispose();
  }
}

// ignore: must_be_immutable
class Compteur extends StatefulWidget {
  String link;
  bool visa;
  String visaLink;
  //
  Map<String, String> order;
  Compteur(this.link, this.order, this.visa, this.visaLink, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _Compteur();
  }
}

class _Compteur extends State<Compteur> {
  RxInt seconde = 40.obs;
  RxInt temps = 40.obs;

  Timer? tm;
  CartController cartController = Get.find();
  RxInt st = 2.obs;

  @override
  void initState() {
    checkStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: Colors.red,
                        ),
                        Text(
                          "Détails de la commande",
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
              padding: const EdgeInsets.all(20),
              height: Get.size.height / 2,
              width: Get.size.width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 232, 235),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: st.value == 2
                            ? Container(
                                height: 30,
                                width: 250,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 28,
                                      width: 28,
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.green.shade700,
                                        strokeWidth: 5,
                                      ),
                                    ),
                                    const Text(
                                      "Traitement en cours...",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text("")
                                  ],
                                ),
                              )
                            : st.value == 1
                                ? Container(
                                    height: 35,
                                    width: 250,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            height: 28,
                                            width: 28,
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.red.shade700,
                                            )),
                                        const Text(
                                          "Commande non éffectué",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text("")
                                      ],
                                    ))
                                : Container(
                                    height: 35,
                                    width: 250,
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade700,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 28,
                                          width: 28,
                                          child: Icon(
                                            Icons.check_circle,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "Commande éffectué",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text("")
                                      ],
                                    ),
                                  ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //
                    SizedBox(
                      //height: 80,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("Date: "),
                              Text(
                                "${DateTime.now()}",
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                      color: Colors.red,
                    ),
                    Column(
                      children: List.generate(cartController.itemList.length,
                          (index) {
                        Map produit = cartController.itemList[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          height: 90,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image:
                                            NetworkImage("${produit['image']}"),
                                        fit: BoxFit.contain,
                                      )),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 8,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "${produit['name']} (${produit['variants'][0]['measurement']} ${produit['variants'][0]['measurement_unit_name']})",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Qte: ${produit['nombre']}",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${produit['price']} FC",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    const Divider(
                      height: 1,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Timer? tr;

  checkStatus() async {
    tr = Timer(const Duration(seconds: 10), () async {
      var headers = {
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
      };
      var request = http.MultipartRequest('POST', Uri.parse(widget.link));
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
        Map r = jsonDecode(rep);
        if ("${r['status']}" == "1") {
          st.value = 1;
          Timer(const Duration(seconds: 2), () {
            Get.back();
            Get.back();
            Get.snackbar("Commande", "${r['message']}");
          });
        } else if ("${r['status']}" == "2") {
          st.value = 2;
          Timer(const Duration(seconds: 2), () {
            checkStatus();
          });
        } else if ("${r['status']}" == "3") {
          st.value = 2;
          Timer(const Duration(seconds: 2), () {
            Get.back();
            Get.snackbar("Commande", "${r['message']}");
          });
        } else if ("${r['status']}" == "0") {
          st.value = 0;
          Timer(const Duration(seconds: 2), () {
            CartController cartController = Get.find();
            if (widget.visa) {
              // ignore: use_build_context_synchronously
              cartController.paiement(widget.order, context);
            } else {
              // ignore: use_build_context_synchronously
              cartController.paiement(widget.order, context);
            }
          });
        }
      } else {
        Get.back();
        Get.back();
        Get.back();
        Get.snackbar("Erreur", "");
      }
    });
  }

  @override
  void dispose() {
    tr!.cancel();
    super.dispose();
  }
}
