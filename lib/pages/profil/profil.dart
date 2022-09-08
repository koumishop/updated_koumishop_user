import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koumishop/pages/accueil.dart';
import 'package:koumishop/pages/profil/autres/faq.dart';
import 'package:koumishop/pages/profil/autres/politique.dart';
import 'package:koumishop/pages/profil/autres/termes.dart';
import 'package:koumishop/pages/profil/notifications/notifications.dart';

import 'adresse/adresse.dart';
import 'autres/apropos.dart';
import 'log/log.dart';

class Profil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Profil();
  }
}

class _Profil extends State<Profil> {
  //
  final _formKey = GlobalKey<FormState>();

  final numeroC = TextEditingController();
  //
  final pwNC = TextEditingController();
  //
  final pwC = TextEditingController();
  //
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
          backgroundColor: Color.fromARGB(255, 255, 232, 235),
          //appBar: AppBar(),
          body: Stack(
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
                            index.value = 0;
                            //
                            controllerP!.animateToPage(
                              0,
                              duration: const Duration(seconds: 1),
                              curve: Curves.ease,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            width: 100,
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
                                  "Profil",
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
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    //height: 150,
                    //width: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
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
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                        Text(
                          "Bienvenue",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          "S'identifier ou S'inscrire",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                    //height: 100,
                                    ),
                                ListTile(
                                  onTap: () {
                                    //
                                    index.value = 0;
                                    //
                                    controllerP!.animateToPage(
                                      0,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.ease,
                                    );
                                  },
                                  leading: Icon(
                                    CupertinoIcons.home,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    "Accueil",
                                    style: styleDeMenu(),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    //
                                  },
                                  leading: Icon(
                                    Icons.delivery_dining_outlined,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    "Vos commandes",
                                    style: styleDeMenu(),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    //
                                    Get.to(Adresse());
                                    //
                                  },
                                  leading: Icon(
                                    CupertinoIcons.location,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    "Adresse de livraisons",
                                    style: styleDeMenu(),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    //
                                  },
                                  leading: Icon(
                                    Icons.share,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    "Partage application",
                                    style: styleDeMenu(),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    //
                                    Get.to(Notifications());
                                    //
                                  },
                                  leading: const Icon(
                                    Icons.notifications_outlined,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    "Notifications",
                                    style: styleDeMenu(),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    //
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (c) {
                                        return Container(
                                          padding: const EdgeInsets.all(30),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(25),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              const Text(
                                                "Modifier le mot de passe ?",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 25,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Form(
                                                key: _formKey,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText:
                                                            "Ancien mot de passe",
                                                        // border: OutlineInputBorder(
                                                        //   borderRadius: BorderRadius.circular(10),
                                                        // ),
                                                        prefixIcon:
                                                            Icon(Icons.lock),
                                                      ),
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Veuillez saisir le mot de passe";
                                                        }
                                                        return null;
                                                      },
                                                      controller: numeroC,
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText:
                                                            "Nouveau mot de passe",
                                                        // border: OutlineInputBorder(
                                                        //   borderRadius: BorderRadius.circular(10),
                                                        // ),
                                                        prefixIcon:
                                                            Icon(Icons.lock),
                                                      ),
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return "Veuillez saisir le mot de passe";
                                                        }
                                                        return null;
                                                      },
                                                      controller: pwNC,
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText:
                                                            "Confirm mot de passe",
                                                        // border: OutlineInputBorder(
                                                        //   borderRadius: BorderRadius.circular(10),
                                                        // ),
                                                        prefixIcon:
                                                            Icon(Icons.lock),
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
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 0),
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(
                                                          elevation:
                                                              MaterialStateProperty
                                                                  .all(0),
                                                          shape:
                                                              MaterialStateProperty
                                                                  .all(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                          ),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                            Colors.red,
                                                          ),
                                                          overlayColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                            Colors.red.shade100,
                                                          ),
                                                        ),
                                                        onPressed: () {},
                                                        child: Container(
                                                          height: 50,
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                            "Modifier le mot de passe",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
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
                                            ],
                                          ),
                                        );
                                      },
                                      backgroundColor: Colors.transparent,
                                    );
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (c) {
                                    //     return Material(
                                    //       color: Colors.transparent,
                                    //       child: Column(),
                                    //     );
                                    //   },
                                    // );
                                  },
                                  leading: Icon(
                                    Icons.lock_outline,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    "Modifier le mot de passe ?",
                                    style: styleDeMenu(),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  ),
                                ),
                                ListTile(
                                  onTap: () {
                                    //
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (c) {
                                        return Container(
                                          height: 250,
                                          padding: const EdgeInsets.all(13),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(25),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              ListTile(
                                                onTap: () {
                                                  //
                                                  Get.to(Apropos());
                                                  //
                                                },
                                                leading: const Icon(
                                                  Icons.info_outline,
                                                  color: Colors.black,
                                                  size: 30,
                                                ),
                                                title: Text(
                                                  "A propos de nous",
                                                  style: styleDeMenu(),
                                                ),
                                                trailing: const Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 20,
                                                ),
                                              ),
                                              ListTile(
                                                onTap: () {
                                                  //
                                                  Get.to(Faq());
                                                  //
                                                },
                                                leading: const Icon(
                                                  Icons.messenger,
                                                  color: Colors.black,
                                                ),
                                                title: Text(
                                                  "FAQ",
                                                  style: styleDeMenu(),
                                                ),
                                                trailing: const Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 20,
                                                ),
                                              ),
                                              ListTile(
                                                onTap: () {
                                                  //
                                                  Get.to(Termes());
                                                  //
                                                },
                                                leading: const Icon(
                                                  Icons.edit_calendar,
                                                  color: Colors.black,
                                                ),
                                                title: Text(
                                                  "Termes et conditions",
                                                  style: styleDeMenu(),
                                                ),
                                                trailing: const Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 20,
                                                ),
                                              ),
                                              ListTile(
                                                onTap: () {
                                                  //
                                                  Get.to(Politique());
                                                  //
                                                },
                                                leading: const Icon(
                                                  Icons.security,
                                                  color: Colors.black,
                                                ),
                                                title: Text(
                                                  "Politique de confidentialité",
                                                  style: styleDeMenu(),
                                                ),
                                                trailing: const Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 20,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  leading: const Icon(
                                    Icons.more_vert,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    "Plus",
                                    style: styleDeMenu(),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  ),
                                ),
                                const Divider(),
                                ListTile(
                                  onTap: () {
                                    //
                                    Get.to(Log());
                                  },
                                  leading: Icon(
                                    CupertinoIcons.person_circle,
                                    color: Colors.black,
                                  ),
                                  title: Text(
                                    "Se connecter",
                                    style: styleDeMenu(),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
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

  TextStyle styleDeMenu() {
    return TextStyle(
      color: Colors.grey,
      fontSize: 13,
      fontWeight: FontWeight.normal,
    );
  }
}
