import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koumishop/controllers/cart_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:koumishop/controllers/time_slots_controller.dart';

// ignore: must_be_immutable
class TimeSlots extends GetView<TimeSlotsController> {
  State st;
  TimeSlots(this.st, {super.key}) {
    timeSlotsController.getTimeSlot();
    // ignore: invalid_use_of_protected_member
    cartController.deliveryDate.value["date"] =
        "${DateTime.now().day} ${DateTime.now().month} ${DateTime.now().year}";
  }

  RxBool choix = true.obs;
  RxString id = "".obs;
  Rx date = Rx(DateTime.now());
  RxBool autreJour = false.obs;
  CartController cartController = Get.find();
  TimeSlotsController timeSlotsController = Get.put(TimeSlotsController());

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
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              firstDay: DateTime.now(),
              lastDay: DateTime(
                DateTime.now().year + 1,
              ),
              focusedDay: date.value,
              onDaySelected: (d, t) {
                // ignore: invalid_use_of_protected_member
                cartController.deliveryDate.value["date"] =
                    "${d.day}-${d.month}-${d.year}";
                //
                autreJour.value = DateTime.now().isBefore(d);
                date.value = d;
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
                return Obx(
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
                              // ignore: invalid_use_of_protected_member
                              cartController.deliveryDate.value["heure"] =
                                  "${e['title']}";
                              Get.back();
                              Timer(const Duration(milliseconds: 500), () {
                                // ignore: invalid_use_of_protected_member
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
                );
              },
              onLoading: const Center(
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
