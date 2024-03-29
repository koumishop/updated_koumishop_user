import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koumishop/controllers/profile_controller.dart';

// ignore: must_be_immutable
class ForgotPassword extends StatefulWidget {
  String telephone;
  ForgotPassword(this.telephone, {super.key});
  @override
  State<StatefulWidget> createState() {
    return _ForgotPassword();
  }
}

class _ForgotPassword extends State<ForgotPassword> {
  login() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('https://webadmin.koumishop.com/api-firebase/login.php'));
    request.fields.addAll({
      'accesskey': '90336',
      'login': '1',
      'mobile': widget.telephone,
      'password': customerPassword.text,
      'fcm_id': '$fcmToken',
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map infos = jsonDecode(await response.stream.bytesToString());
      infos["mdp"] = customerPassword.text;
      Get.back();
      if (infos['error']) {
        Get.snackbar("Erreur d'authentification", "${infos['message']}");
      } else {
        ProfilController profilController = Get.find();
        profilController.data.value = infos;
        box.write("profile", infos); //
        box.write("mdp", customerPassword.text);
        Get.back();
        Get.snackbar("Succès", "Bienvenu ${infos['name']}");
        Timer(const Duration(seconds: 1), () {});
      }
    } else {
      Get.back();
      Get.snackbar("Erreur d'authentification",
          "${response.reasonPhrase}. Code: ${response.statusCode}");
    }
  }

  final _formKey = GlobalKey<FormState>();
  final customerCurrentPassword = TextEditingController();
  final customerNewPassword = TextEditingController();
  final customerPassword = TextEditingController();
  final phone = TextEditingController();
  var box = GetStorage();
  bool showPw1 = true;
  bool showPw2 = true;
  bool showPw3 = true;
  ProfilController profilController = Get.find();

  changePassword(
    String password,
    String telephone,
  ) async {
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg',
      'Cookie': 'PHPSESSID=e18e7b41c806a6fdd8d326ffe8750851'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://webadmin.koumishop.com/api-firebase/user-registration.php'));
    request.fields.addAll({
      'password': password,
      'mobile': telephone,
      'type': 'forgot-password-mobile',
      'accesskey': '90336'
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String rep = await response.stream.bytesToString();
      Map r = jsonDecode(rep);
      if (r['error']) {
        Get.back();
        Get.back();
        Get.back();
        Get.snackbar("Erreur", "${r['message']}");
      } else {
        Get.back();
        Get.back();
        login();
      }
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: Colors.red,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
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
                      child: const Row(
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
              SizedBox(
                height: Get.size.height / 3,
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
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          image: const DecorationImage(
                            image: ExactAssetImage(
                              "assets/logo_koumi_squared.png",
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      "KOUMI SHOP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  alignment: Alignment.bottomCenter,
                  height: Get.size.height / 1.8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                        const Text(
                          "Modifier le mot de passe ?",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Material(
                            child: Padding(
                          padding: const EdgeInsets.only(),
                          child: TextFormField(
                            obscureText: showPw2,
                            decoration: InputDecoration(
                              labelText: "Nouveau mot de passe",
                              prefixIcon: const Icon(Icons.lock),
                              suffix: InkWell(
                                onTap: () {
                                  setState(() {
                                    showPw2 ? showPw2 = false : showPw2 = true;
                                  });
                                },
                                child: const Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Veuillez saisir le mot de passe";
                              } else if (value.length < 8) {
                                return "Mot de passe moin de 8 charactere";
                              }
                              return null;
                            },
                            controller: customerNewPassword,
                          ),
                        )),
                        const SizedBox(
                          height: 10,
                        ),
                        Material(
                          child: Padding(
                            padding: const EdgeInsets.only(),
                            child: TextFormField(
                              obscureText: showPw3,
                              decoration: InputDecoration(
                                labelText: "Confirm mot de passe",
                                prefixIcon: const Icon(Icons.lock),
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      showPw3
                                          ? showPw3 = false
                                          : showPw3 = true;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Veuillez saisir le mot de passe";
                                } else if (value != customerNewPassword.text) {
                                  return "Le mot de passe n'est pas identique";
                                }
                                return null;
                              },
                              controller: customerPassword,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
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
                              if (_formKey.currentState!.validate()) {
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
                                  String rep =
                                      await response.stream.bytesToString();
                                  Map map = json.decode(rep);
                                  if ("${map['message']}".contains("l'OTP !")) {
                                    //
                                    Get.back();
                                    Get.back();
                                    Get.snackbar(
                                      "Téléphone",
                                      "${map['message']}",
                                      duration: const Duration(
                                        seconds: 7,
                                      ),
                                    );
                                    //
                                  } else {
                                    changePassword(
                                      customerPassword.text,
                                      widget.telephone,
                                    );
                                  }
                                } else {
                                  if (kDebugMode) {
                                    print(response.reasonPhrase);
                                  }
                                }
                              }
                            },
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: const Text(
                                "Modifier le mot de passe",
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
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
