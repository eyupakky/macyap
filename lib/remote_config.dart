import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halisaha/page/splash_page.dart';
import 'package:repository_eyup/constant.dart';

class RemoteConfigPage extends StatefulWidget {
  @override
  _RemoteConfigPageState createState() => _RemoteConfigPageState();
}

class _RemoteConfigPageState extends State<RemoteConfigPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<FirebaseRemoteConfig> setupRemoteConfig() async {
    await Firebase.initializeApp();
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 3),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await remoteConfig.setDefaults(<String, dynamic>{
      'welcome': 'default welcome',
    });
    remoteConfig.fetch();
    await remoteConfig.fetchAndActivate();

    // RemoteConfigValue(null, ValueSource.valueStatic);
    return remoteConfig;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseRemoteConfig>(
      future: setupRemoteConfig(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseRemoteConfig> snapshot) {
        if (snapshot.hasData) {
          Constant.baseUrl = snapshot.requireData.getString("api_path");
          if (snapshot.requireData.getString("api_path") == "") {
            Constant.baseUrl = "http://78.111.98.76:5241/";
          }
        }
        return snapshot.hasData
            ? SplashPage()
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
