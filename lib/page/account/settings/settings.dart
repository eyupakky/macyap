import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/base_widget.dart';
import 'package:halisaha/help/utils.dart';
import 'package:halisaha/widget/edittext_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/controller/account_controller.dart';
import 'package:repository_eyup/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _surnameController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  final AccountController _accountController = AccountController();
  final ImagePicker _picker = ImagePicker();

  File image = File("");
  late Uint8List decoded;

  @override
  void initState() {
    super.initState();
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
              child: FutureBuilder<User>(
                  future: _accountController.getMyUser(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      User user = snapshot.data!;

                      _nameController.text = user.firstname!;
                      _surnameController.text = user.lastname!;
                      _usernameController.text = user.username!;
                      return Stack(
                        children: <Widget>[
                          Container(
                            height: 100,
                            width: 100,
                            margin: const EdgeInsets.only(right: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18.0),
                              child: image.path.isNotEmpty
                                  ? Image.memory(decoded)
                                  : CachedNetworkImage(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width,
                                      imageUrl: user.image!,
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  selectImage();
                                },
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  child: const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                  ),
                                  decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                              ))
                        ],
                      );
                    }
                  }),
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
                      child: InkWell(
                        onTap: () {
                          if (_usernameController.text.isNotEmpty &&
                              _nameController.text.isNotEmpty &&
                              _surnameController.text.isNotEmpty) {
                            EasyLoading.show();
                            if (image.path.isNotEmpty) {
                              updateImage();
                            } else {
                              update();
                            }
                          } else {
                            showToast("Tüm alanların dolu olması zorunludur.");
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: const Align(
                            child: Text(
                              'Kaydet',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              )),
                        ),
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

  selectImage() async {
    var imagePicker = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 10,
    maxHeight: 100);
    if (imagePicker != null) {
      setState(() {
        image = File(imagePicker.path);
        String base64Image = base64Encode(image.readAsBytesSync());
        decoded = base64Decode(base64Image);
      });
    }
  }

  updateImage() {
    String base64Image = base64Encode(image.readAsBytesSync());
    decoded = base64Decode(base64Image);
    _accountController.updateImage(base64Image).then((value) {
      showToast(value.description!);
      utils();
    }).catchError((err) {
      EasyLoading.dismiss();
      showToast(err.error);
    });
  }

  update() {
    _accountController
        .updateSetting(_usernameController.text, _nameController.text,
            _surnameController.text)
        .then((value) {
      showToast(value.description!);
      utils();
    }).catchError((err) {
      EasyLoading.dismiss();
      showToast(err.error);
    });
  }

  utils() {
    EasyLoading.dismiss();
    Constant.name = _nameController.text;
    Constant.surname = _surnameController.text;
    Constant.userName = _usernameController.text;
    SharedPreferences.getInstance().then((value) {
      value.setString("firstname", _nameController.text);
      value.setString("lastname", _surnameController.text);
      value.setString("username", _usernameController.text);
    });
  }
}
