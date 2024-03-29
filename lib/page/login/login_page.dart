import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halisaha/help/app_context.dart';
import 'package:halisaha/help/hex_color.dart';
import 'package:halisaha/help/ui_guide.dart';
import 'package:halisaha/help/utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/widget/custom_button.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/controller/account_controller.dart';
import 'package:repository_eyup/controller/login_controller.dart';
import "package:http/http.dart" as http;

// GoogleSignIn _googleSignIn = GoogleSignIn(
//   // Optional clientId
//   // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
//   scopes: <String>[
//     'email',
//     'https://www.googleapis.com/auth/contacts.readonly',
//   ],
// );

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
  // GoogleSignInAccount? _currentUser;
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    // _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
    //   setState(() {
    //     _currentUser = account;
    //   });
    //   if (_currentUser != null) {
    //     _handleGetContact(_currentUser!);
    //   }
    // });
    // _googleSignIn.signInSilently();
  }

  // Future<void> _handleGetContact(GoogleSignInAccount user) async {
  //   setState(() {
  //     _contactText = "Loading contact info...";
  //   });
  //   final http.Response response = await http.get(
  //     Uri.parse('https://people.googleapis.com/v1/people/me/connections'
  //         '?requestMask.includeField=person.names'),
  //     headers: await user.authHeaders,
  //   );
  //   if (response.statusCode != 200) {
  //     setState(() {
  //       _contactText = "People API gave a ${response.statusCode} "
  //           "response. Check logs for details.";
  //     });
  //     print('People API ${response.statusCode} response: ${response.body}');
  //     return;
  //   }
  //   final Map<String, dynamic> data = json.decode(response.body);
  //   final String? namedContact = _pickFirstNamedContact(data);
  //   setState(() {
  //     if (namedContact != null) {
  //       _contactText = "I see you know $namedContact!";
  //     } else {
  //       _contactText = "No contacts to display.";
  //     }
  //   });
  // }

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

  // Future<void> _handleSignIn() async {
  //   try {
  //     await _googleSignIn.signIn();
  //   } catch (error) {
  //     print(error);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    sizeConfig.init(context);
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.asset("assets/images/giris_ng.jpg").image,
              fit: BoxFit.fill)),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                UIGuide.pirpleLogo,
                height: SizeConfig.blockSizeVertical * 24,
                fit: BoxFit.fill,
              ),
            ),
            _emailFiled(),
          ],
        ),
      ),
    ));
  }

  Widget _emailFiled() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.only(top: 160, left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Üye girişi",
              style:
                  TextStyle(color: HexColor.fromHex("#f0243a"), fontSize: 25)),
          const SizedBox(
            height: 30,
          ),
          TextField(
            controller: emailController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                focusColor: Colors.black,
                hintText: "Email adresi",
                hintStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400, color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor))),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: passwordController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                  child: Icon(
                    Icons.remove_red_eye,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                hintText: "Şifre girin",
                fillColor: Colors.black,
                labelStyle: const TextStyle(color: Colors.white),
                hintStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400, color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor))),
            obscureText: passwordVisible,
          ),
          const SizedBox(height: 30),
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/forgatMyPassword");
              },
              child: _forgotPass()),
          const SizedBox(height: 40),
          CustomButton(
            height: 75,
            text: "GİRİŞ YAP",
            text2: "GİRİŞ YAP",
            textChange: false,
            assetName: "assets/images/giris_button.png",
            onClick: () {
              login();
            },
            key: UniqueKey(),
          ),
          const SizedBox(height: 10),
          Text(
            "Üyeliğiniz yok mu?",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 20),
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/register");
              },
              child: createUser("ÜYE OL!",true,FontWeight.bold)),
        const SizedBox(height: 50,),
          InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/help");
              },
              child: createUser("Yardım",false,FontWeight.normal)),
        ],

      ),

    );
  }

  Widget createUser(String text,bool icon,FontWeight fontWeight) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: 120,
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 90,
                child: Text(
                  text,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: fontWeight),
                ),
              ),
            ),
            Visibility(
              visible: icon,
              child: Icon(
                Icons.navigate_next,
                size: 24,
                color: HexColor.fromHex("#f0243a"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _forgotPass() {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        "Şifremi unuttum",
        style: GoogleFonts.roboto(
            fontSize: 14,
            color: HexColor.fromHex("#a06687"),
            fontWeight: FontWeight.w500),
      ),
    );
  }

  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //
  //   // Once signed in, return the UserCredential
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }

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
        Navigator.pushReplacementNamed(context, "/home");
      });
    }).catchError((err) {
      EasyLoading.dismiss();
      showToast(err, color: Colors.redAccent);
    });
  }
}
