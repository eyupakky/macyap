import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/controller/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final HomeController _homeController = HomeController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      getAccessToken(context);
      // _notification();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.asset("assets/images/giris_ng.jpg").image,
              fit: BoxFit.fill)),
      child: Center(child: Image.asset("assets/test.png")),
    );
  }

  void getAccessToken(BuildContext context) {
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
        _homeController.getActiveControl().then((res) {
          if(res.success){
            Navigator.pushReplacementNamed(context, "/home");
          } else{
            value.clear();
            Navigator.pushReplacementNamed(context, "/login");
          }
        });

      } else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
  }
}
