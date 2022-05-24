import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:halisaha/page/account/account_page.dart';
import 'package:halisaha/page/home/game_list/main_list.dart';
import 'package:halisaha/page/message/message_page.dart';
import 'package:halisaha/page/venues/venues_page.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/controller/firebase_controller.dart';

import '../../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late Widget body;
  var constraints;
  final FirebaseController _firebaseController = FirebaseController();

  @override
  void initState() {
    super.initState();
   // _notification();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setNotificationOpenedHandler(
      (OSNotificationOpenedResult result) {
        _navigateToItemDetail(result.notification);
        print(result.notification.launchUrl);
      },
    );
    OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
      _showNotificationCustomSound(event.notification);
    });
    OneSignal.shared.setAppId("13c3cb3f-8feb-4059-a683-da58e2933d5b");
    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});
  }

  _notification() async {
    FirebaseMessaging.instance.getToken().then((value) => sendGuid(value!));
    await FirebaseMessaging.instance.subscribeToTopic('all');
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      print("");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(message);
      _navigateToItemDetail(message);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      OSNotification osNotification = OSNotification({
        "title": message.notification!.title,
        "body": message.notification!.body
      });
      _showNotificationCustomSound(osNotification);
      // _showItemDialog(message);
    });
  }

  Future<void> _showNotificationCustomSound(OSNotification message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'notification_channel_id',
      'notification_channel_id',
      'notification_channel_id',
      icon: 'launch_background',
      sound: RawResourceAndroidNotificationSound('aa'),
    );
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'aa.wav');
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      message.title,
      message.body,
      platformChannelSpecifics,
    );
  }

  _navigateToItemDetail(message) {
    if (message.data.isNotEmpty && message.data["page"] != "Home") {
      Navigator.pushNamed(context, '/${message.data["page"]}',
          arguments: int.parse(message.data["id"]));
    }
  }

  void _showItemDialog(RemoteMessage message) {
    // Navigator.pop(context);
    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, message),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(240),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          this.constraints = constraints;
          return changeBottomItem(_selectedIndex);
        }),
      ),
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
          // context.read<ChangeBottomCubit>().changeFlushBar(index);
        }),
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.home_outlined),
            activeColor: Colors.redAccent,
            title: const Text('Anasayfa'),
          ),
          FlashyTabBarItem(
              icon: const Icon(Icons.location_on_sharp),
              activeColor: Colors.redAccent,
              title: const Text('Mekanlar')),
          FlashyTabBarItem(
            icon: const Icon(Icons.message_outlined),
            activeColor: Colors.redAccent,
            title: const Text('Mesajlar'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Hesabım'),
            activeColor: Colors.redAccent,
          )
        ],
      ),
    );
  }

  sendGuid(String guid) {
    print("############################");
    print(guid);
    if (guid.isNotEmpty && Constant.accessToken.isNotEmpty) {
      _firebaseController.sendGuid(guid).then((value) {
        print(value);
      }).catchError((onError) {
        print(onError);
      });
    }
  }

  Widget changeBottomItem(int index) {
    switch (index) {
      case 0:
        body = const MainList();
        break;
      case 1:
        body = PlacesPage();
        break;
      case 2:
        body = MessagePage();
        break;
      case 3:
        body = AccountPage();
        break;
    }
    return body;
  }

  Widget _buildDialog(BuildContext context, RemoteMessage message) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Stack(
        children: [
          Container(
              width: 40,
              height: 40,
              child: Image.asset("assets/images/logo_black.png")),
          Container(
            margin: const EdgeInsets.only(left: 45),
            child: Text(
              '${message.notification!.title}',
              maxLines: 3,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${message.notification!.body}",
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
          const SizedBox(
            height: 10,
          ),
          // CachedNetworkImage(
          //   imageUrl: Platform.isIOS
          //       ? (message.notification!.apple!.imageUrl ?? "-")
          //       : (message.notification!.android!.imageUrl ?? "-"),
          //   fit: BoxFit.fill,
          //   errorWidget: (context, url, error) => const Icon(Icons.error),
          // ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text(
            'Kapat',
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: const Text(
            'Göster',
          ),
          onPressed: () {
            Navigator.pop(context);
            _navigateToItemDetail(message);
          },
        ),
      ],
    );
  }
}
