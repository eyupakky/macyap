import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halisaha/widget/edittext_widget.dart';

class UpdateEmailPage extends StatelessWidget {
   UpdateEmailPage({Key? key}) : super(key: key);
   final TextEditingController _nameController=TextEditingController();
   final TextEditingController _surnameController=TextEditingController();
   final TextEditingController _usernameController=TextEditingController();
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
              "Mail Güncelle",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          EdittextWidget(
            controller: _nameController,
            labelText: "Eski Mail",
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
            controller: _nameController,
            labelText: "Yeni Mail",
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
            controller: _nameController,
            labelText: "Şifre Onayı",
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
                    'E-Mail Güncelle',
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
