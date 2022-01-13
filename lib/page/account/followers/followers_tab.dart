import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halisaha/page/account/followers/following_tab_page.dart';
import 'package:repository_eyup/constant.dart';

import 'followers_tab_page.dart';

class FollowersTab extends StatefulWidget {
  const FollowersTab({Key? key}) : super(key: key);

  @override
  State<FollowersTab> createState() => _FollowersTabState();
}

class _FollowersTabState extends State<FollowersTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // give the tab bar a height [can change hheight to preferred height]
            Container(
              height: 45,
              // decoration: BoxDecoration(
              // color: Colors.grey[300],
              // borderRadius: BorderRadius.circular(
              //   25.0,
              // ),
              // ),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                indicatorColor: Colors.green,
                unselectedLabelColor: Colors.black,
                unselectedLabelStyle: const TextStyle(fontSize: 14),
                labelStyle: const TextStyle(fontSize: 16),
                tabs: const [
                  Tab(
                    text: 'Followers',
                  ),
                  Tab(
                    text: 'Following',
                  ),
                  // Tab(
                  //   text: 'Blocked',
                  // ),
                ],
              ),
            ),
            // tab bar view here
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  FollowersTabPage(),
                  FollowingTabPage(),
                  // Center(
                  //   child: Text(
                  //     'Blocked',
                  //     style: TextStyle(
                  //       fontSize: 18,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
