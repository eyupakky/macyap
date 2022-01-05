import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repository_eyup/controller/account_controller.dart';
import 'package:repository_eyup/model/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);
  final AccountController _accountController = AccountController();
  final String _userId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12),
                child: const Text(
                  "eyupakky",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: constraints.maxHeight - 50,
              child: FutureBuilder<List<AccountModel>>(
                  future: _accountController.getAccount(_userId),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const Center(child: Text("Mekan bulunamadı."));
                    }
                    var data = snapshot.data;
                    return ListView.builder(
                        itemCount: data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              if(data[index].route!="/exit") {
                                Navigator.pushNamed(context, data[index].route);
                              }else{
                                exitApp();
                              }
                            },
                            title: Text(
                              data[index].item,
                              style: const TextStyle(fontSize: 13),
                            ),
                            leading: Container(
                              height: 35,
                              width: 35,
                              margin: const EdgeInsets.only(right: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Icon(data[index].icon),
                              ),
                            ),
                          );
                        });
                  }),
            ),
          ],
        );
      },
    ));
  }

  void exitApp() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
