import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:koumishop/screens/homepage.dart';
import 'package:koumishop/components/users/policy.dart';
import 'package:koumishop/components/users/terms.dart';
import 'dart:convert';
import 'package:koumishop/controllers/profile_controller.dart';

// ignore: must_be_immutable
class Inscription extends StatefulWidget {
  String phoneN;
  String code;
  Inscription(this.phoneN, this.code, {super.key});
  @override
  State<StatefulWidget> createState() {
    return _Inscription();
  }
}

class _Inscription extends State<Inscription> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final mobile = TextEditingController();
  final mdp = TextEditingController();
  final mdpC = TextEditingController();
  bool accepte = false;
  bool showCode1 = false;
  bool showCode2 = false;
  // ignore: non_constant_identifier_names
  final code_ref = TextEditingController();
  RxString cd = "+243".obs;
  var sexe = "";
  String dateNaissance = "";
  final countryPicker = const FlCountryCodePicker();

  /// *user_id:10
  ///name:"jean"
  ///email:"...."
  ///mobile :"+24384...."
  ///profile :file //optionnel
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Scaffold(
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
            child: Stack(
              children: [
                Column(
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
                                    "Inscription",
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
                        padding: const EdgeInsets.all(30),
                        // ignore: sort_child_properties_last
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  "Informations personnelles",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  widget.phoneN,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 17,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Votre nom",
                                    prefixIcon: Icon(Icons.person),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Veuillez saisir votre nom";
                                    }
                                    return null;
                                  },
                                  controller: name,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    labelText: "Email",
                                    prefixIcon: Icon(Icons.email),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Veuillez saisir votre email";
                                    }
                                    return null;
                                  },
                                  controller: email,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                        flex: 5,
                                        child: Text("Sexe"),
                                      ),
                                      Expanded(
                                          flex: 5,
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              onChanged: (e) {
                                                setState(() {
                                                  sexe = e as String;
                                                });
                                              },
                                              value: sexe,
                                              items: const [
                                                DropdownMenuItem(
                                                  value: "",
                                                  child: Text("Non renseigné"),
                                                ),
                                                DropdownMenuItem(
                                                  value: "F",
                                                  child: Text("Femme"),
                                                ),
                                                DropdownMenuItem(
                                                  value: "M",
                                                  child: Text("Homme"),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                        flex: 5,
                                        child: Text("Date de naissance"),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: InkWell(
                                          onTap: () {
                                            showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1940),
                                              lastDate: DateTime(2030),
                                            ).then((value) {
                                              setState(() {
                                                dateNaissance =
                                                    "${value!.year}-${value.month}-${value.day}";
                                              });
                                            });
                                          },
                                          child: Container(
                                            height: 50,
                                            padding: const EdgeInsets.all(
                                              5,
                                            ),
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.red,
                                                width: 1,
                                              ),
                                            ),
                                            child: Text(
                                              dateNaissance,
                                              style: const TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  obscureText: showCode1,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: "Mot de passe",
                                    suffix: InkWell(
                                      onTap: () {
                                        setState(() {
                                          showCode1 = !showCode1;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.remove_red_eye,
                                      ),
                                    ),
                                    prefixIcon: const Icon(Icons.lock),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Veuillez saisir votre mot de passe";
                                    } else if (value != mdpC.text) {
                                      return "Le mot de passe n'est pas identique";
                                    }
                                    return null;
                                  },
                                  controller: mdp,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  obscureText: showCode2,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: "Confirmez mot de passe",
                                    suffix: InkWell(
                                      onTap: () {
                                        setState(() {
                                          showCode2 = !showCode2;
                                        });
                                      },
                                      child: const Icon(
                                        Icons.remove_red_eye,
                                      ),
                                    ),
                                    prefixIcon: const Icon(Icons.lock),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Veuillez saisir votre mot de passe pour confirmer";
                                    } else if (value != mdp.text) {
                                      return "Le mot de passe n'est pas identique";
                                    }
                                    return null;
                                  },
                                  controller: mdpC,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        child: Checkbox(
                                          value: accepte,
                                          onChanged: (c) {
                                            setState(() {
                                              if (kDebugMode) {
                                                print(c);
                                              }
                                              accepte = c as bool;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 8,
                                      child: RichText(
                                        text: TextSpan(
                                          text: "J'ai lu et j'accepte la ",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 17,
                                          ),
                                          children: [
                                            WidgetSpan(
                                              child: InkWell(
                                                onTap: () {
                                                  Get.to(const Policy());
                                                },
                                                child: Text(
                                                  "Politique de confidencialité ",
                                                  style: TextStyle(
                                                    color: Colors.red.shade700,
                                                    fontSize: 17,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const TextSpan(
                                              text: " et les ",
                                            ),
                                            WidgetSpan(
                                              child: InkWell(
                                                onTap: () {},
                                                child: InkWell(
                                                  onTap: () {
                                                    Get.to(const Terms());
                                                  },
                                                  child: Text(
                                                    "Conditions générales ",
                                                    style: TextStyle(
                                                      color:
                                                          Colors.red.shade700,
                                                      fontSize: 17,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
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
                                      Colors.red,
                                    ),
                                    overlayColor: MaterialStateProperty.all(
                                      Colors.red.shade100,
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (accepte) {
                                      //
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
                                        //
                                        var headers = {
                                          'Authorization':
                                              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg',
                                          'Cookie':
                                              'PHPSESSID=e18e7b41c806a6fdd8d326ffe8750851'
                                        };
                                        var request = http.MultipartRequest(
                                            'POST',
                                            Uri.parse(
                                                'https://webadmin.koumishop.com/api-firebase/user-registration.php'));
                                        request.fields.addAll(
                                          {
                                            'country_code': '243',
                                            'password': mdp.text,
                                            'friends_code': '',
                                            'accesskey': '90336',
                                            'name': name.text,
                                            'mobile': widget.phoneN,
                                            'type': 'register',
                                            'email': email.text,
                                            'fcm_id': "$fcmToken",
                                            'sex': sexe,
                                            'date_of_birth': dateNaissance,
                                            //'1990-10-25'
                                          },
                                        );

                                        request.headers.addAll(headers);

                                        http.StreamedResponse response =
                                            await request.send();

                                        if (response.statusCode == 200) {
                                          String rep = await response.stream
                                              .bytesToString();
                                          Map map = json.decode(rep);
                                          if (map['error']) {
                                            Get.back();
                                            Get.snackbar(
                                                "Erreur d'authentification",
                                                "${map['message']}");
                                            //
                                          } else {
                                            ProfilController profilController =
                                                Get.find();
                                            //
                                            var box = GetStorage();
                                            //
                                            profilController.data.value = map;
                                            //
                                            box.write("profile", map);
                                            Get.back();
                                            Get.off(Homepage(false));
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
                                      }
                                    } else {
                                      Get.snackbar("Attention",
                                          "Vous n'avez pas accepté les termes et conditions d'utilisations");
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Envoyer",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
