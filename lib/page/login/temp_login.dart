import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:halisaha/help/app_context.dart';
import 'package:halisaha/help/utils.dart';
import 'package:halisaha/widget/custom_text_field.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/controller/account_controller.dart';
import 'package:repository_eyup/controller/login_controller.dart';

class TempLogin extends StatefulWidget {
  const TempLogin({super.key});

  @override
  State<TempLogin> createState() => _TempLoginState();
}

class _TempLoginState extends State<TempLogin> {
  BaseContext get appContext => ContextProvider.of(context)!.current;
  final LoginController _loginController = LoginController();
  final AccountController _accountController = AccountController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = true;

  void login() async {
    FocusScope.of(context).unfocus();
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showToast("Lütfen tüm alanları doldurunuz.", color: Colors.redAccent);
      return;
    }

    _loginController
        .login(emailController.text, passwordController.text)
        .then((value) {
      appContext.setAccessToken(value);
      _accountController.getMyUser().then((value) {
        Constant.image = value.image!;
        Constant.userId = value.userId!;
        Constant.userName = value.username!;
        Constant.name = value.firstname!;
        Constant.surname = value.lastname!;
        appContext.setMyUser(value);

        Navigator.pushReplacementNamed(context, "/splash");
      });
    }).catchError((err) {
      showToast(err, color: Colors.redAccent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
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
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    CustomTextField(
                      nameController: emailController,
                      validate: AutovalidateMode.onUserInteraction,
                      hintText: "E-posta / Kullanıcı Adı",
                      icon: Icons.email,
                      textInputType: TextInputType.emailAddress,
                    ),
                    CustomTextField(
                      nameController: passwordController,
                      validate: AutovalidateMode.onUserInteraction,
                      hintText: "Şifre",
                      icon: Icons.lock,
                      passwordVisible: passwordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                      textInputType: TextInputType.emailAddress,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
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
                        onPressed: () => Navigator.pushReplacementNamed(
                            context, "/loginwithnumber"),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Telefon ile Giriş Yap",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: "Montserrat-bold",
                                  color: Colors.black),
                            ),
                          ],
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
                        onPressed: () =>
                            Navigator.pushNamed(context, "/newRegister"),
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
