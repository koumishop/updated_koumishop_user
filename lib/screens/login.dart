import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:koumishop/components/auth/change_password_otp.dart';
import 'dart:convert';
import 'package:koumishop/controllers/profile_controller.dart';
import 'package:koumishop/components/auth/otp_verification.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  State? state;
  LoginScreen(state, {super.key});
  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final numeroC = TextEditingController();
  final pwC = TextEditingController();
  final phone = TextEditingController();
  var box = GetStorage();
  bool showPw = true;
  RxString cd = "+243".obs;
  final countryPicker = const FlCountryCodePicker();
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
                      height: 40,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.arrow_back,
                            size: 20,
                            color: Colors.white,
                          ),
                          Text(
                            "",
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(40),
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
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
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Numéro ex: 822221111",
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
                                prefixIcon: const Icon(Icons.lock),
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      showPw ? showPw = false : showPw = true;
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
                                  if (_formKey.currentState!.validate()) {
                                    final fcmToken = await FirebaseMessaging
                                        .instance
                                        .getToken();
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
                                      Map infos = jsonDecode(await response
                                          .stream
                                          .bytesToString());
                                      infos["mdp"] = pwC.text;
                                      Get.back();
                                      if (infos['error']) {
                                        Get.snackbar(
                                            "Erreur d'authentification",
                                            "${infos['message']}");
                                      } else {
                                        ProfilController profilController =
                                            Get.find();
                                        profilController.data.value = infos;
                                        box.write("profile", infos);
                                        box.write("mdp", pwC.text);
                                        Get.back();
                                        Get.snackbar("Succès",
                                            "Bienvenu ${infos['name']}");
                                        Timer(
                                            const Duration(seconds: 1), () {});
                                      }
                                    } else {
                                      Get.back();
                                      Get.snackbar("Erreur d'authentification",
                                          "${response.reasonPhrase}. Code: ${response.statusCode}");
                                    }
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: const Text(
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
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (c) {
                              return AlertDialog(
                                title: const Text("Vérification du numéro"),
                                content: SizedBox(
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
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 4.0),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            decoration: const BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
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
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
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
                                      if (phone.text.isNotEmpty) {
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
                                          String rep = await response.stream
                                              .bytesToString();
                                          Map map = json.decode(rep);
                                          if ("${map['message']}".contains(
                                              "Ce numéro de téléphone est déjà enregistré")) {
                                            FirebaseAuth.instance
                                                .verifyPhoneNumber(
                                              phoneNumber:
                                                  "${cd.value}${phone.text}",
                                              timeout:
                                                  const Duration(minutes: 2),
                                              verificationCompleted: (v) {},
                                              verificationFailed: (v) {
                                                Get.back();
                                                Get.back();
                                                Get.back();
                                                Get.snackbar("Echec", "$v");
                                              },
                                              codeSent: (String verificationId,
                                                  int? resendToken) {
                                                Get.back();
                                                Get.back();
                                                Get.back();
                                                showDialog(
                                                  context: context,
                                                  builder: (c) {
                                                    return ChangePasswordOTP(
                                                      cd.value,
                                                      phone.text,
                                                      verificationId,
                                                    );
                                                  },
                                                );
                                              },
                                              codeAutoRetrievalTimeout: (c) {},
                                            );
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
                                          if (kDebugMode) {
                                            print(response.reasonPhrase);
                                          }
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
                                      child: const Text(
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
                            },
                          );
                        },
                        child: const Text(
                          "Mot de passe oublié ?",
                          style: TextStyle(
                            textBaseline: TextBaseline.alphabetic,
                            decoration: TextDecoration.underline,
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      const SizedBox(
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
                          showDialog(
                            context: context,
                            builder: (c) {
                              return AlertDialog(
                                title: const Text("Vérification du numéro"),
                                content: SizedBox(
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
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 4.0),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            decoration: const BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
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
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
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
                                      if (phone.text.isNotEmpty) {
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
                                          String rep = await response.stream
                                              .bytesToString();
                                          Map map = json.decode(rep);
                                          if ("${map['message']}"
                                              .contains("l'OTP !")) {
                                            FirebaseAuth.instance
                                                .verifyPhoneNumber(
                                              phoneNumber:
                                                  "${cd.value}${phone.text}",
                                              timeout:
                                                  const Duration(minutes: 2),
                                              verificationCompleted: (v) {},
                                              verificationFailed: (v) {
                                                Get.back();
                                                Get.back();
                                                Get.back();
                                                Get.snackbar("Echec", "$v");
                                              },
                                              codeSent: (String verificationId,
                                                  int? resendToken) {
                                                Get.back();
                                                Get.back();
                                                Get.back();
                                                showDialog(
                                                  context: context,
                                                  builder: (c) {
                                                    return OTPVerification(
                                                      cd.value,
                                                      phone.text,
                                                      verificationId,
                                                      true,
                                                    );
                                                  },
                                                );
                                              },
                                              codeAutoRetrievalTimeout: (c) {},
                                            );
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
                                          if (kDebugMode) {
                                            print(response.reasonPhrase);
                                          }
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
                                      child: const Text(
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
                            },
                          );
                          //
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: const Text(
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
    return const TextStyle(
      color: Colors.grey,
      fontSize: 13,
      fontWeight: FontWeight.normal,
    );
  }
}
