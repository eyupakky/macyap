import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halisaha/help/ui_guide.dart';
import 'package:halisaha/help/utils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  SizeConfig sizeConfig = SizeConfig();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sizeConfig.init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            // Container(
            //   height: MediaQuery.of(context).size.height,
            //   width: double.infinity,
            // child: Opacity(
            //   opacity: .4,
            //   child:
            //   Image.asset(
            //     UIGuide.pirpleImg,
            //     height: SizeConfig.blockSizeVertical * 100,
            //     width: SizeConfig.blockSizeHorizontal * 100,
            //     fit: BoxFit.fitHeight,
            //   ),
            // ),
            // ),
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
    );
  }
}

Widget tabs() {
  return DefaultTabController(
    length: 2,
    child: TabBar(
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
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              focusColor: Colors.white,
              hintText: "Email adresi",
              hintStyle: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w300, color: Colors.white),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 30),
        TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              suffixIcon: const Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
              hintText: "Şifre girin",
              fillColor: Colors.white,
              labelStyle: const TextStyle(color: Colors.white),
              hintStyle: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w300, color: Colors.white),
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
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 130),
                onPressed: () {},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Text(
                  "GİRİŞ YAP",
                  style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.white,
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
                  color: Colors.white,
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
                    color: Colors.white,
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
                    color: Colors.white,
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
                    color: Colors.white,
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
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
      ),
    ],
  );
}
