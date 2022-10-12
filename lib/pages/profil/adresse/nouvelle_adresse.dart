import 'dart:async';
//import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
//import 'package:koumishop/pages/accueil.dart';
import 'package:koumishop/pages/profil/profil_controller.dart';

enum Type { MAISON, BUREAU, AUTRE }

class NouvelleAdresse extends StatefulWidget {
  State state;
  NouvelleAdresse(
    this.state,
  );
  @override
  State<StatefulWidget> createState() {
    return _NouvelleAdresse();
  }
}

class _NouvelleAdresse extends State<NouvelleAdresse> {
  //
  Type choix = Type.MAISON;
  ProfilController profilController = Get.find();

  final _formKey = GlobalKey<FormState>();

  var nomC = TextEditingController();
  //
  var tel1C = TextEditingController();
  //
  final tel2C = TextEditingController();
  //
  final avenueNumC = TextEditingController();
  //
  final pointRepC = TextEditingController();
  //
  saveAdresse(Map<String, String> m) async {
    //
    var headers = {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjI2NjgwMTEsImlzcyI6ImVLYXJ0IiwiZXhwIjo2LjQ4MDAwMDAwMDAwMDAwMmUrMjQsInN1YiI6ImVLYXJ0IEF1dGhlbnRpY2F0aW9uIn0.B3j6ZUzOa-7XfPvjJ3wvu3eosEw9CN5cWy1yOrv2Ppg'
    };
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://webadmin.koumishop.com/api-firebase/user-addresses.php'));
    request.fields.addAll(m);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      //
      tel2C.clear();
      avenueNumC.clear();
      pointRepC.clear();
      //
      Get.back();
      Get.back();
      //
      Get.snackbar("Adresse", "Enregistrement éffectué");
      //
      //nomC.clear();
      //tel1C.clear();
      //

      //Timer(const Duration(seconds: 1), () {
      widget.state.setState(() {});
      //});
    } else {
      Get.snackbar("Erreur", "Un problème est survenu");
      print(response.reasonPhrase);
    }
  }

  //
  String c1 = "Kinshasa";
  String idComm = "";
  String c2 = "";
  String idQuart = "";
  //
  List lq = [];
  //
  bool dft = false;
  //
  Map adresse = {};
  //
  List lc = [
    "Kinshasa",
    "Lingwala",
    "Ngaliema",
    "Kintambo",
    "Kalamu",
    "Bumbu",
    "Barumbu",
    "Bandalungwa",
    "Gombe",
  ];
  //
  String q1 = "1";
  //
  @override
  void initState() {
    var box = GetStorage();
    //
    nomC = TextEditingController(text: profilController.infos['name']);
    //
    tel1C = TextEditingController(text: profilController.infos['mobile']);
    //
    adresse = box.read("adresse") ?? {};
    lc = adresse['data'];
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
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: Colors.red,
                              ),
                              Text(
                                "Adresse de livraison",
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
                Form(
                  key: _formKey,
                  child: Expanded(
                    flex: 1,
                    child: ListView(
                      padding: EdgeInsets.all(20),
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          enabled: false,
                          decoration: const InputDecoration(
                            labelText: "Nom",
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10),
                            // ),
                            //prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Veuillez saisir le nom";
                            }
                            return null;
                          },
                          controller: nomC,
                        ),
                        TextFormField(
                          enabled: false,
                          decoration: const InputDecoration(
                            labelText: "Numéro téléphone",
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10),
                            // ),
                            //prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Veuillez saisir le numéro";
                            }
                            return null;
                          },
                          controller: tel1C,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Numéro de téléphone alternatif",
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10),
                            // ),
                            //prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Veuillez saisir le numéro de téléphone alternatif";
                            }
                            return null;
                          },
                          controller: tel2C,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Avenue & Numéro",
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10),
                            // ),
                            //prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Champ vide";
                            }
                            return null;
                          },
                          controller: avenueNumC,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Point de repère",
                            // border: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10),
                            // ),
                            //prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Champ vide";
                            }
                            return null;
                          },
                          controller: pointRepC,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                height: 50,
                                //color: Colors.blue,
                                child: DropdownButton<String>(
                                  value: c1,
                                  isExpanded: true,
                                  items: List.generate(
                                    lc.length,
                                    (index) => DropdownMenuItem<String>(
                                      value: "${lc[index]['pincode']}",
                                      child: Text("${lc[index]['pincode']}"),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      c1 = value as String;
                                      lc.forEach((element) {
                                        //
                                        if (element['pincode'] == c1) {
                                          //
                                          lq = element['cities'];
                                          c2 = lq.isNotEmpty
                                              ? lq[0]['name']
                                              : "";
                                          idQuart = lq[0]['id'];
                                          //
                                          idComm = element['id'];
                                          //
                                        }
                                      });
                                      print("add: $c1");
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              flex: 4,
                              child: idComm.isNotEmpty
                                  ? Container(
                                      height: 50,
                                      //color: Colors.blue,
                                      child: DropdownButton<String>(
                                        value: c2,
                                        isExpanded: true,
                                        items: List.generate(
                                          lq.length,
                                          (index) => DropdownMenuItem<String>(
                                            value: "${lq[index]['name']}",
                                            child: Text("${lq[index]['name']}"),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          //
                                          setState(() {
                                            c2 = value as String;
                                            lq.forEach((element) {
                                              //
                                              if (element['name'] == c2) {
                                                //
                                                //lq = element['cities'];
                                                //c2 = lq[0]['name'];
                                                //
                                                idQuart = element['id'];
                                                //
                                              }
                                            });
                                            print("add: $c1");
                                          });
                                        },
                                      ),
                                    )
                                  : Container(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  Radio(
                                    value: Type.MAISON,
                                    groupValue: choix,
                                    onChanged: (Type? value) {
                                      setState(() {
                                        choix = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    "MAISON",
                                    style: tx(),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  Radio(
                                    value: Type.BUREAU,
                                    groupValue: choix,
                                    onChanged: (Type? value) {
                                      setState(() {
                                        choix = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    "BUREAU",
                                    style: tx(),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  Radio(
                                    value: Type.AUTRE,
                                    groupValue: choix,
                                    onChanged: (Type? value) {
                                      setState(() {
                                        choix = value!;
                                      });
                                    },
                                  ),
                                  Text(
                                    "AUTRE",
                                    style: tx(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          Checkbox(
                            value: dft,
                            checkColor: Colors.white,
                            activeColor: Colors.red,
                            onChanged: (e) {
                              setState(() {
                                //
                                dft = e as bool;
                              });
                            },
                          ),
                          Text(
                            "Définir comme adresse par défaut",
                            style: tx(),
                          ),
                        ]),
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
                            onPressed: () {
                              //
                              final box = GetStorage();
                              /**
                               * {
}
                               */
                              Map<String, String> adresse = {
                                'accesskey': '90336',
                                'add_address': '1',
                                'user_id': profilController.infos['user_id'],
                                'name': nomC.text,
                                'mobile': tel1C.text,
                                'alternate_mobile': tel2C.text,
                                'type': choix.name,
                                'address': avenueNumC.text,
                                'country_code': '243',
                                'landmark': pointRepC.text,
                                'pincode_id': idComm,
                                'city_id': idQuart,
                                'is_default': dft ? "0" : "1",
                              };
                              //  {
                              //   "country_code": nomC.text,
                              //   "tel1": tel1C.text,
                              //   "tel2": tel2C.text,
                              //   "avnum": avenueNumC.text,
                              //   "repere": pointRepC.text,
                              //   "commune": c1,
                              //   "quartier": c2,
                              //   "type": choix.name,
                              //   "default": dft,
                              // };
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
                              saveAdresse(adresse);
                              //
                              //List adresses = box.read('adresses') ?? [];
                              //
                              //adresses.add(adresse);
                              //box.write('adresses', adresses);
                            },
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: const Text(
                                "AJOUTER UNE NOUVELLE ADRESSE",
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle tx() {
    return TextStyle(
      color: Colors.grey.shade700,
      fontSize: 13,
    );
  }
}
