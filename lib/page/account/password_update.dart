import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halisaha/widget/edittext_widget.dart';

class PasswordUpdatePage extends StatelessWidget {
  PasswordUpdatePage({Key? key}) : super(key: key);

  final TextEditingController _passwordController=TextEditingController();
  final TextEditingController _newpasswordController=TextEditingController();
  final TextEditingController _newpasswordConfirmController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: profileView(context),
    );
  }

  Widget profileView(context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          ListTile(
            title: const Text(
              "Password",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          EdittextWidget(
            controller: _passwordController,
            labelText: "Şuanki Şifreniz",
            icon: null,
            maxLength: 100,
            iconColor: Theme.of(context).primaryColorLight,
            focusColor: const Color.fromRGBO(80, 80, 80, 1),
            unFocusColor: Colors.grey,
            labelColor: const Color.fromRGBO(80, 80, 80, 1),
            textColor: Colors.black,
            obscureText: false,
          ),
          EdittextWidget(
            controller: _newpasswordController,
            labelText: "Yeni Şifre",
            icon: null,
            maxLength: 100,
            iconColor: Theme.of(context).primaryColorLight,
            focusColor: const Color.fromRGBO(80, 80, 80, 1),
            unFocusColor: Colors.grey,
            labelColor: const Color.fromRGBO(80, 80, 80, 1),
            textColor: Colors.black,
            obscureText: false,
          ),
          EdittextWidget(
            controller: _newpasswordConfirmController,
            labelText: "Yeni Şifre Onayla",
            icon: null,
            maxLength: 100,
            iconColor: Theme.of(context).primaryColorLight,
            focusColor: const Color.fromRGBO(80, 80, 80, 1),
            unFocusColor: Colors.grey,
            labelColor: const Color.fromRGBO(80, 80, 80, 1),
            textColor: Colors.black,
            obscureText: false,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.all(8),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: const Align(
                  child: Text(
                    'KAYDET',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                decoration: const BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
