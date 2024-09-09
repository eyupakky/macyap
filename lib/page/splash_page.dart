import 'package:flutter/material.dart';
import 'package:halisaha/help/utils.dart';
import 'package:halisaha/page/login/add_phone.dart';
import 'package:lottie/lottie.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/controller/home_controller.dart';
import 'package:repository_eyup/controller/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final HomeController _homeController = HomeController();
  final LoginController _loginController = LoginController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      getAccessToken(context);
      // _notification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(color: Colors.red, "assets/test.png"),
                Lottie.asset("assets/images/footbaall.json"),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getAccessToken(BuildContext context) {
    bool isVerified = false;
    SharedPreferences.getInstance().then((value) {
      String? token = value.getString("accessToken");
      String? userName = value.getString("username");
      String? userId = value.getString("user_id");
      String? name = value.getString("firstname");
      String? surname = value.getString("lastname");
      String? image = value.getString("image");
      if (token != null && token != "") {
        Constant.accessToken = token;
        Constant.userName = userName!;
        Constant.name = name!;
        Constant.surname = surname!;
        Constant.image = image!;
        Constant.userId = int.parse('$userId');

        _loginController.phoneIsVerified(token).then(
          (data) {
            if (data["status"]) {
              isVerified = true;
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPhone(token: token),
                ),
              );
            }
          },
        ).catchError((err) {
          showToast(err, color: Colors.redAccent);
          isVerified = false;
        }).then(
          (_) {
            _homeController.getActiveControl().then((res) {
              if (res.success && isVerified) {
                Navigator.pushReplacementNamed(context, "/home");
              } else {
                value.clear();
                Navigator.pushReplacementNamed(context, "/loginwithnumber");
              }
            });
          },
        );
      } else {
        Navigator.pushReplacementNamed(context, "/loginwithnumber");
      }
    });
  }
}
