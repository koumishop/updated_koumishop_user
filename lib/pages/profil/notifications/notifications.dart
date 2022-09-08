import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koumishop/pages/accueil.dart';

class Notifications extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Notifications();
  }
}

class _Notifications extends State<Notifications> {
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
                        width: 200,
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
                              "Notifications",
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
                  child: ListView(
                    children: List.generate(5, (index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: ListTile(
                              title: Text("UDHlui hdui"),
                              subtitle: Text("7700 FC"),
                              trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ),
                          )
                        ],
                      );
                    }),
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
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
}
