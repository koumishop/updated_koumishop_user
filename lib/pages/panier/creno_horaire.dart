import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:koumishop/pages/panier/panier_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import 'creno_controller.dart';

class CrenoHoraire extends GetView<CrenoHoraireController> {
  State st;
  CrenoHoraire(this.st) {
    controller.getCrenoHoraire();
    panierController.dateL.value["date"] =
        "${DateTime.now().day} ${DateTime.now().month} ${DateTime.now().year}";
  }
  //
  RxBool choix = true.obs;
  RxString id = "".obs;
  Rx date = Rx(DateTime.now());
  RxBool autreJour = false.obs;
  //
  PanierController panierController = Get.find();

  //
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 7,
          child: Obx(
            () => TableCalendar(
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) {
                //autreJour.value =
                return isSameDay(day, date.value);
              },
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              //initialCalendarFormat: CalendarFormat.month,
              firstDay: DateTime.now(),
              lastDay: DateTime(
                DateTime.now().year + 1,
              ),

              focusedDay: date.value,
              onDaySelected: (d, t) {
                //
                panierController.dateL.value["date"] =
                    "${d.day}-${d.month}-${d.year}";
                //
                autreJour.value = DateTime.now().isBefore(d);
                date.value = d;
                print(":::${autreJour.value}:::");
              },
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            child: controller.obx(
              (state) {
                List l = state!;
                return Container(
                  child: Obx(
                    () => ListView(
                      children: List.generate(l.length, (i) {
                        Map e = l[i];

                        bool s = int.parse('${e['from_time']}'.split(":")[0]) >
                            DateTime.now().hour;

                        return ListTile(
                          leading: Checkbox(
                            onChanged: (c) {
                              if (autreJour.value ||
                                  int.parse('${e['from_time']}'.split(":")[0]) >
                                      DateTime.now().hour) {
                                choix.value = true;
                                s = true;
                                id.value = '${e['from_time']}';

                                panierController.dateL.value["heure"] =
                                    "${e['title']}";
                                //
                                print("close");
                                Get.back();
                                Timer(Duration(milliseconds: 500), () {
                                  //
                                  st.setState(() {});
                                });
                              }
                            },
                            // ignore: unrelated_type_equality_checks
                            value: id == '${e['from_time']}',
                          ),
                          title: Text(
                            "${e['title']}",
                            style: TextStyle(
                              color: autreJour.value || s
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                );
              },
              onLoading: Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              ),
              onEmpty: Container(),
            ),
          ),
        ),
      ],
    );
  }
}
