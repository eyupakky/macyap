import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halisaha/base_widget.dart';
import 'package:halisaha/widget/edittext_widget.dart';
import 'package:repository_eyup/constant.dart';

class SettingsPage extends StatefulWidget {
   SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
   final TextEditingController _nameController=TextEditingController();

   final TextEditingController _surnameController=TextEditingController();

   final TextEditingController _usernameController=TextEditingController();
  @override
  void initState() {
    super.initState();
    _nameController.text  = Constant.name;
    _surnameController.text  = Constant.surname;
    _usernameController.text  = Constant.userName;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: profileView(context),
    );
  }

  Widget profileView(context) {
    return SafeArea(
      child: BaseWidget(
        child: Column(
          children: <Widget>[
            ListTile(
              title: const Text(
                "Ayarlar",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(right: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18.0),
                      child:  CachedNetworkImage(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        imageUrl: Constant.image,
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 35,
                        width: 35,
                        child: const Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                        ),
                        decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                      ))
                ],
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  color: Colors.grey.shade200),
              child: Column(
                children: <Widget>[
                  EdittextWidget(
                    controller: _nameController,
                    labelText: "Adınız",
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
                    controller: _surnameController,
                    labelText: "Soyadınız",
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
                    controller: _usernameController,
                    labelText: "Kullanıcı adınız",
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
                            'Save',
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
            ))
          ],
        ),
      ),
    );
  }
}
