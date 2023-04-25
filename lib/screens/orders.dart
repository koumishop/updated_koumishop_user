import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:koumishop/components/orders/order_details.dart';
import 'package:shimmer/shimmer.dart';
import 'package:koumishop/controllers/profile_controller.dart';

// ignore: must_be_immutable
class Orders extends StatefulWidget {
  bool showMessage;
  Orders(this.showMessage, {super.key});
  @override
  State<StatefulWidget> createState() {
    return _Orders();
  }
}

class _Orders extends State<Orders> {
  ProfilController profilController = Get.find();
  double txl = 8;
  Future<Widget> getFaq() async {
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg',
      'Cookie': 'PHPSESSID=3d673c385319a7c1570963dcb99ee8f8'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://webadmin.koumishop.com/api-firebase/order-process.php'));
    request.fields.addAll({
      'offset': '0',
      'user_id': '${profilController.data['user_id']}',
      'limit': '10',
      'get_orders': '1',
      'accesskey': '90336'
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Map mapFaqs = jsonDecode(await response.stream.bytesToString());
      if (mapFaqs["error"]) {
        return Container();
      } else {
        adresses = mapFaqs["data"];
        return ListView(
          padding: const EdgeInsets.all(0),
          children: List.generate(
            adresses.length,
            (index) {
              Map orders = adresses[index];
              return InkWell(
                onTap: () {
                  Get.to(OrderDetails(orders));
                },
                child: Card(
                  elevation: 2,
                  child: SizedBox(
                    height: Get.size.height / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "OTP: ${orders['otp']}",
                                  style: tx(),
                                ),
                                Text(
                                  "N° ${orders['id']}",
                                  style: tx(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.black,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Commande placée",
                                      textAlign: TextAlign.center,
                                      style: tx2(
                                          txl,
                                          (orders['status'].length > 0
                                                  ? orders['status'][0][0]
                                                  : "") ==
                                              "received"),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Commande en traitemant",
                                    textAlign: TextAlign.center,
                                    style: tx2(
                                        txl,
                                        (orders['status'].length > 1
                                                ? orders['status'][1][0]
                                                : "") ==
                                            "processed"),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Commande en cours de livraison",
                                    textAlign: TextAlign.center,
                                    style: tx2(
                                        txl,
                                        (orders['status'].length > 2
                                                ? orders['status'][2][0]
                                                : "") ==
                                            "shipped"),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Commande livrée",
                                    textAlign: TextAlign.center,
                                    style: tx2(
                                        txl,
                                        (orders['status'].length > 3
                                                ? orders['status'][3][0]
                                                : "") ==
                                            "delivered"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 40,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.shopping_cart,
                                  color: (orders['status'].length > 0
                                              ? orders['status'][0][0]
                                              : "") ==
                                          "received"
                                      ? Colors.red
                                      : Colors.black,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                Icon(
                                  Icons.shopping_bag,
                                  color: (orders['status'].length > 1
                                              ? orders['status'][1][0]
                                              : "") ==
                                          "processed"
                                      ? Colors.red
                                      : Colors.black,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                Icon(
                                  Icons.delivery_dining_outlined,
                                  color: (orders['status'].length > 2
                                              ? orders['status'][2][0]
                                              : "") ==
                                          "shipped"
                                      ? Colors.red
                                      : Colors.black,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                Icon(
                                  Icons.headset,
                                  color: (orders['status'].length > 3
                                              ? orders['status'][3][0]
                                              : "") ==
                                          "delivered"
                                      ? Colors.red
                                      : Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    alignment: Alignment.center,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.black,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            decoration: const BoxDecoration(
                              //color: Colors.green,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text:
                                        "${orders['currency']} ${orders['final_total']}   ",
                                    children: [
                                      TextSpan(
                                        text: "",
                                        style: tx2(17, false),
                                      ),
                                    ],
                                  ),
                                  style: tx(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }
    } else {
      return Container();
    }
  }

  List adresses = [];
  final box = GetStorage();

  @override
  void initState() {
    if (widget.showMessage) {
      showMessage();
    }
    //
    super.initState();
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
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          padding: const EdgeInsets.only(left: 10),
                          //width: 150,
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
                                "Vos commandes",
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
                    padding: const EdgeInsets.all(10),
                    // ignore: sort_child_properties_last
                    child: FutureBuilder(
                      future: getFaq(),
                      builder: (context, t) {
                        if (t.hasData) {
                          return t.data as Widget;
                        } else if (t.hasError) {
                          return Container();
                        }
                        return Shimmer.fromColors(
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
                        );
                      },
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
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
  TextStyle tx() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 17,
      fontWeight: FontWeight.w900,
    );
  }

  //
  TextStyle tx2(double taille, bool v) {
    return TextStyle(
      color: v ? Colors.red : Colors.black,
      fontSize: taille,
      fontWeight: FontWeight.w300,
    );
  }

  //
  // ignore: non_constant_identifier_names
  Widget Shimm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Card(
          elevation: 1,
          color: Colors.grey,
          child: SizedBox(
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
          child: const Card(
            elevation: 1,
            child: SizedBox(
              height: 10,
              width: 100,
            ),
          ),
        ),
      ],
    );
  }

  //
  showMessage() async {}
}
