import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halisaha/help/utils.dart';
import 'package:halisaha/widget/edittext_widget.dart';
import 'package:repository_eyup/controller/account_controller.dart';
import 'package:validators/validators.dart';

class UpdateEmailPage extends StatefulWidget {
  UpdateEmailPage({Key? key}) : super(key: key);

  @override
  State<UpdateEmailPage> createState() => _UpdateEmailPageState();
}

class _UpdateEmailPageState extends State<UpdateEmailPage> {
  final TextEditingController lastEmail = TextEditingController();

  AutovalidateMode validate = AutovalidateMode.disabled;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController newEmail = TextEditingController();

  final TextEditingController password = TextEditingController();

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
        autovalidateMode: validate,
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
            // EdittextWidget(
            //   controller: lastEmail,
            //   labelText: "Eski Mail",
            //   icon: null,
            //   validator: (value) {
            //     return value!.isEmpty
            //         ? "Boş geçilemez"
            //         : (!isEmail(value)
            //             ? "Lütfen doğru mail adresi giriniz"
            //             : null);
            //   },
            //   maxLength: 100,
            //   iconColor: Theme.of(context).primaryColorLight,
            //   focusColor: const Color.fromRGBO(80, 80, 80, 1),
            //   unFocusColor: Colors.grey,
            //   labelColor: const Color.fromRGBO(80, 80, 80, 1),
            //   textColor: Colors.black,
            //   obscureText: false,
            // ),
            EdittextWidget(
              controller: newEmail,
              labelText: "Yeni Mail",
              icon: null,
              validator: (value) {
                return value!.isEmpty
                    ? "Boş geçilemez"
                    : (!isEmail(value)
                        ? "Lütfen doğru mail adresi giriniz"
                        : null);
              },
              maxLength: 100,
              iconColor: Theme.of(context).primaryColorLight,
              focusColor: const Color.fromRGBO(80, 80, 80, 1),
              unFocusColor: Colors.grey,
              labelColor: const Color.fromRGBO(80, 80, 80, 1),
              textColor: Colors.black,
              obscureText: false,
            ),
            EdittextWidget(
              controller: password,
              labelText: "Şifre Onayı",
              icon: null,
              validator: (value) {
                return value!.isEmpty ? "Boş geçilemez" : null;
              },
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
                    if (!_formKey.currentState!.validate()) {
                      setState(() {
                        validate = AutovalidateMode.onUserInteraction;
                      });
                    } else {
                      _accountController
                          .updateEmail(newEmail.text, password.text)
                          .then((value) {
                        newEmail.text = "";
                        password.text = "";
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
                        'E-Mail Güncelle',
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
