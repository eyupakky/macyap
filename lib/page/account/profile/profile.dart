import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halisaha/page/account/profile/profile_tab.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        return  Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
              ListTile(
                title: const Text(
                  "Eyüp Akkaya",
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: const Text("@eyupakky"),
                trailing: Container(
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.only(right: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      "https://www.itemhesap.com/uploads/blocks/block_6155609a164302-38911972-90307848.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colors.grey.shade400,
                thickness: 1,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                    text: const TextSpan(
                        text: "0",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18),
                        children: [
                          TextSpan(
                              text: "  Takipçi  ",
                              style: TextStyle(fontSize: 16, color: Colors.grey)),
                          TextSpan(
                              text: "0",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text: "  Takip ettiğin",
                              style: TextStyle(fontSize: 16, color: Colors.grey)),
                        ])),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                alignment: Alignment.centerLeft,
                child: RichText(
                    text: const TextSpan(
                        text: "0",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18),
                        children: [
                          TextSpan(
                              text: "  Maçın oyuncusu %100 güvenilirlik sağlar  ",
                              style: TextStyle(fontSize: 16, color: Colors.grey)),
                        ])),
              ),
              SizedBox(height: constraints.maxHeight * 0.75,child: const ProfileTab()),
            ],
          ),
        );
      }),


    ));
  }
}
