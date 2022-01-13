import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halisaha/base_widget.dart';
import 'package:halisaha/help/app_context.dart';
import 'package:halisaha/help/ui_guide.dart';
import 'package:halisaha/help/utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:repository_eyup/controller/account_controller.dart';
import 'package:repository_eyup/controller/login_controller.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  SizeConfig sizeConfig = SizeConfig();

  BaseContext get appContext => ContextProvider.of(context)!.current;

  final LoginController _loginController = LoginController();
  final AccountController _accountController = AccountController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sizeConfig.init(context);
    return Scaffold(
      body: BaseWidget(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Stack(
            children: [
              Positioned(
                top: SizeConfig.blockSizeVertical * 2,
                left: SizeConfig.blockSizeHorizontal * 4,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 28),
                  child: Image.asset(
                    UIGuide.pirpleLogo,
                    height: SizeConfig.blockSizeVertical * 9.5,
                    width: SizeConfig.blockSizeHorizontal * 19,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 200, 150, 100),
                  child: tabs(),
                ),
              ),
              _emailFiled(),
            ],
          ),
        ),
      ),
    );
  }

  Widget tabs() {
    return DefaultTabController(
      length: 2,
      initialIndex: _selectedIndex,
      child: TabBar(
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, "/register");
          }
        },
        tabs: [
          Tab(
            child: Text(
              "Üye Girişi",
              style: GoogleFonts.montserrat(fontSize: 16),
            ),
          ),
          Tab(
            child: Text(
              "Üye Ol",
              style: GoogleFonts.montserrat(
                fontSize: 16,
              ),
            ),
          ),
        ],
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.grey,
      ),
    );
  }

  Widget _emailFiled() {
    return Container(
      margin: const EdgeInsets.all(40),
      padding: const EdgeInsets.only(top: 235, left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: emailController,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                focusColor: Colors.black,
                hintText: "Email adresi",
                hintStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w300, color: Colors.black),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 30),
          TextField(
            controller: passwordController,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.remove_red_eye,
                  color: Colors.grey,
                ),
                hintText: "Şifre girin",
                fillColor: Colors.black,
                labelStyle: const TextStyle(color: Colors.black),
                hintStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w300, color: Colors.black),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
            obscureText: true,
          ),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ignore: deprecated_member_use
              FlatButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 130),
                  onPressed: () {
                    login();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    "GİRİŞ YAP",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  color: Colors.blueGrey.withOpacity(0.9))
            ],
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Şununla giriş yap",
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: 50,
                  height: 50,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.facebookF,
                      color: Colors.black,
                    ),
                    color: Colors.blueGrey.withOpacity(0.9),
                  )),
              const SizedBox(width: 10),
              SizedBox(
                  width: 50,
                  height: 50,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.twitter,
                      color: Colors.black,
                    ),
                    color: Colors.blueGrey.withOpacity(0.9),
                  )),
              const SizedBox(width: 10),
              SizedBox(
                  width: 50,
                  height: 50,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.googlePlusG,
                      color: Colors.black,
                    ),
                    color: Colors.blueGrey.withOpacity(0.9),
                  )),
            ],
          ),
          const SizedBox(height: 40),
          _forgotPass()
        ],
      ),
    );
  }

  Widget _forgotPass() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Şifremi unuttum",
          style: GoogleFonts.roboto(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  void login() async {
    EasyLoading.show(status: 'loading...');
    _loginController
        .login(emailController.text, passwordController.text)
        .then((value) {
      appContext.setAccessToken(value);
      _accountController.getMyUser().then((value){
        appContext.setMyUser(value);
        Navigator.pushNamed(context, "/");
      });
    }).catchError((err) {
      EasyLoading.dismiss();
      showToast(err,color:Colors.redAccent);
    });
  }
}
