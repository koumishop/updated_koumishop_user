import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koumishop/pages/accueil.dart';

class Log extends StatefulWidget {
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
                                labelText: "Numéro ex: 0822221111",
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
                              decoration: InputDecoration(
                                labelText: "Mot de passe",
                                // border: OutlineInputBorder(
                                //   borderRadius: BorderRadius.circular(10),
                                // ),
                                prefixIcon: Icon(Icons.lock),
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
                                onPressed: () {},
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
                        onPressed: () {},
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            "Se connecter",
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
