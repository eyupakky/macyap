import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/help/utils.dart';
import 'package:halisaha/page/account/email/update_email.dart';
import 'package:halisaha/page/account/followers/followers.dart';
import 'package:halisaha/page/account/password_update.dart';
import 'package:halisaha/page/account/profile/profile.dart';
import 'package:halisaha/page/account/settings/settings.dart';
import 'package:halisaha/page/account/wallet/wallet.dart';
import 'package:halisaha/page/home/game_list/game_detail.dart';
import 'package:halisaha/page/home/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:halisaha/page/login/login_page.dart';
import 'package:halisaha/page/login/register_page.dart';
import 'package:halisaha/page/message/message_details.dart';
import 'package:halisaha/page/splash_page.dart';
import 'package:halisaha/page/venues/venues_detail.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'cubit/cubit_abstract.dart';
import 'help/app_context.dart';
import 'help/default_firebase_config.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  AppContext appContext = AppContext();
  // }
  BlocOverrides.runZoned(
    () => runApp(ContextProvider(
        current: appContext, key: UniqueKey(), child: const MyApp())),
    blocObserver: AppBlocObserver(),
  );
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
  @override
  void initState() {
    super.initState();
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
      ],
      child: MaterialApp(
        initialRoute: "/splash",
        builder: EasyLoading.init(),
        routes: {
          "/": (context) => const HomePage(),
          "/splash": (context) => const SplashPage(),
          "/messageDetails": (context) => MessageDetails(),
          "/profile": (context) => ProfilePage(),
          "/followers": (context) => FollowersPage(),
          "/wallet": (context) => WalletPage(),
          "/email": (context) => UpdateEmailPage(),
          "/setting": (context) => SettingsPage(),
          "/password": (context) => PasswordUpdatePage(),
          "/login": (context) => LoginPage(),
          "/register": (context) => const RegisterPage(),
          "/gameDetail": (context) => GameDetail(),
          "/venuesDetail": (context) => VenuesDetail(),
        },
        theme: ThemeData(
          tabBarTheme: const TabBarTheme(
              labelColor: Colors.pink,
              labelStyle: TextStyle(color: Colors.pink), // color for text
              indicator: UnderlineTabIndicator(
                  // color for indicator (underline)
                  borderSide: BorderSide(color: Colors.green))),
          primaryColor: Colors.pink[800],
          indicatorColor: Colors.green,
          backgroundColor: Colors.white,
          fontFamily: "Montserrat-bold",
          // deprecated,
          primarySwatch: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

}
