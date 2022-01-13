import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repository_eyup/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAccessToken(context);
    return SafeArea(
      child: Container(
        color: Colors.red,
        child: const Center(
            child: Text(
          "MAÇ YAP",
          style: TextStyle(fontSize: 26),
        )),
      ),
    );
  }

  void getAccessToken(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("accessToken");
    String? userName = preferences.getString("username");
    String? userId = preferences.getString("user_id");
    if (token != null && token != "") {
      Constant.accessToken = token;
      Constant.userName = userName!;
      Constant.userId = int.parse('$userId');
      Navigator.pushReplacementNamed(context, "/");
    } else {
      Navigator.pushReplacementNamed(context, "/login");
    }
  }
}
