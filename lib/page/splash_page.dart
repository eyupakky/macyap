import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halisaha/help/utils.dart';
import 'package:repository_eyup/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAccessToken(context);
    _notification();
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
  _notification() async {
    FirebaseMessaging.instance.getToken().then((value) => print(value));
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        showToast(value.toString());
      }
    });
    await FirebaseMessaging.instance.subscribeToTopic('all');
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      showToast(message.data["video_id"]);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showToast('${message.notification!.body}');
      }
    });
  }
  void getAccessToken(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("accessToken");
    String? userName = preferences.getString("username");
    String? userId = preferences.getString("user_id");
    String? name = preferences.getString("firstname");
    String? surname = preferences.getString("lastname");
    String? image = preferences.getString("image");
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
  }
}
