import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koumishop/pages/accueil.dart';

enum Type { MAISON, BUREAU, AUTRE }

class NouvelleAdresse extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NouvelleAdresse();
  }
}

class _NouvelleAdresse extends State<NouvelleAdresse> {
  //
  Type choix = Type.MAISON;

  final _formKey = GlobalKey<FormState>();

  final nomC = TextEditingController();
  //
  final tel1C = TextEditingController();
  //
  final tel2C = TextEditingController();
  //
  final avenueNumC = TextEditingController();
  //
  final PointRepC = TextEditingController();
  //
  String c1 = "Kinshasa";
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
          body: Column(
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
                        controller: PointRepC,
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
                                    value: "${lc[index]}",
                                    child: Text("${lc[index]}"),
                                  ),
                                ),
                                onChanged: (value) {
                                  //
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
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
                                    value: "${lc[index]}",
                                    child: Text("${lc[index]}"),
                                  ),
                                ),
                                onChanged: (value) {
                                  //
                                },
                              ),
                            ),
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
                          value: true,
                          onChanged: (e) {
                            //
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
                          onPressed: () {},
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
    );
  }

  TextStyle tx() {
    return TextStyle(
      color: Colors.grey.shade700,
      fontSize: 13,
    );
  }
}
