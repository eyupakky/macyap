import 'package:flutter/material.dart';

import '../../../base_widget.dart';
import 'followers_tab.dart';

class FollowersPage extends StatefulWidget {
  const FollowersPage({Key? key}) : super(key: key);

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: BaseWidget(
        child: LayoutBuilder(builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
                height: constraints.maxHeight * 0.9,
                child: const FollowersTab()),
          );
        }),
      ),
    ));
  }
}
