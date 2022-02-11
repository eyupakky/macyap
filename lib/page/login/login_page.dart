import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:halisaha/base_widget.dart';
import 'package:halisaha/help/app_context.dart';
import 'package:halisaha/help/ui_guide.dart';
import 'package:halisaha/help/utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/controller/account_controller.dart';
import 'package:repository_eyup/controller/login_controller.dart';
import "package:http/http.dart" as http;

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

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
  bool passwordVisible = true;

  // late GoogleSignIn _googleSignIn;
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = "Loading contact info...";
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = "People API gave a ${response.statusCode} "
            "response. Check logs for details.";
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = "I see you know $namedContact!";
      } else {
        _contactText = "No contacts to display.";
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'];
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
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
              Center(
                child: Image.asset(
                  UIGuide.pirpleLogo,
                  height: SizeConfig.blockSizeVertical * 18,
                  fit: BoxFit.fill,
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
        labelColor: Colors.redAccent,
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
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      passwordVisible =!passwordVisible;
                    });
                  },
                  child: const Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                ),
                hintText: "Şifre girin",
                fillColor: Colors.black,
                labelStyle: const TextStyle(color: Colors.black),
                hintStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w300, color: Colors.black),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
            obscureText: passwordVisible,
          ),
          const SizedBox(height: 30),
          FlatButton(
              height: 40,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 60),
              onPressed: () {
                login();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                "GİRİŞ YAP",
                style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              color: Colors.redAccent.withOpacity(0.9)),
          // const SizedBox(height: 50),
          // Text(
          //   "Şununla giriş yap",
          //   style: GoogleFonts.roboto(
          //       fontSize: 16,
          //       color: Colors.black,
          //       fontWeight: FontWeight.w500),
          // ),
          // const SizedBox(height: 30),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     SizedBox(
          //         width: 50,
          //         height: 50,
          //         // ignore: deprecated_member_use
          //         child: FlatButton(
          //           onPressed: () {
          //             signInWithFacebook().then((value){
          //               print(value.toString());
          //             });
          //           },
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10.0),
          //           ),
          //           child: const FaIcon(
          //             FontAwesomeIcons.facebookF,
          //             color: Colors.black,
          //           ),
          //           color: Colors.blueGrey.withOpacity(0.9),
          //         )),
          //     const SizedBox(width: 10),
          //     SizedBox(
          //         width: 50,
          //         height: 50,
          //         // ignore: deprecated_member_use
          //         child: FlatButton(
          //           onPressed: () {},
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10.0),
          //           ),
          //           child: const FaIcon(
          //             FontAwesomeIcons.twitter,
          //             color: Colors.black,
          //           ),
          //           color: Colors.blueGrey.withOpacity(0.9),
          //         )),
          //     const SizedBox(width: 10),
          //     SizedBox(
          //         width: 50,
          //         height: 50,
          //         // ignore: deprecated_member_use
          //         child: FlatButton(
          //           onPressed: () {
          //             _handleSignIn();
          //           },
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(10.0),
          //           ),
          //           child: const FaIcon(
          //             FontAwesomeIcons.googlePlusG,
          //             color: Colors.black,
          //           ),
          //           color: Colors.blueGrey.withOpacity(0.9),
          //         )),
          //   ],
          // ),
          const SizedBox(height: 40),
          //TODO şifremi unuttum
          //_forgotPass()
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
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  void login() async {
    EasyLoading.show(status: 'loading...');
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
        Navigator.pushReplacementNamed(context, "/");
      });
    }).catchError((err) {
      EasyLoading.dismiss();
      showToast(err, color: Colors.redAccent);
    });
  }
}
