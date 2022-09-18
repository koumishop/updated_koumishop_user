import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:koumishop/pages/profil/profil_controller.dart';

class MiseaJour extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MiseaJour();
  }
}

class _MiseaJour extends State<MiseaJour> {
  //
  //
  final _formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  //
  final email = TextEditingController();
  //
  final mobile = TextEditingController();
  //
  RxString cd = "+243".obs;
  //
  final countryPicker = const FlCountryCodePicker();
  //
  /**
   * *user_id:10
*name:"jean"
*email:"...."
*mobile :"+24384...."
*profile :file //optionnel
   */
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
                              child: Row(
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
                                decoration: InputDecoration(
                                  labelText: "Votre nom",
                                  // border: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(10),
                                  // ),
                                  prefixIcon: Icon(Icons.person),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Veuillez saisir le Numéro";
                                  } else if (!value.isNum) {
                                    return "Un numéro de téléphone valide svp";
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
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  // border: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(10),
                                  // ),
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
                                  // border: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(10),
                                  // ),
                                  prefixIcon: GestureDetector(
                                    onTap: () async {
                                      final code = await countryPicker
                                          .showPicker(context: context);
                                      if (code != null) {
                                        cd.value = code.dialCode;
                                        print(code);
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
                                    var headers = {
                                      'Authorization':
                                          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
                                    };
                                    var request = http.MultipartRequest(
                                        'POST',
                                        Uri.parse(
                                            'Https://webadmin.koumishop.com/api-firebase/user-registraction.php'));
                                    request.fields.addAll({
                                      //register//edit-profile
                                      "type": "edit-profile",
                                      'accesskey': '90336',
                                      "user_id":
                                          "${profilController.infos['user_id']}",
                                      "name": name.text,
                                      "email": email.text,
                                      "mobile": mobile.text,
                                      //"profile": "file",
                                    });

                                    request.headers.addAll(headers);

                                    http.StreamedResponse response =
                                        await request.send();

                                    if (response.statusCode == 200) {
                                      String rep =
                                          await response.stream.bytesToString();
                                      print(rep);
                                      Map map = json.decode(rep);
                                      if (map['error']) {
                                        Get.back();
                                        Get.back();
                                        //
                                      } else {
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
                                  },
                                  child: Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: Text(
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
}
