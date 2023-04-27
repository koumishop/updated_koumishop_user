import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:koumishop/screens/homepage.dart';
import 'package:koumishop/screens/orders.dart';

class CartController extends GetxController {
  RxList itemList = RxList();
  RxMap adress = {}.obs;
  RxMap deliveryDate = {}.obs;
  RxString paymentMethod = "".obs;
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
      Map map = jsonDecode(rep);
      if (map['error']) {
        Get.back();
        Get.back();
        Get.back();
        Get.snackbar("Erreur", "${map['message']}");
      } else {
        itemList = RxList();
        adress = {}.obs;
        deliveryDate = {}.obs;
        paymentMethod = "".obs;
        var box = GetStorage();
        box.write("panier", []);
        Get.back();
        Get.back();
        Get.back();
        Get.off(Homepage(false));
        Get.to(Orders(true));
        Get.snackbar("Succès", "${map['message']}");
      }
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }
  }
}

// ignore: must_be_immutable
class MessageFinal extends StatelessWidget {
  CartController panierController = Get.find();
  Map map;
  MessageFinal(this.map, {super.key}) {
    panierController.itemList = RxList();
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
                            Get.to(Orders(false));
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
