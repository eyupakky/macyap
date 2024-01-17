import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halisaha/help/utils.dart';

import 'package:halisaha/page/account/account_page.dart';
import 'package:halisaha/page/home/game_list/main_list.dart';
import 'package:halisaha/page/home/turnuva_list.dart';
import 'package:halisaha/page/message/message_page.dart';
import 'package:halisaha/page/venues/venues_page.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:launch_review/launch_review.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/controller/firebase_controller.dart';
import 'package:repository_eyup/controller/home_controller.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../help/hex_color.dart';
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
  String phoneNumber = "";
  PhoneNumber number = PhoneNumber(isoCode: 'TR');
  late FirebaseRemoteConfig config;
  final FirebaseController _firebaseController = FirebaseController();
  final HomeController _homeController = HomeController();
  TextEditingController code = TextEditingController();
  String text =
      'Maç Yap ta çok yakında gerçek çim sahalarda ve stadyumlarda maç yapabileceksiniz...       MaçYap ta turnuva zamanı... Turnuvalar sayfamızdan yapılacak turnuvalarımızı görebilir ,online olarak katılabilirsiniz. Turnuvalarımızda ünlü futbolcu ve Kaleci Yağmuru : Engin Baytar,Pascal Nouma,Ahmet Dursun ,Ali Eren,İbrahim Yattara,Tarık Daşgün,Veli Kavlak,Hami Mandıralı,Gökdeniz Karadeniz,Serkan Balcı,Deniz Ateş Bitnel,Ferit Aktuğ,Kubilay Aka,Hasan Kabze,Ümit Karan,Uğur Uçar,Emre Aşık,Mehmet Yozgatlı,Emre Toraman ve daha bir çok ünlü oyuncu sizlerle olacaklar...';
  bool visib = false;

  @override
  void initState() {
    super.initState();
    _notification();
    config=FirebaseRemoteConfig.instance;
    //initPlatformState();
    if (Constant.accessToken.isNotEmpty) {
      getTextList();
      //getSmsOnayKontrol();
    }
    getAppVersion();
  }

  Future<void> initPlatformState() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.Notifications.addClickListener((event) {
      _navigateToItemDetail(event.notification);
      print(event.notification.launchUrl);

    });
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      _showNotificationCustomSound(event.notification);

    });
    OneSignal.initialize("13c3cb3f-8feb-4059-a683-da58e2933d5b");
    OneSignal.Notifications.requestPermission(true);
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
        "body": message.notification!.body,
        "notificationId": message.messageId,
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
      icon: 'launch_background',
      sound: RawResourceAndroidNotificationSound('aa'),
    );

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
    DarwinNotificationDetails(sound: 'aa.wav');
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
        child: Stack(
          children: [
            LayoutBuilder(builder: (context, constraints) {
              this.constraints = constraints;
              return Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: changeBottomItem(_selectedIndex),
              );
            }),
            Visibility(
              visible: visib,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 40,
                  color: Colors.red,
                  alignment: Alignment.center,
                  child: TextScroll(
                    text,
                    intervalSpaces: 10,
                    velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
                  ),
                ),
              ),
            )
          ],
        ),
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
            icon: const Icon(Icons.tour),
            activeColor: Colors.redAccent,
            title: const Text(
              'Turnuvalar',
              style: TextStyle(fontSize: 12),
            ),
          ),
          FlashyTabBarItem(
              icon: const Icon(Icons.shop),
              activeColor: Colors.redAccent,
              title: const Text('Mağaza')),
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
        body = const TurnuvaList();
        break;
      case 2:
        body = PlacesPage();
        break;
      case 3:
        body = MessagePage();
        break;
      case 4:
        body = AccountPage();
        break;
    }
    return body;
  }

  Widget _buildSendDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Container(
        margin: const EdgeInsets.only(left: 45),
        child: const Text(
          'Telefonunuza gelen kodu giriniz',
          maxLines: 3,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin:
                const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Kod",
              ),
              controller: code,
              keyboardType: TextInputType.phone,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text(
            'Gönder',
          ),
          onPressed: () {
            if (code.text.isNotEmpty) {
              smsKontrol();
            } else {
              showToast("Hatalı telefon numarası");
            }
          },
        ),
      ],
    );
  }

  Widget _buildPhoneNumberDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Container(
        margin: const EdgeInsets.only(left: 45),
        child: const Text(
          'Telefon numaranızı giriniz',
          maxLines: 3,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin:
                const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
            child: InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                phoneNumber = number.phoneNumber!;
              },
              selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.DIALOG),
              initialValue: number,
              inputDecoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: HexColor.fromHex("#f0243a"),
                  ),
                ),
                labelText: "Cep telefonunuz".toUpperCase(),
                labelStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400,
                    color: Colors.white60,
                    fontSize: 10),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: HexColor.fromHex("#f0243a")),
                ),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              inputBorder: const OutlineInputBorder(),
              onSaved: (PhoneNumber number) {
                print('On Saved: $number');
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text(
            'Gönder',
          ),
          onPressed: () {
            if (isValidPhoneNumber(phoneNumber)) {
              Navigator.pop(context);
              sendPhoneNumber();
            } else {
              showToast("Hatalı telefon numarası");
            }
          },
        ),
      ],
    );
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
        ElevatedButton(
          child: const Text(
            'Kapat',
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
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

  getSmsOnayKontrol() {
    int version = config.getInt("ios_preview");
    PackageInfo.fromPlatform().then((value) {
      bool kontrol = version == int.parse(value.version) ? false : true;
      if(kontrol) {
        _homeController.getSmsOnayKontrol().then((value) {
        if (value.description != "1") {
          showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (_) => _buildPhoneNumberDialog(context),
          );
        }
      }).catchError((onError) {
        showToast('$onError');
      });
      }

    });

  }

  sendPhoneNumber() {
    _homeController.sendPhoneNumber(phoneNumber).then((value) {
      if (value.description != "1") {
        showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (_) => _buildSendDialog(context),
        );
      }
    }).catchError((onError) {
      showToast('$onError');
    });
  }

  smsKontrol() {
    _homeController.smsKontrol(code.text).then((value) {
      if (value.success) {
        Navigator.pop(context);
      }
    }).catchError((onError) {
      showToast('$onError');
    });
  }

  getTextList() {
    _homeController.getText().then((value) {
      visib = value.success;
      if (value.success) {
        setState(() {
          text = value.text;
        });
      }
    }).catchError((onError) {
      showToast('$onError');
    });
  }

  bool isValidPhoneNumber(String? value) {
    return RegExp(
            r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{6,6}$)')
        .hasMatch(value ?? '');
  }
  Future<bool> getAppVersion() async {
    FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);
    int version;
    if(Platform.isIOS){
      version = remoteConfig.getInt("ios_version_number");
    } else {
      version = remoteConfig.getInt("android_version_number");
    }
    if (version > 39) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: AlertDialog(
              title: const Text("Uyarı"),
              content: const Text("Lütfen uygulamayı güncelleyiniz..."),
              backgroundColor: Colors.white,
              actions: [
                MaterialButton(
                  onPressed: () {
                    LaunchReview.launch(
                      androidAppId: packageInfo.packageName,
                      iOSAppId: "1610877039",
                    );
                    //goTo(link, context);
                  },
                  child: const Text("Güncelle"),
                ),
              ],
            ),
          );
        },
      );
      return Future.value(false);
    } else{
      return Future.value(true);
    }
  }
}
