import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halisaha/cubit/cubit_abstract.dart';
import 'package:halisaha/page/account/account_page.dart';
import 'package:halisaha/page/home/main_list.dart';
import 'package:halisaha/page/message/message_page.dart';
import 'package:halisaha/page/places_page.dart';
import 'package:provider/src/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late Widget body;
  var constraints;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            activeColor: Colors.green,
            title: const Text('Anasayfa'),
          ),
          FlashyTabBarItem(
              icon: const Icon(Icons.location_on_sharp),
              activeColor: Colors.green,
              title: const Text('Mekanlar')),
          FlashyTabBarItem(
            icon: const Icon(Icons.message_outlined),
            activeColor: Colors.green,
            title: const Text('Mesajlar'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Hesabım'),
            activeColor: Colors.green,
          )
        ],
      ),
    );
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
}
