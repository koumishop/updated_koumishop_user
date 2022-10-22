import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:koumishop/pages/accueil.dart';
import 'package:koumishop/pages/profil/commande/commande.dart';

import 'paiement_mobile.dart';

class PanierController extends GetxController {
  RxList listeDeElement = RxList();
  RxMap adresse = {}.obs;
  RxMap dateL = {}.obs;
  RxString modeP = "".obs;
  paiement(Map<String, String> commande, BuildContext context) async {
    //
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg',
      'Cookie': 'PHPSESSID=3d673c385319a7c1570963dcb99ee8f8'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://webadmin.koumishop.com/api-firebase/order-process.php'));
    request.fields.addAll(commande);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String rep = await response.stream.bytesToString();
      //
      Map map = jsonDecode(rep);
      //
      print(jsonDecode(rep));
      if (map['error']) {
        //Pas d'erreur
        Get.back();
        Get.back();
        Get.back();
        Get.snackbar("Erreur", "${map['message']}");
        //
      } else {
        //
        listeDeElement = RxList();
        adresse = {}.obs;
        dateL = {}.obs;
        modeP = "".obs;
        //
        var box = GetStorage();
        box.write("panier", []);
        //
        Get.back();
        Get.back();
        Get.back();
        Get.off(Accueil(false));
        Get.to(Commande());
        Get.snackbar("Succès", "${map['message']}");
        //
      }
      //
    } else {
      print(response.reasonPhrase);
    }
    //
  }
  //

}

class MessageFinal extends StatelessWidget {
  PanierController panierController = Get.find();
  Map map;
  MessageFinal(this.map) {
    panierController.listeDeElement = RxList();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
          child: Card(
        elevation: 1,
        child: SizedBox(
          height: Get.size.height / 3,
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      color: Colors.red.shade700,
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Get.back();
                        Get.back();
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Félicitation\n",
                        children: [TextSpan(text: '${map['message']}\n')],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
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
                          onPressed: () {
                            //
                            Get.back();
                            Get.to(Commande());
                          },
                          child: SizedBox(
                            height: 50,
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: const Text(
                                "Voir vos commandes",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
