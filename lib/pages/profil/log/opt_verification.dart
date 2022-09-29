import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koumishop/pages/profil/log/inscription.dart';
import 'package:koumishop/pages/profil/log/mdp_oublie.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OptVerification extends StatelessWidget {
  String code;
  String number;
  String codeV;
  bool ins;
  //ConfirmationResult confirmationResult;
  //
  OptVerification(this.code, this.number, this.codeV, this.ins);
  //
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: AlertDialog(
        title: Text("Tape votre code"),
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
                  style: TextStyle(fontSize: 17),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.underline,
                  onCompleted: (co) async {
                    print("code1 $co == $codeV");
                    FirebaseAuth auth = FirebaseAuth.instance;
                    var _credential = PhoneAuthProvider.credential(
                        verificationId: codeV, smsCode: co);
                    auth.signInWithCredential(_credential).then((result) {
                      //
                      if (ins) {
                        Get.to(Inscription("$code$number")); //
                      } else {
                        Get.to(MdpOublie()); //
                      }
                      //
                    }).catchError((e) {
                      print("auth: $e");
                      Get.snackbar("Erreur", "Code non valide!");
                      print(e);
                    });
                    // if (co == codeV) {
                    //   print("code pareil $code");
                    //   Get.back();
                    //   Get.back();
                    //   Get.to(Inscription());
                    // }
                  },
                  onChanged: (pin) {
                    String c = pin;
                    print("code2 $c");
                  },
                ),
              ),
              // ElevatedButton(
              //   style: ButtonStyle(
              //     elevation: MaterialStateProperty.all(0),
              //     padding: MaterialStateProperty.all(
              //       const EdgeInsets.symmetric(
              //         horizontal: 20,
              //       ),
              //     ),
              //     shape: MaterialStateProperty.all(
              //       RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(20),
              //       ),
              //     ),
              //     backgroundColor: MaterialStateProperty.all(
              //       Colors.red,
              //     ),
              //     overlayColor: MaterialStateProperty.all(
              //       Colors.red.shade100,
              //     ),
              //   ),
              //   onPressed: (){},
              //   child: Container(
              //     height: 50,
              //     margin: const EdgeInsets.symmetric(
              //       horizontal: 20,
              //     ),
              //     alignment: Alignment.center,
              //     child: const Text(
              //       "Vérifier OTP",
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 17,
              //         fontWeight: FontWeight.w400,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
