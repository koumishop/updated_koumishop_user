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
    temps = widget.visa ? 180.obs : 30.obs;
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
        tm!.cancel();
        //Get.snackbar("Ecoulé", "Salut comment ?");
      }
      print("la valeur: ${t.tick}");
    });
  }

  sendTest() async {
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
      String rep = await response.stream.bytesToString();
      Map r = jsonDecode(rep);
      if ("${r['status']}" == "1") {
        //
        Get.back();
        Get.snackbar("Erreur", "${r['message']}");
      } else {
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
        //Get.snackbar("Erreur", "${r['message']}");
      }
      print(rep);
    } else {
      print(response.reasonPhrase);
    }
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
                SizedBox(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          //
                          Get.back();
                          Get.back();
                          //
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: 100,
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
                                "Panier",
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
/*
WebView(
      initialUrl: widget.lien,
    )
*/