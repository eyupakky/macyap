// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:halisaha/page/account/profile/attended_tab_page.dart';
import 'package:halisaha/page/account/profile/played_tab_page.dart';
import 'package:repository_eyup/model/user.dart';

class ProfileTab extends StatefulWidget {
  User user;
  ProfileTab({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab>
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
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
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
                indicatorColor: Colors.redAccent,
                unselectedLabelColor: Colors.black,
                unselectedLabelStyle: const TextStyle(fontSize: 14),
                labelStyle: const TextStyle(fontSize: 16),
                tabs: const [
                  Tab(
                    text: 'KATILDIKLARIM',
                  ),
                  Tab(
                    text: 'OYNADIKLARIM',
                  ),
                ],
              ),
            ),
            // tab bar view here
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  AttendedPage(user: widget.user),
                  PlayedTabPage(user: widget.user)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
