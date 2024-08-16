import 'package:flutter/material.dart';
import 'package:halisaha/help/utils.dart';
import 'package:halisaha/widget/edittext_widget.dart';
import 'package:repository_eyup/controller/account_controller.dart';

class PasswordUpdatePage extends StatefulWidget {
  const PasswordUpdatePage({Key? key}) : super(key: key);

  @override
  State<PasswordUpdatePage> createState() => _PasswordUpdatePageState();
}

class _PasswordUpdatePageState extends State<PasswordUpdatePage> {
  AutovalidateMode validate = AutovalidateMode.disabled;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _newpasswordController = TextEditingController();

  final TextEditingController _newpasswordConfirmController =
      TextEditingController();

  final AccountController _accountController = AccountController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: profileView(context),
    );
  }

  Widget profileView(context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            ListTile(
              title: const Text(
                "Şifre",
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
              validator: (value) =>
                  value!.isEmpty ? "Bu alan boş geçemez..." : null,
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
              validator: (value) =>
                  value!.isEmpty ? "Bu alan boş geçilemez..." : null,
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
              validator: (value) {
                return value!.isEmpty
                    ? "Bu alan boş geçilemez..."
                    : (_newpasswordController.text != value
                        ? "Şifreler uyuşmuyor..."
                        : null);
              },
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
                    if (!_formKey.currentState!.validate()) {
                      setState(() {
                        validate = AutovalidateMode.onUserInteraction;
                      });
                    } else {
                      _accountController
                          .updatePassword(
                              _passwordController.text,
                              _newpasswordController.text,
                              _newpasswordConfirmController.text)
                          .then((value) {
                        showToast('${value.description}', color: Colors.green);
                        Navigator.pop(context);
                      }).catchError((onError) {
                        showToast(onError);
                      });
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: const Align(
                      child: Text(
                        'KAYDET',
                        style: TextStyle(color: Colors.white, fontSize: 16),
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
      ),
    );
  }
}
