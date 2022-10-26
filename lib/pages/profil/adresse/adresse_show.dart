import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/main.dart';
import 'package:koumishop/pages/panier/panier_controller.dart';
import 'package:koumishop/pages/profil/profil_controller.dart';
import 'package:shimmer/shimmer.dart';

import 'nouvelle_adresse.dart';

class AdresseShow extends StatefulWidget {
  State st;
  AdresseShow(this.st);
  @override
  State<StatefulWidget> createState() {
    return _AdresseShow();
  }
}

class _AdresseShow extends State<AdresseShow> {
  //
  ProfilController profilController = Get.find();
  PanierController panierController = Get.find();
  //
  supprimerAddresse(String id) async {
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg',
      'Cookie': 'PHPSESSID=e18e7b41c806a6fdd8d326ffe8750851'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://webadmin.koumishop.com/api-firebase/user-addresses.php'));
    request.fields
        .addAll({'accesskey': '90336', 'id': id, 'delete_address': '1'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String rep = await response.stream.bytesToString();
      print("reponse pour la supp: $rep");
      if (panierController.adresse['id'] == id) {
        panierController.adresse = {}.obs;
        print("-------------------------------------1");

        Get.back();
        Get.back();
        statePanier!.setState(() {});
        Get.snackbar("Succès", "Adresse supprimé");
      } else {
        print("-------------------------------------2");
        Get.back();
        Get.back();
        Get.snackbar("Succès", "Adresse supprimé");
      }
    } else {
      //print(response.reasonPhrase);
      Get.snackbar("Erreur", response.reasonPhrase!);
      Get.back();
      Get.back();
    }
  }

  //
  Future<Widget> getFaq() async {
    //
    getAllCommune();
    //
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://webadmin.koumishop.com/api-firebase/user-addresses.php'));
    request.fields.addAll(
      {
        'accesskey': '90336',
        'user_id': profilController.infos['user_id'] ?? "",
        'get_addresses': '1',
      },
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      Map mapFaqs = jsonDecode(await response.stream.bytesToString());
      print(mapFaqs);
      if (mapFaqs["error"]) {
        return Container();
      } else {
        adresses = mapFaqs["data"];
        return ListView(
          padding: const EdgeInsets.all(20),
          children: List.generate(adresses.length, (index) {
            Map adresse = adresses[index];
            bool v = adresse["is_default"] == "0";
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 1,
                    child: InkWell(
                      onTap: () {
                        panierController.adresse.value = adresse;
                        Get.back();
                        widget.st.setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                        ),
                        height: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 7,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 50,
                                    child: Checkbox(
                                      value: v,
                                      checkColor: Colors.red.shade700,
                                      onChanged: (e) {
                                        //
                                        panierController.adresse.value =
                                            adresse;
                                        Get.back();
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: ListTile(
                                      // onTap: () {

                                      // },
                                      title: Text(
                                        "${adresse["pincode"]} / ${adresse["city"]}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: Get.size.width / 2.5,
                                                child: Text(
                                                  "${adresse["address"]} / ${adresse["city"]}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "${adresse["landmark"]}",
                                              overflow: TextOverflow.clip,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "${adresse["delivery_charges"]} Fc",
                                              overflow: TextOverflow.clip,
                                              maxLines: 1,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {
                                          Get.dialog(
                                            const Center(
                                              child: SizedBox(
                                                height: 50,
                                                width: 50,
                                                child:
                                                    CircularProgressIndicator(
                                                  backgroundColor: Colors.red,
                                                  strokeWidth: 7,
                                                ),
                                              ),
                                            ),
                                          );
                                          //
                                          setState(() {
                                            //
                                            supprimerAddresse(
                                                "${adresse["id"]}");
                                            //
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
        );
      }
    } else {
      print(response.reasonPhrase);
      return Container();
    }
  }

  getAllCommune() async {
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg',
      'Cookie': 'PHPSESSID=e18e7b41c806a6fdd8d326ffe8750851'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://webadmin.koumishop.com/api-firebase/get-locations.php'));
    request.fields.addAll({
      'search': '',
      'get_pincodes': '1',
      'offset': '0',
      'accesskey': '90336',
      'limit': '30'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map adresse = jsonDecode(await response.stream.bytesToString());
      var box = GetStorage();
      //
      box.write("adresse", adresse);
      //print(adresse);
    } else {
      print(response.reasonPhrase);
    }
  }

  //
  List adresses = [];
  //
  final box = GetStorage();
  //
  @override
  void initState() {
    //
    //adresses = box.read('adresses') ?? [];
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      bottom: false,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 232, 235),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      //
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  )
                ],
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
                        child: Center(
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    },
                  ),
                  decoration: const BoxDecoration(
                    //color: Colors.white,
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //
            //Get.back();
            showDialog(
                context: context,
                builder: (context) {
                  return Material(
                    child: NouvelleAdresse(this),
                  );
                });
            //Get.to(NouvelleAdresse(this));
          },
          backgroundColor: Colors.red,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  //
}
