import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/base_widget.dart';
import 'package:halisaha/page/login/add_phone.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/controller/account_controller.dart';
import 'package:repository_eyup/model/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../help/utils.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);
  final AccountController _accountController = AccountController();
  final String _userId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
      builder: (context, constraints) {
        return BaseWidget(
          child: Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Text(
                    Constant.userName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
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
                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    if (data[index].token != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddPhone(
                                              token: data[index].token!),
                                        ),
                                      );
                                    } else if (data[index].route ==
                                        "/profile") {
                                      Navigator.pushNamed(
                                          context, data[index].route,
                                          arguments: Constant.userId);
                                    } else if (data[index].route ==
                                        "/removeAccount") {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext contx) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'Kullanıcını Silmek istediğine emin misin ?'),
                                              actions: [
                                                MaterialButton(
                                                  // FlatButton widget is used to make a text to work like a button
                                                  textColor: Colors.black,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  }, // function used to perform after pressing the button
                                                  child: const Text('İptal'),
                                                ),
                                                MaterialButton(
                                                  textColor: Colors.black,
                                                  onPressed: () {
                                                    deleteAccount(context);
                                                  },
                                                  child: const Text('Onayla'),
                                                ),
                                              ],
                                            );
                                          });
                                    } else if (data[index].route != "/exit") {
                                      Navigator.pushNamed(
                                          context, data[index].route);
                                    } else {
                                      exitApp(context);
                                    }
                                  },
                                  title: Text(
                                    data[index].item,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        const Color.fromARGB(255, 216, 120, 120)
                                            .withOpacity(0.2),
                                    child: SizedBox(
                                      height: 35,
                                      width: 35,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Center(
                                          child: Icon(
                                              color: Colors.red,
                                              data[index].icon),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Divider(
                                    height: 1,
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            );
                          });
                    }),
              ),
            ],
          ),
        );
      },
    ));
  }

  void exitApp(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.remove("accessToken");
    Navigator.pushReplacementNamed(context, "/loginwithnumber");
  }

  void deleteAccount(context) {
    _accountController.deleteAccount().then((value) {
      Navigator.pop(context);
      exitApp(context);
    }).catchError((onError) {
      EasyLoading.dismiss();
      showToast(onError);
    });
  }
}
