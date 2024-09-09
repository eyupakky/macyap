// ignore_for_file: unused_field, avoid_print, deprecated_member_use

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/page/account/email/update_email.dart';
import 'package:halisaha/page/account/followers/followers.dart';
import 'package:halisaha/page/account/organizator.dart';
import 'package:halisaha/page/account/password_update.dart';
import 'package:halisaha/page/account/profile/profile.dart';
import 'package:halisaha/page/account/settings/settings.dart';
import 'package:halisaha/page/account/siparislerim.dart';
import 'package:halisaha/page/account/support/support.dart';
import 'package:halisaha/page/account/wallet/promosyon_kodu.dart';
import 'package:halisaha/page/account/wallet/tc_check.dart';
import 'package:halisaha/page/account/wallet/upload_money.dart';
import 'package:halisaha/page/account/wallet/wallet.dart';
import 'package:halisaha/page/account/wallet/webview_page.dart';
import 'package:halisaha/page/create/create_game.dart';
import 'package:halisaha/page/home/game_list/game_detail.dart';
import 'package:halisaha/page/home/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:halisaha/page/home/turnuva_list.dart';
import 'package:halisaha/page/login/add_phone.dart';
import 'package:halisaha/page/login/confirm_page.dart';
import 'package:halisaha/page/login/forgat_my_password.dart';
import 'package:halisaha/page/login/help.dart';
import 'package:halisaha/page/login/login_page.dart';
import 'package:halisaha/page/login/login_with_number.dart';
import 'package:halisaha/page/login/new_password.dart';
import 'package:halisaha/page/login/new_register.dart';
import 'package:halisaha/page/login/register_page.dart';
import 'package:halisaha/page/message/message_details.dart';
import 'package:halisaha/page/splash_page.dart';
import 'package:halisaha/page/venues/venues_detail.dart';
import 'package:halisaha/remote_config.dart';
import 'cubit/cubit_abstract.dart';
import 'help/app_context.dart';
import 'help/default_options.dart';
import 'help/hex_color.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String?> selectNotificationSubject =
    BehaviorSubject<String?>();

String? selectedNotificationPayload;

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

class Mutable<T> {
  Mutable(this.value);
  T value;
}

late AndroidNotificationChannel channel;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
        'notification_channel_id', // id
        'notification_channel_id', // title
        importance: Importance.high,
        sound: RawResourceAndroidNotificationSound('aa'));
  }
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('logo');

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          onDidReceiveLocalNotification: (
            int id,
            String? title,
            String? body,
            String? payload,
          ) async {
            didReceiveLocalNotificationSubject.add(
              ReceivedNotification(
                id: id,
                title: title,
                body: body,
                payload: payload,
              ),
            );
          });
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
    // ignore: unnecessary_null_comparison
    if (notificationResponse != null) {
      debugPrint('notification payload: $notificationResponse');
    }
    selectedNotificationPayload = notificationResponse.payload;
    selectNotificationSubject.add(notificationResponse.payload);
  });
  AppContext appContext = AppContext();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  Bloc.observer = AppBlocObserver();
  runApp(ContextProvider(
      current: appContext, key: UniqueKey(), child: const MyApp()));
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var routes = {};
  bool _requested = false;
  bool _fetching = false;
  late NotificationSettings _settings;

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    setState(() {
      _fetching = true;
    });

    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );

    setState(() {
      _requested = true;
      _fetching = false;
      _settings = settings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChangeBottomCubit>(
          create: (BuildContext context) => ChangeBottomCubit(false),
        ),
        BlocProvider<ChangeFavorite>(
          create: (BuildContext context) => ChangeFavorite(false),
        ),
        BlocProvider<NewVenuesComment>(
          create: (BuildContext context) => NewVenuesComment(0),
        ),
        BlocProvider<GameFavorite>(
          create: (BuildContext context) => GameFavorite(false),
        ),
      ],
      child: MaterialApp(
        initialRoute: "/",
        builder: EasyLoading.init(),
        routes: {
          "/home": (context) => const HomePage(),
          "/splash": (context) => const SplashPage(),
          "/": (context) => const RemoteConfigPage(),
          "/messageDetails": (context) => const MessageDetails(),
          "/profile": (context) => ProfilePage(),
          "/followers": (context) => const FollowersPage(),
          "/wallet": (context) => WalletPage(),
          "/email": (context) => const UpdateEmailPage(),
          "/setting": (context) => const SettingsPage(),
          "/siparisler": (context) => const SiparislerimPage(),
          "/password": (context) => const PasswordUpdatePage(),
          "/login": (context) => const LoginPage(),
          "/loginwithnumber": (context) => const LoginWithNumber(),
          "/register": (context) => const RegisterPage(),
          "/newRegister": (context) => const NewRegister(),
          "/gameDetail": (context) => const GameDetailPage(),
          "/venuesDetail": (context) => const VenuesDetail(),
          "/createGame": (context) => const CreateGamePage(),
          "/uploadMoney": (context) => const UploadMoney(),
          "/tcCheck": (context) => const TcCheckController(),
          "/webview": (context) => const WebviewPage(),
          "/forgatMyPassword": (context) => const ForgatMyPassword(),
          "/newPassword": (context) => const NewPassword(),
          "/organizator": (context) => const Organizator(),
          "/support": (context) => const SupportPage(),
          "/help": (context) => const HelpLoginPage(),
          "/turnuva": (context) => const TurnuvaList(),
          "/promosyonKodu": (context) => const PromosyonKoduPage(),
          "/confirmpage": (context) => const ConfirmPage(),
          "/addphone": (context) => const AddPhone(),
        },
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
            tabBarTheme: TabBarTheme(
                labelColor: Colors.pink,
                labelStyle: const TextStyle(color: Colors.pink),
                // color for text
                indicator: UnderlineTabIndicator(
                    // color for indicator (underline)
                    borderSide:
                        BorderSide(color: HexColor.fromHex("#f0243a")))),
            primaryColor: HexColor.fromHex("#f0243a"),
            indicatorColor: HexColor.fromHex("#f0243a"),
            primaryColorLight: Colors.white60,
            textTheme: const TextTheme(
              titleSmall: TextStyle(
                  color: Colors.white60,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              titleMedium: TextStyle(
                  color: Colors.red, fontSize: 14, fontWeight: FontWeight.w400),
            ),
            fontFamily: "Montserrat-bold",
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
                .copyWith(background: Colors.white)),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
