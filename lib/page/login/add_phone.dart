import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halisaha/help/utils.dart';
import 'package:halisaha/page/login/confirm_page.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lottie/lottie.dart';
import 'package:repository_eyup/controller/login_controller.dart';

class AddPhone extends StatefulWidget {
  final String? token;
  final bool? isLogin;
  const AddPhone({super.key, this.token, this.isLogin});

  @override
  State<AddPhone> createState() => _AddPhoneState();
}

class _AddPhoneState extends State<AddPhone> {
  final LoginController _loginController = LoginController();
  PhoneNumber number = PhoneNumber(isoCode: 'TR');
  bool isPhoneValid = false;
  String phoneNumber = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                  child: IconButton(
                    alignment: Alignment.centerLeft,
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      if (widget.isLogin ?? false) {
                        Navigator.pushReplacementNamed(
                            context, "/loginwithnumber");
                      } else {
                        Navigator.pushReplacementNamed(context, "/home");
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            "Devam etmek için telefon numaranızı güncelleyin"),
                        Lottie.asset("assets/images/phone.json"),
                        FadeInRight(
                          child: InternationalPhoneNumberInput(
                            locale: "tr_TR",
                            countries: const ["TR"],
                            onInputChanged: (PhoneNumber number) {
                              phoneNumber = number.phoneNumber!;
                            },
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.DIALOG,
                              trailingSpace: false,
                            ),
                            initialValue: number,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            inputDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                              hintText: "Cep telefonunuz",
                              hintStyle: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputBorder: const OutlineInputBorder(),
                            onInputValidated: (value) => isPhoneValid = value,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (isPhoneValid) {
                              _loginController
                                  .phoneVerification(phoneNumber, widget.token!)
                                  .then(
                                (value) {
                                  if (value["isSuccess"]) {
                                    value.putIfAbsent(
                                        "phoneNumber", () => phoneNumber);

                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ConfirmPage(data: value);
                                    }));
                                  } else {
                                    showToast(value["message"],
                                        color: Colors.redAccent);
                                  }
                                },
                              ).catchError((err) {
                                showToast(err, color: Colors.redAccent);
                              });
                            } else {
                              showToast(
                                  "Lütfen geçerli bir telefon numarası girin",
                                  color: Colors.redAccent);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const SizedBox(
                            width: 150,
                            child: Center(
                              child: Text("Devam Et",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
