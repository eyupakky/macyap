import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halisaha/help/utils.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/controller/firebase_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
      color: Colors.red,
      child: Center(child: Image.asset("assets/images/test.png")),
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
        Navigator.pushReplacementNamed(context, "/");
      } else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
  }
}
