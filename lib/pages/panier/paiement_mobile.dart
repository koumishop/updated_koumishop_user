import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koumishop/pages/panier/panier_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaiementMobileVisa extends StatefulWidget {
  //
  String lien;
  bool visa;
  String lienVisa;
  //
  Map<String, String> commande;
  //
  PaiementMobileVisa(this.lien, this.commande, this.visa, this.lienVisa);
  //
  @override
  _PaiementMobileVisa createState() => _PaiementMobileVisa();
}

class _PaiementMobileVisa extends State<PaiementMobileVisa> {
  //
  WebViewController? webViewController;
  //
  Timer? tm;
  RxInt temps = 0.obs;
  //
  @override
  void initState() {
    //
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();

    //
    temps = widget.visa ? 360.obs : 30.obs;
    if (widget.visa) {
      Timer(
        const Duration(seconds: 1),
        () {
          //
          //Get.snackbar("Test", "Salut!");
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
                          //
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: WebView(
                        initialUrl: widget.lienVisa,
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
    //
    conter();
    //
    super.initState();
    //
  }

  conter() async {
    print("la v: ${temps.value}");
    tm = Timer.periodic(const Duration(seconds: 1), (t) {
      //
      temps.value = temps.value - 1;
      if (temps.value == 0) {
        sendTest();
        //Get.snackbar("Ecoulé", "Salut comment ?");
      }
      print("la valeur: ${t.tick}");
    });
  }

  sendTest() async {
    tm!.cancel();
    //
    showDialog(
        context: context,
        builder: (context) {
          return Material(
            child: Compteur(
                widget.lien, widget.commande, widget.visa, widget.lienVisa),
          );
        });
    //
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.back();
        //contextApp!.
        //stateMenu!.setState(() {});
        return Future.value(false);
      },
      child: Container(
        color: Colors.red, // Status bar color
        child: SafeArea(
          left: false,
          right: false,
          bottom: false,
          child: Scaffold(
            // appBar: AppBar(
            //     leading: IconButton(
            //   onPressed: () {
            //     //
            //     Get.back();
            //     //
            //   },
            //   icon: Icon(
            //     Icons.arrow_back,
            //     color: Colors.black,
            //   ),
            // )),
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
                  // SizedBox(
                  //   height: 50,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       InkWell(
                  //         onTap: () {
                  //           //
                  //           Get.back();
                  //           //Get.back();
                  //           //
                  //         },
                  //         child: Container(
                  //           padding: const EdgeInsets.only(left: 10),
                  //           width: 100,
                  //           height: 40,
                  //           alignment: Alignment.center,
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             children: const [
                  //               Icon(
                  //                 Icons.arrow_back_ios,
                  //                 size: 20,
                  //                 color: Colors.red,
                  //               ),
                  //               Text(
                  //                 "Panier",
                  //                 style: TextStyle(
                  //                   fontSize: 15,
                  //                   color: Colors.red,
                  //                   fontWeight: FontWeight.w500,
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
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
                      padding: EdgeInsets.symmetric(
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
                          //HYYNbQAs1OOt243815824641
                          sendTest();
                          // var headers = {
                          //   'Authorization':
                          //       'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
                          // };
                          // //https://koumishop.com/pay/traitement.ajax.php?phone=243815824641&reference=HYYNbQAs1OOt243815824641
                          // var request = http.MultipartRequest(
                          //     'POST', Uri.parse(widget.lien));
                          // request.fields.addAll({
                          //   'promotion': '1',
                          //   'accesskey': '90336',
                          //   'mobile': '813999922',
                          //   ' type': 'verify-user'
                          // });

                          // request.headers.addAll(headers);

                          // http.StreamedResponse response = await request.send();

                          // if (response.statusCode == 200) {
                          //   String rep = await response.stream.bytesToString();
                          //   Map r = jsonDecode(rep);
                          //   if ("${r['status']}" == "1") {
                          //     //
                          //     Get.snackbar("Erreur", "${r['message']}");
                          //   } else {
                          //     //
                          //     PanierController panierController = Get.find();
                          //     //
                          //     if (widget.visa) {
                          //       // ignore: use_build_context_synchronously
                          //       panierController.paiement(
                          //           widget.commande, context);
                          //     } else {
                          //       // ignore: use_build_context_synchronously
                          //       panierController.paiement(
                          //           widget.commande, context);
                          //     }
                          //     //Get.snackbar("Erreur", "${r['message']}");
                          //   }
                          //   print(rep);
                          // } else {
                          //   print(response.reasonPhrase);
                          // }
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

class Compteur extends StatefulWidget {
  String lien;
  bool visa;
  String lienVisa;
  //
  Map<String, String> commande;
  Compteur(this.lien, this.commande, this.visa, this.lienVisa);

  @override
  State<StatefulWidget> createState() {
    return _Compteur();
  }
}

class _Compteur extends State<Compteur> {
  RxInt seconde = 40.obs;
  RxInt temps = 40.obs;

  Timer? tm;
  PanierController panierController = Get.find();
  RxInt st = 2.obs;

  @override
  void initState() {
    //
    //
    // tm = Timer.periodic(const Duration(seconds: 1), (t) {
    //   //
    //   temps.value = temps.value - 1;
    //   seconde.value = temps.value;
    //   if (temps.value == 0) {
    //     //sendTest();
    //     tm!.cancel();

    //     //Get.snackbar("Ecoulé", "Salut comment ?");
    //   }
    //   print("la valeur: ${t.tick}");
    // });

    //
    checkStatus();
    //
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
                    //
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
                                        //value: 4,
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(
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
                                        const Text("")
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
                              Text("Date: "),
                              Text(
                                "${DateTime.now()}",
                                style: TextStyle(
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
                      children: List.generate(
                          panierController.listeDeElement.length, (index) {
                        //
                        Map produit = panierController.listeDeElement[index];
                        //
                        //print(produit);
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
                              SizedBox(
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
                                      SizedBox(
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
                                      SizedBox(
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
      print("Test et tout!");
      var headers = {
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
      };
      //https://koumishop.com/pay/traitement.ajax.php?phone=243815824641&reference=HYYNbQAs1OOt243815824641
      var request = http.MultipartRequest('POST', Uri.parse(widget.lien));
      request.fields.addAll({
        'promotion': '1',
        'accesskey': '90336',
        'mobile': '813999922',
        ' type': 'verify-user'
      });

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        //Get.back();
        String rep = await response.stream.bytesToString();
        Map r = jsonDecode(rep);

        print("La reponse apres la commande: $r");
        if ("${r['status']}" == "1") {
          st.value = 1;
          Timer(const Duration(seconds: 2), () {
            Get.back();
            Get.back();
            Get.snackbar("Commande", "${r['message']}");
          });
          //

        } else if ("${r['status']}" == "2") {
          st.value = 2;
          Timer(const Duration(seconds: 2), () {
            checkStatus();
            print("En attente...");
          });
          //

        } else if ("${r['status']}" == "3") {
          //checkStatus();
          st.value = 2;
          Timer(const Duration(seconds: 2), () {
            Get.back();
            Get.snackbar("Commande", "${r['message']}");
            print("En attente...");
          });
          //

        } else if ("${r['status']}" == "0") {
          st.value = 0;
          await Timer(const Duration(seconds: 2), () {
            //
            PanierController panierController = Get.find();
            //
            if (widget.visa) {
              // ignore: use_build_context_synchronously
              panierController.paiement(widget.commande, context);
            } else {
              // ignore: use_build_context_synchronously
              panierController.paiement(widget.commande, context);
            }
          });
          //Get.snackbar("Erreur", "${r['message']}");
        }
        print(rep);
      } else {
        Get.back();
        Get.back();
        Get.back();
        Get.snackbar("Erreur", "");
        print(response.reasonPhrase);
      }
    });
    //
  }

  @override
  void dispose() {
    tr!.cancel();
    // TODO: implement dispose
    super.dispose();
  }
}
