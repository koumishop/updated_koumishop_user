import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:koumishop/screens/homepage.dart';
import 'package:koumishop/components/users/change_password.dart';
import 'package:koumishop/components/users/faq.dart';
import 'package:koumishop/components/users/policy.dart';
import 'package:koumishop/components/users/terms.dart';
import 'package:koumishop/screens/orders.dart';
import 'package:koumishop/components/users/update_user.dart';
import 'package:koumishop/components/users/notifications.dart';
import 'package:koumishop/controllers/profile_controller.dart';
import 'package:koumishop/utils/notification_service.dart';
import 'package:share_plus/share_plus.dart';
import 'package:koumishop/components/adress/user_adress.dart';
import 'package:koumishop/components/users/about.dart';
import 'package:koumishop/screens/login.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Profile();
  }
}

class _Profile extends State<Profile> {
  ProfilController profilController = Get.find();
  var box = GetStorage();
  Future<void> initializeDefault() async {
    Firebase.initializeApp();
  }

  NotificationService ns = NotificationService();

  @override
  void initState() {
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
          backgroundColor: const Color.fromARGB(255, 255, 232, 235),
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
                                children: const [
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
                  padding: const EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
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
                                () => profilController.data['name'] == null
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
                                            padding: const EdgeInsets.all(0),
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
                                                    Get.to(const UpdateUser());
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
                              "${profilController.data['name'] ?? "Bienvenue"}",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          Obx(
                            () => Text(
                              "${profilController.data['mobile'] ?? "S'identifier ou S'inscrire"}",
                              style: const TextStyle(
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
                                  const SizedBox(),
                                  ListTile(
                                    onTap: () {
                                      index.value = 0;
                                      if (controllerP!.hasClients) {
                                        controllerP!.animateToPage(
                                          0,
                                          duration: const Duration(seconds: 1),
                                          curve: Curves.ease,
                                        );
                                      }
                                    },
                                    leading: const Icon(
                                      CupertinoIcons.home,
                                      color: Colors.black,
                                    ),
                                    title: Text(
                                      "Accueil",
                                      style: styleDeMenu(),
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Map p = box.read("profile") ?? RxMap();
                                      if (p['name'] == null) {
                                        Get.snackbar("Oups",
                                            "Creez un compte ou loggez-vous");
                                      } else {
                                        Get.to(Orders(false));
                                      }
                                    },
                                    leading: const Icon(
                                      Icons.delivery_dining_outlined,
                                      color: Colors.black,
                                    ),
                                    title: Text(
                                      "Vos commandes",
                                      style: styleDeMenu(),
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Map p = box.read("profile") ?? RxMap();
                                      if (p['name'] == null) {
                                        Get.snackbar("Oups",
                                            "Creez un compte ou loggez-vous");
                                      } else {
                                        Get.to(const UserAdress());
                                      }
                                    },
                                    leading: const Icon(
                                      CupertinoIcons.location,
                                      color: Colors.black,
                                    ),
                                    title: Text(
                                      "Adresse de livraisons",
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
                                      Share.share(
                                          'https://play.google.com/store/apps/details?id=com.koumi.shop');
                                    },
                                    leading: const Icon(
                                      Icons.share,
                                      color: Colors.black,
                                    ),
                                    title: Text(
                                      "Partage application",
                                      style: styleDeMenu(),
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                    ),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Get.to(const Notifications());
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
                                    () => profilController.data['mobile'] ==
                                            null
                                        ? Container()
                                        : ListTile(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                anchorPoint: const Offset(0, 0),
                                                builder: (c) {
                                                  return Material(
                                                    color: Colors.transparent,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: const [
                                                        ChangePassword(),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            leading: const Icon(
                                              Icons.lock_outline,
                                              color: Colors.black,
                                            ),
                                            title: Text(
                                              "Modifier le mot de passe ?",
                                              style: styleDeMenu(),
                                            ),
                                            trailing: const Icon(
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
                                                    Get.to(const About());
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
                                                    Get.to(const Faq());
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
                                                    Get.to(const Terms());
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
                                                    Get.to(const Policy());
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
                                      if (profilController.data['mobile'] ==
                                          null) {
                                        Get.to(LoginScreen(this));
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (c) {
                                            return AlertDialog(
                                              title: const Text("Déconnexion"),
                                              content: const Text(
                                                  "Voulez-vous vraiment vous déconnecter ?"),
                                              actions: [
                                                IconButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  icon: const Icon(
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
                                                        .data.value = {};
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
                                      profilController.data['mobile'] == null
                                          ? CupertinoIcons.person_circle
                                          : Icons.exit_to_app,
                                      color: Colors.black,
                                    ),
                                    title: Obx(
                                      () => Text(
                                        profilController.data['mobile'] == null
                                            ? "Se connecter"
                                            : "Se déconnecter",
                                        style: styleDeMenu(),
                                      ),
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                    ),
                                  ),
                                  Obx(
                                    () => profilController.data['mobile'] !=
                                            null
                                        ? ListTile(
                                            onTap: () {
                                              //
                                              if (profilController
                                                      .data['mobile'] ==
                                                  null) {
                                                Get.to(LoginScreen(this));
                                              } else {
                                                showDialog(
                                                  context: context,
                                                  builder: (c) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Suppression"),
                                                      content: const Text(
                                                          "Voulez-vous vraiment supprimer votre compte ?"),
                                                      actions: [
                                                        IconButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          icon: const Icon(
                                                            Icons.close,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            _suppression();
                                                            profilController
                                                                .data
                                                                .value = {};
                                                            box.write("profile",
                                                                null);
                                                            Timer(
                                                                const Duration(
                                                                    microseconds:
                                                                        500),
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
                                            leading: const Icon(
                                              Icons.delete_forever,
                                              color: Colors.black,
                                            ),
                                            title: Text(
                                              "Suppression de compte",
                                              style: styleDeMenu(),
                                            ),
                                            trailing: const Icon(
                                              Icons.arrow_forward_ios,
                                              size: 20,
                                            ),
                                          )
                                        : Container(),
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
      ),
    );
  }

  //
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  //
  Future<void> _suppression() async {
    try {
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
        'type': 'delete-profile',
        'user_id': '${profilController.data['user_id']}',
        'email': '${profilController.data['email']}',
        'mobile': '${profilController.data['mobile']}'
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Get.snackbar("Compte", "Votre compte a été supprimé avec succès.");
        _logout();
        index = 0.obs; //Accueil
      } else {
        Get.snackbar("Erreur", "${response.reasonPhrase}.");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
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
