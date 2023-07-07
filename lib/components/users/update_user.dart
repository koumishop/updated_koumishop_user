// ignore_for_file: invalid_use_of_protected_member

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:koumishop/controllers/profile_controller.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UpdateUser();
  }
}

class _UpdateUser extends State<UpdateUser> {
  ProfilController profilController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final mobile = TextEditingController();
  RxString cd = "+243".obs;
  final countryPicker = const FlCountryCodePicker();

  @override
  void initState() {
    name.text = profilController.data['name'];
    email.text = profilController.data['email'];
    mobile.text = profilController.data['mobile'];
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
                              //
                              Get.back();
                              //
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
                                    Icons.arrow_back_ios,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                  Text(
                                    "Mise à jour",
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
                        // ignore: sort_child_properties_last
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                              TextFormField(
                                decoration: const InputDecoration(
                                  labelText: "Votre nom",
                                  prefixIcon: Icon(Icons.person),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Veuillez saisir le Numéro";
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
                              TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Téléphone",
                                  prefixIcon: GestureDetector(
                                    onTap: () async {
                                      final code = await countryPicker
                                          .showPicker(context: context);
                                      if (code != null) {
                                        cd.value = code.dialCode;
                                      }
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 40,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      decoration: const BoxDecoration(
                                          color: Colors.red,
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Veuillez saisir votre numéro de téléphone";
                                  }
                                  return null;
                                },
                                controller: mobile,
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(),
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
                                    if (_formKey.currentState!.validate()) {
                                      //
                                      ProfilController profilController =
                                          Get.find();
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
                                      final fcmToken = await FirebaseMessaging
                                          .instance
                                          .getToken();
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
                                          'accesskey': '90336',
                                          'user_id':
                                              '${profilController.data['user_id']}',
                                          'latitude': '0',
                                          ' name': name.text,
                                          ' mobile': mobile.text,
                                          ' type': 'edit-profile',
                                          'fcm_id': '$fcmToken',
                                          ' longitude': '0',
                                          ' email': email.text,
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
                                          load("${map['message']}");
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
                                      "Enregistrer",
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

  load(String message) async {
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg',
      'Cookie': 'PHPSESSID=3d673c385319a7c1570963dcb99ee8f8'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://webadmin.koumishop.com/api-firebase/get-user-data.php'));
    request.fields.addAll({
      'get_user_data': '1',
      'accesskey': '90336',
      'user_id': '${profilController.data['user_id']}'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String rep = await response.stream.bytesToString();
      Map infos = json.decode(rep);
      var box = GetStorage();
      ProfilController profilController = Get.find();
      profilController.data.value = infos['data'][0];
      box.write("profile", profilController.data.value);
      Get.back();
      Get.snackbar(
        "Téléphone",
        message,
        duration: const Duration(
          seconds: 7,
        ),
      );
    } else {
      Get.back();
    }
  }
}
