import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koumishop/pages/profil/adresse/nouvelle_adresse.dart';

class Panier extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Panier();
  }
}

class _Panier extends State<Panier> {
  //
  Map produit = {"nom": "Soupe", "logo": "cuisine2.jpg"};
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
          body: Column(
            children: [
              SizedBox(
                height: 50,
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
                              "Panier",
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
                flex: 4,
                child: ListView(
                  children: List.generate(
                    4,
                    (index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        height: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Expanded(
                            //   flex: 5,
                            //   child: ListTile(
                            //     leading: Card(
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(60),
                            //       ),
                            //       elevation: 2,
                            //       child: Container(
                            //         //padding: const EdgeInsets.symmetric(horizontal: 10),
                            //         //margin: const EdgeInsets.symmetric(horizontal: 10),
                            //         height: 50,
                            //         width: 50,
                            //         alignment: Alignment.center,
                            //         decoration: BoxDecoration(
                            //           image: DecorationImage(
                            //             image: ExactAssetImage(
                            //                 "assets/${produit['logo']}"),
                            //             fit: BoxFit.cover,
                            //           ),
                            //           color: Colors.white,
                            //           borderRadius:
                            //               BorderRadius.circular(25),
                            //           border: Border.all(
                            //             color: Colors.white,
                            //           ),
                            //         ),
                            //         //child: Image.asset("assets/${produit['logo']}"),
                            //       ),
                            //     ),
                            //     title: const Text(
                            //       "La banane Frécinette",
                            //     ),
                            //     subtitle: const Text(
                            //       "FC 5000",
                            //     ),
                            //   ),
                            // ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                              ),
                              elevation: 2,
                              child: Container(
                                //padding: const EdgeInsets.symmetric(horizontal: 10),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                ),
                                height: 70,
                                width: 70,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: ExactAssetImage(
                                        "assets/${produit['logo']}"),
                                    fit: BoxFit.cover,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(35),
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                ),
                                //child: Image.asset("assets/${produit['logo']}"),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "La banane Frécinette",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "FC  1000000",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ],
                                    )
                                    // const Expanded(
                                    //   flex: 5,
                                    //   child: Text(
                                    //     "La banane Frécinette",
                                    //     style: TextStyle(
                                    //       color: Colors.black,
                                    //       fontSize: 20,
                                    //       fontWeight: FontWeight.w300,
                                    //     ),
                                    //   ),
                                    // ),
                                    // Expanded(
                                    //   flex: 4,
                                    //   child: Text(
                                    //     "4 gm",
                                    //     style: GoogleFonts.comicNeue(
                                    //       color: Colors.black,
                                    //       fontSize: 20,
                                    //       fontWeight: FontWeight.normal,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 7,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Expanded(
                                              flex: 1,
                                              child: SizedBox(),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Container(
                                                //width: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        height: 26,
                                                        width: 26,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            13,
                                                          ),
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey.shade300,
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.remove,
                                                          size: 17,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      "2",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        height: 26,
                                                        width: 26,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .red.shade700,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            13,
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.add,
                                                          size: 17,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 1,
                                              child: SizedBox(),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "FC 1000000",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.red.shade700,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.delete_forever,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  height: Get.size.height / 2,
                  width: Get.size.width,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 232, 235),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Card(
                          elevation: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListTile(
                                leading: Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                ),
                                title: Text(
                                  "Veuillez sélectionner l'adresse de livraison",
                                  style: TextStyle(fontSize: 13),
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    //
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (c) {
                                        //return Details();
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height: 50,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 50,
                                                      child: Container(),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height: 50,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  IconButton(
                                                                    onPressed:
                                                                        () {
                                                                      Get.back();
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .arrow_back_ios,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                child:
                                                                    Container(),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 55,
                                              color: Colors.white,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Card(
                                                    elevation: 1,
                                                    color: Colors.red,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        25,
                                                      ),
                                                    ),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        Get.to(
                                                          NouvelleAdresse(),
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              ListTile(
                                  leading: Icon(
                                    Icons.calendar_month,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    "Veuillez sélectionner le jour de livraison",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      //
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now(),
                                      ).then(
                                        (value) => print(value),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.red,
                                    ),
                                  )),
                              ListTile(
                                leading: Icon(
                                  Icons.payment,
                                  color: Colors.red,
                                ),
                                title: Text(
                                  "Veuillez sélectionner le mode de paiement",
                                  style: TextStyle(fontSize: 13),
                                ),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Sous total",
                                      style: styleDeMenu(),
                                    ),
                                    Text(
                                      "10000 FC",
                                      style: styleDeMenu2(),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Frais de livraison",
                                      style: styleDeMenu(),
                                    ),
                                    Text(
                                      "2.55 FC",
                                      style: styleDeMenu2(),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total final",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w300,
                                        )),
                                    Text(
                                      "100000 FC",
                                      style: styleDeMenu2(),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
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
                              "CONFIRMER LA COMMANDE",
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
                        height: 5,
                      ),
                    ],
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
      fontSize: 15,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle styleDeMenu2() {
    return TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.normal,
    );
  }
}
