import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/pages/accueil.dart';
import 'package:http/http.dart' as http;
import 'package:koumishop/pages/profil/log/inscription.dart';
import 'package:koumishop/pages/profil/log/miseajour.dart';
import 'dart:convert';

import 'package:koumishop/pages/profil/profil_controller.dart';

class Log extends StatefulWidget {
  State? state;
  Log(state);
  @override
  State<StatefulWidget> createState() {
    return _Log();
  }
}

class _Log extends State<Log> {
  //
  final _formKey = GlobalKey<FormState>();

  final numeroC = TextEditingController();
  //
  final pwC = TextEditingController();
  //
  final phone = TextEditingController();
  //
  var box = GetStorage();
  bool showPw = true;
  //
  RxString cd = "+243".obs;
  //
  final countryPicker = const FlCountryCodePicker();
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
          backgroundColor: Colors.red,
          //appBar: AppBar(),
          body: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      //width: 100,
                      height: 40,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            size: 20,
                            color: Colors.white,
                          ),
                          Text(
                            "", //S'identifier ou S'inscrire"
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(40),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: 150,
                    width: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "K",
                              style: TextStyle(
                                fontSize: 50,
                              ),
                            ),
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        Text(
                          "KOUMISHOPE",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  height: Get.size.height / 1.35,
                  width: Get.size.width,
                  // ignore: sort_child_properties_last
                  child: ListView(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Bienvenue",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Numéro ex: 822221111",
                                // border: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(10),
                                // ),
                                prefixIcon: Icon(Icons.phone_android),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Veuillez saisir le Numéro";
                                } else if (!value.isNum) {
                                  return "Un numéro de téléphone valide svp";
                                }
                                return null;
                              },
                              controller: numeroC,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              obscureText: showPw,
                              decoration: InputDecoration(
                                labelText: "Mot de passe",
                                // border: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(10),
                                // ),
                                prefixIcon: Icon(Icons.lock),
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      showPw ? showPw = false : showPw = true;
                                    });
                                  },
                                  child: Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Veuillez saisir le mot de passe";
                                }
                                return null;
                              },
                              controller: pwC,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
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
                                        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
                                  };
                                  var request = http.MultipartRequest(
                                      'POST',
                                      Uri.parse(
                                          'https://webadmin.koumishop.com/api-firebase/login.php'));
                                  request.fields.addAll({
                                    'accesskey': '90336',
                                    'login': '1',
                                    'mobile': numeroC.text,
                                    'password': pwC.text,
                                    'fcm_id': '$fcmToken',
                                  });

                                  request.headers.addAll(headers);

                                  http.StreamedResponse response =
                                      await request.send();

                                  if (response.statusCode == 200) {
                                    Map infos = jsonDecode(
                                        await response.stream.bytesToString());
                                    infos["mdp"] = pwC.text;
                                    print("$infos");
                                    //
                                    ProfilController profilController =
                                        Get.find();
                                    //
                                    profilController.infos.value = infos;
                                    //
                                    box.write("profile", infos);
                                    //
                                    Get.back();
                                    if (infos['error']) {
                                      Get.snackbar("Erreur d'authentification",
                                          "${infos['message']}");
                                    } else {
                                      Get.back();
                                      Get.snackbar("Succès",
                                          "Bienvenu ${infos['name']}");
                                      Timer(Duration(seconds: 1), () {
                                        //
                                        //widget.state!.setState(() {});
                                      });
                                    }
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (c) {
                                    //       return Material(
                                    //         child: ListView(
                                    //           children: [
                                    //             Text("$infos"),
                                    //           ],
                                    //         ),
                                    //       );
                                    //     });

                                  } else {
                                    print(response.reasonPhrase);
                                    Get.back();
                                    Get.snackbar("Erreur d'authentification",
                                        "${response.reasonPhrase}. Code: ${response.statusCode}");
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Se connecter",
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
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Mot de passe oublié ?",
                          style: TextStyle(
                            textBaseline: TextBaseline.alphabetic,
                            decoration: TextDecoration.underline,
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.grey.shade200,
                          ),
                          overlayColor: MaterialStateProperty.all(
                            Colors.red.shade100,
                          ),
                        ),
                        onPressed: () {
                          //
                          showDialog(
                              context: context,
                              builder: (c) {
                                return AlertDialog(
                                  title: Text("Vérification du numéro"),
                                  content: Container(
                                    height: 50,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: GestureDetector(
                                            onTap: () async {
                                              final code = await countryPicker
                                                  .showPicker(context: context);
                                              if (code != null) {
                                                cd.value = code.dialCode;
                                                print(code);
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 4.0),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              decoration: const BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              5.0))),
                                              child: Obx(
                                                () => Text(
                                                  cd.value,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 8,
                                          child: TextField(
                                            controller: phone,
                                            decoration: InputDecoration(
                                                hintText: "ex: 820011111"),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        elevation: MaterialStateProperty.all(0),
                                        padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                        ),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Colors.red,
                                        ),
                                        overlayColor: MaterialStateProperty.all(
                                          Colors.red.shade100,
                                        ),
                                      ),
                                      onPressed: () async {
                                        //
                                        if (phone.text.isNotEmpty) {
                                          final fcmToken =
                                              await FirebaseMessaging.instance
                                                  .getToken();
                                          //
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
                                          var headers = {
                                            'Authorization':
                                                'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
                                          };
                                          var request = http.MultipartRequest(
                                              'POST',
                                              Uri.parse(
                                                  'https://webadmin.koumishop.com/api-firebase/user-registration.php'));
                                          request.fields.addAll({
                                            'accesskey': '90336',
                                            'mobile': phone.text,
                                            'type': 'verify-user'
                                          });

                                          request.headers.addAll(headers);

                                          http.StreamedResponse response =
                                              await request.send();

                                          if (response.statusCode == 200) {
                                            String rep = await response.stream
                                                .bytesToString();
                                            Map map = json.decode(rep);
                                            if ("${map['message']}"
                                                .contains("l'OTP !")) {
                                              Get.back();
                                              Get.back();
                                              Get.back();
                                              Get.to(Inscription());
                                              //
                                            } else {
                                              Get.back();
                                              Get.back();
                                              Get.snackbar(
                                                "Téléphone",
                                                "${map['message']}",
                                                duration: const Duration(
                                                  seconds: 7,
                                                ),
                                              );
                                            }
                                          } else {
                                            print(response.reasonPhrase);
                                          }
                                        } else {
                                          Get.snackbar("Téléphone",
                                              "Numéro de téléphone vide.");
                                        }
                                      },
                                      child: Container(
                                        height: 50,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Vérifier OTP",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            "Inscrivez-vous",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle styleDeMenu() {
    return TextStyle(
      color: Colors.grey,
      fontSize: 13,
      fontWeight: FontWeight.normal,
    );
  }
}
