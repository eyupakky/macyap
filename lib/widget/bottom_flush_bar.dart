import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

class BottomFlushBar extends StatefulWidget {
  const BottomFlushBar({Key? key}) : super(key: key);

  @override
  State<BottomFlushBar> createState() => _BottomFlushBarState();
}

class _BottomFlushBarState extends State<BottomFlushBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FlashyTabBar(
      selectedIndex: _selectedIndex,
      showElevation: true,
      onItemSelected: (index) => setState(() {
        _selectedIndex = index;
      }),
      items: [
        FlashyTabBarItem(
            icon: const Icon(Icons.home_outlined),
            activeColor: Colors.green,
            title: const Text('Anasayfa'),
            inactiveColor: Colors.green.withAlpha(150)),
        FlashyTabBarItem(
          icon: const Icon(Icons.location_on_sharp),
          inactiveColor: Colors.green.withAlpha(150),
          title: const Text('Mekanlar'),
          activeColor: Colors.green,
        ),
        FlashyTabBarItem(
          icon: const Icon(Icons.message_outlined),
          inactiveColor: Colors.green.withAlpha(150),
          title: const Text('Mesajlar'),
          activeColor: Colors.green,
        ),
        FlashyTabBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Hesabım'),
            activeColor: Colors.green,
            inactiveColor: Colors.green.withAlpha(150)),
      ],
    );
  }
}
