import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koumishop/components/auth/forgot_password.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

// ignore: must_be_immutable
class ChangePasswordOTP extends StatelessWidget {
  String code;
  String number;
  String codeV;
  ChangePasswordOTP(this.code, this.number, this.codeV, {super.key});
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: AlertDialog(
        title: const Text("Tape votre code"),
        content: SizedBox(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: Text(code),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Text(number),
                  )
                ],
              ),
              SizedBox(
                height: 40,
                child: OTPTextField(
                  length: 6,
                  width: Get.size.width / 1.5,
                  fieldWidth: 30,
                  style: const TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.underline,
                  onCompleted: (co) async {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    var credential = PhoneAuthProvider.credential(
                        verificationId: codeV, smsCode: co);
                    auth.signInWithCredential(credential).then((result) {
                      Get.to(ForgotPassword(number)); //
                    }).catchError((e) {
                      Get.snackbar("Erreur", "Code non valide!");
                    });
                  },
                  onChanged: (pin) {
                    String c = pin;
                    if (kDebugMode) {
                      print("code2 $c");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
