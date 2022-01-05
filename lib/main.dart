import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:halisaha/page/account/email/update_email.dart';
import 'package:halisaha/page/account/followers/followers.dart';
import 'package:halisaha/page/account/password_update.dart';
import 'package:halisaha/page/account/profile/profile.dart';
import 'package:halisaha/page/account/settings/settings.dart';
import 'package:halisaha/page/account/wallet/wallet.dart';
import 'package:halisaha/page/home/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:halisaha/page/login/login_page.dart';
import 'package:halisaha/page/message/message_details.dart';

import 'cubit/cubit_abstract.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

//late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  // }
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ChangeBottomCubit>(
          create: (BuildContext context) => ChangeBottomCubit(0),
        ),
        BlocProvider<ThemeCubit>(
          create: (BuildContext context) => ThemeCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: "/login",
        routes: {
          "/": (context) => const HomePage(),
          "/messageDetails": (context) => MessageDetails(),
          "/profile": (context) => ProfilePage(),
          "/followers": (context) => FollowersPage(),
          "/wallet": (context) => WalletPage(),
          "/email": (context) => UpdateEmailPage(),
          "/setting": (context) => SettingsPage(),
          "/password": (context) => PasswordUpdatePage(),
           "/login": (context) => LoginPage(),
        },
        theme: ThemeData(
          tabBarTheme: const TabBarTheme(
              labelColor: Colors.pink,
              labelStyle: TextStyle(color: Colors.pink), // color for text
              indicator: UnderlineTabIndicator(
                  // color for indicator (underline)
                  borderSide: BorderSide(color: Colors.green))),
          primaryColor: Colors.pink[800], // deprecated,
          primarySwatch: Colors.green,
        ),
      ),
    );
  }
}