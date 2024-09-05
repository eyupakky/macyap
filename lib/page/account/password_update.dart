import 'package:flutter/material.dart';
import 'package:halisaha/help/utils.dart';
import 'package:halisaha/widget/update_password.dart';
import 'package:lottie/lottie.dart';
import 'package:repository_eyup/controller/account_controller.dart';

class PasswordUpdatePage extends StatefulWidget {
  const PasswordUpdatePage({Key? key}) : super(key: key);

  @override
  State<PasswordUpdatePage> createState() => _PasswordUpdatePageState();
}

class _PasswordUpdatePageState extends State<PasswordUpdatePage>
    with SingleTickerProviderStateMixin {
  AutovalidateMode validate = AutovalidateMode.disabled;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  final _newpasswordConfirmController = TextEditingController();
  final AccountController _accountController = AccountController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: profileView(context),
    );
  }

  Widget profileView(context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                Lottie.asset(
                  'assets/images/lock.json',
                  repeat: false,
                  onLoaded: (composition) {
                    final controller = AnimationController(
                      vsync: this,
                      duration: composition.duration,
                    );
                    controller.forward(from: 1.0);
                  },
                ),
                UpdatePassword(
                  controller: _passwordController,
                  validate: validate,
                  hintText: "Şuanki Şifreniz",
                  textInputType: TextInputType.text,
                  icon: Icons.lock,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      value!.isEmpty ? "Bu alan boş geçemez..." : null,
                ),
                UpdatePassword(
                  controller: _newpasswordController,
                  validate: validate,
                  hintText: "Yeni Şifre",
                  textInputType: TextInputType.text,
                  icon: Icons.lock_outline,
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      value!.isEmpty ? "Bu alan boş geçemez..." : null,
                ),
                UpdatePassword(
                  controller: _newpasswordConfirmController,
                  validate: validate,
                  hintText: "Yeni Şifre Onayla",
                  textInputType: TextInputType.text,
                  icon: Icons.lock_outline,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    return value!.isEmpty
                        ? "Bu alan boş geçemez..."
                        : (_newpasswordController.text != value
                            ? "Şifreler uyuşmuyor..."
                            : null);
                  },
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
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
                          showToast('${value.description}',
                              color: Colors.green);
                          Navigator.pop(context);
                        }).catchError((onError) {
                          showToast(onError);
                        });
                      }
                    },
                    child: Container(
                      height: 50,
                      child: const Center(
                        child: Text(
                          'GÜNCELLE',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
