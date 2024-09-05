import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halisaha/help/utils.dart';
import 'package:halisaha/page/login/confirm_page.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:repository_eyup/controller/login_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginWithNumber extends StatefulWidget {
  const LoginWithNumber({super.key});

  @override
  State<LoginWithNumber> createState() => _LoginWithNumberState();
}

class _LoginWithNumberState extends State<LoginWithNumber> {
  String phoneNumber = "";
  bool isPhoneValid = false;
  PhoneNumber number = PhoneNumber(isoCode: 'TR');
  final LoginController _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    void login() async {
      EasyLoading.show(status: "Giriş yapılıyor...");

      if (isPhoneValid) {
        _loginController.loginWithPhone(phoneNumber).then((value) {
          if (value["isSuccess"] ?? false) {
            value.putIfAbsent("phoneNumber", () => phoneNumber);
            EasyLoading.dismiss();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return ConfirmPage(data: value);
            }));
          } else {
            EasyLoading.dismiss();
            showToast(value["message"] ?? "Giriş Başarısız",
                color: Colors.redAccent);
          }
        }).catchError((onError) {
          EasyLoading.dismiss();
          showToast(onError, color: Colors.redAccent);
        });
      } else {
        EasyLoading.dismiss();
        showToast('Geçersiz Telefon Numarası', color: Colors.redAccent);
      }
    }

    return PopScope(
      child: Scaffold(
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
                          fit: BoxFit.cover,
                          color: Colors.red,
                          'assets/images/background.png'),
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
                        countries: const ["TR"],
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
                    FadeInRight(
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
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          minimumSize: const Size(40, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          String path =
                              "https://macyap.com.tr/tr/account/settings#tel";

                          Uri uri = Uri.parse(path);
                          launchUrl(uri);
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: "Telefon numaran mı yok? ",
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontFamily: "Montserrat-bold"),
                            children: [
                              TextSpan(
                                text: "Sitemizden ekle",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "Montserrat-bold",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    FadeInUp(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          minimumSize: const Size(40, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, "/newRegister");
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: "Hesabınız yok mu? ",
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: "Montserrat-bold",
                                color: Colors.black),
                            children: [
                              TextSpan(
                                text: "Üye Ol",
                                style: TextStyle(
                                    fontFamily: "Montserrat-bold",
                                    color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
