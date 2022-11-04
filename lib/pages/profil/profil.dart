import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/retry.dart';
import 'package:koumishop/pages/accueil.dart';
import 'package:koumishop/pages/profil/autres/change_mdp.dart';
import 'package:koumishop/pages/profil/autres/faq.dart';
import 'package:koumishop/pages/profil/autres/politique.dart';
import 'package:koumishop/pages/profil/autres/termes.dart';
import 'package:koumishop/pages/profil/commande/commande.dart';
import 'package:koumishop/pages/profil/log/miseajour.dart';
import 'package:koumishop/pages/profil/notifications/notifications.dart';
import 'package:koumishop/pages/profil/profil_controller.dart';
import 'package:koumishop/utils/notification_service.dart';
import 'package:share_plus/share_plus.dart';
import 'adresse/adresse.dart';
import 'autres/apropos.dart';
import 'log/log.dart';
import 'package:http/http.dart' as http;

class Profil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Profil();
  }
}

class _Profil extends State<Profil> {
  //
  ProfilController profilController = Get.find();
  //
  //
  var box = GetStorage();
  //
  Future<void> initializeDefault() async {
    Firebase.initializeApp();
    //print('Initialized default app $app');
  }
  //

  NotificationService ns = NotificationService();
  //
  @override
  void initState() {
    //
    //initializeDefault();
    //
    super.initState();
  }

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
                              index.value = 0;
                              //
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
                const Padding(
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
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Obx(
                                () => profilController.infos['name'] == null
                                    ? Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          image: const DecorationImage(
                                            image: ExactAssetImage(
                                              "assets/logo_koumi_squared.png",
                                            ),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                      )
                                    : Stack(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.person,
                                                size: 55,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(0),
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    20,
                                                  ),
                                                ),
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.edit,
                                                    color: Colors.white,
                                                    size: 25,
                                                  ),
                                                  onPressed: () {
                                                    //
                                                    print("cool");
                                                    //
                                                    Get.to(MiseaJour());
                                                    //
                                                  },
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              "${profilController.infos['name'] ?? "Bienvenue"}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              "${profilController.infos['mobile'] != null ? profilController.infos['mobile'] : "S'identifier ou S'inscrire"}",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
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
                                      Map p = box.read("profile") ?? RxMap();
                                      if (p['name'] == null) {
                                        //
                                        Get.snackbar("Oups",
                                            "Creez un compte ou loggez-vous");
                                      } else {
                                        //
                                        Get.to(Commande(false));
                                      }
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
                                      Map p = box.read("profile") ?? RxMap();
                                      if (p['name'] == null) {
                                        //
                                        Get.snackbar("Oups",
                                            "Creez un compte ou loggez-vous");
                                      } else {
                                        //
                                        Get.to(Adresse());
                                      }
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
                                      Share.share(
                                          'https://play.google.com/store/apps/details?id=com.koumi.shop');
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
                                  Obx(
                                    () => profilController.infos['mobile'] ==
                                            null
                                        ? Container()
                                        : ListTile(
                                            onTap: () {
                                              //
                                              // showModalBottomSheet(
                                              //   context: context,
                                              //   shape:
                                              //       const RoundedRectangleBorder(
                                              //     borderRadius:
                                              //         BorderRadius.only(
                                              //       topLeft:
                                              //           Radius.circular(25),
                                              //       topRight:
                                              //           Radius.circular(25),
                                              //     ),
                                              //   ),
                                              //   builder: (c) {
                                              //     return ChangeMdp();
                                              //   },
                                              //   isScrollControlled: false,
                                              //   enableDrag: true,
                                              //   backgroundColor: Colors.white,
                                              // );
                                              showDialog(
                                                context: context,
                                                anchorPoint: const Offset(0, 0),
                                                builder: (c) {
                                                  return Material(
                                                    color: Colors.transparent,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        ChangeMdp(),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
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
                                      if (profilController.infos['mobile'] ==
                                          null) {
                                        Get.to(Log(this));
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (c) {
                                            return AlertDialog(
                                              title: Text("Déconnexion"),
                                              content: Text(
                                                  "Voulez-vous vraiment vous déconnecter ?"),
                                              actions: [
                                                IconButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    //
                                                    _logout();
                                                    //
                                                    profilController
                                                        .infos.value = {};
                                                    box.write("profile", null);
                                                    Timer(
                                                        const Duration(
                                                            microseconds: 500),
                                                        () {
                                                      setState(() {
                                                        Get.back();
                                                      });
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.check,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    },
                                    leading: Icon(
                                      profilController.infos['mobile'] == null
                                          ? CupertinoIcons.person_circle
                                          : Icons.exit_to_app,
                                      color: Colors.black,
                                    ),
                                    title: Obx(
                                      () => Text(
                                        profilController.infos['mobile'] == null
                                            ? "Se connecter"
                                            : "Se déconnecter",
                                        style: styleDeMenu(),
                                      ),
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
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () async {
          //     ns.setup(
          //         id: 1,
          //         title: "Salut tata",
          //         body: "Comment tu vas toi ?",
          //         payload: "");
          //   },
          //   child: const Icon(Icons.query_builder),
          // ),
        ),
      ),
    );
  }

  //
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
  //

  TextStyle styleDeMenu() {
    return const TextStyle(
      color: Colors.grey,
      fontSize: 13,
      fontWeight: FontWeight.normal,
    );
  }
}
