import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halisaha/help/app_context.dart';
import 'package:halisaha/help/utils.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import 'package:repository_eyup/controller/account_controller.dart';
// import 'package:repository_eyup/controller/new_login_controller.dart';

class LoginWithNumber extends StatefulWidget {
  const LoginWithNumber({super.key});

  @override
  State<LoginWithNumber> createState() => _LoginWithNumberState();
}

class _LoginWithNumberState extends State<LoginWithNumber> {
  String phoneNumber = "";
  PhoneNumber number = PhoneNumber(isoCode: 'TR');

  // final NewLoginController _newLoginController = NewLoginController();
  // final AccountController _accountController = AccountController();
  BaseContext get appContext => ContextProvider.of(context)!.current;
  bool isPhoneValid = false;

  @override
  Widget build(BuildContext context) {
    void login() async {
      EasyLoading.show(status: "Giriş yapılıyor...");
      if (isPhoneValid) {
        EasyLoading.dismiss();
        Navigator.pushNamed(context, "/otp",
            arguments: {"phoneNumber": phoneNumber});
      } else {
        EasyLoading.dismiss();
        showToast('Geçersiz Telefon Numarası', color: Colors.redAccent);
      }

      // _newLoginController.login(phoneNumber).then((value) {
      //   appContext.setAccessToken(value);

      //   _accountController.getMyUser().then((value) {
      //     Constant.image = value.image!;
      //     Constant.userId = value.userId!;
      //     Constant.userName = value.username!;
      //     Constant.name = value.firstname!;
      //     Constant.surname = value.lastname!;
      //     appContext.setMyUser(value);
      //     Navigator.pushReplacementNamed(context, "/home");
      //   });
      // }).catchError((err) {
      //   EasyLoading.dismiss();
      //   showToast(err, color: Colors.redAccent);
      // });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 500,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Image.asset(
                        color: Colors.red, 'assets/images/background.png'),
                  ),
                  // Positioned(
                  //   left: 30,
                  //   width: 80,
                  //   height: 200,
                  //   child: FadeInUp(
                  //       duration: const Duration(seconds: 1),
                  //       child: Container(
                  //         decoration: const BoxDecoration(
                  //             image: DecorationImage(
                  //                 image: AssetImage(
                  //                     'assets/images/football.png'))),
                  //       )),
                  // ),
                  // Positioned(
                  //   left: 140,
                  //   width: 80,
                  //   height: 150,
                  //   child: FadeInUp(
                  //     duration: const Duration(milliseconds: 1200),
                  //     child: Container(
                  //       decoration: const BoxDecoration(
                  //           image: DecorationImage(
                  //               image:
                  //                   AssetImage('assets/images/football.png'))),
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                    top: 40,
                    right: 50,
                    left: 50,
                    height: 150,
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 1300),
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/logo.png'))),
                      ),
                    ),
                  ),
                  Positioned(
                    child: FadeInUp(
                        duration: const Duration(milliseconds: 1600),
                        child: const Center(
                          child: Text(
                            "Giriş Yap",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  FadeInRight(
                    child: InternationalPhoneNumberInput(
                      locale: "tr_TR",
                      onInputChanged: (PhoneNumber number) {
                        phoneNumber = number.phoneNumber!;
                      },
                      selectorConfig: const SelectorConfig(
                          leadingPadding: 10,
                          selectorType: PhoneInputSelectorType.DIALOG,
                          trailingSpace: false),
                      initialValue: number,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      inputDecoration: InputDecoration(
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
                  const SizedBox(height: 50),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1900),
                    child: GestureDetector(
                      onTap: () => login(),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [
                              Colors.red,
                              Color.fromRGBO(255, 165, 165, 1),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Giriş Yap",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FadeInUp(
                    duration: const Duration(milliseconds: 2000),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/newRegister");
                      },
                      child: const Text("Üye değil misin?",
                          style: TextStyle(color: Colors.red)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
