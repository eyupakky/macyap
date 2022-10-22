import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/help/ui_guide.dart';
import 'package:halisaha/help/utils.dart';
import 'package:repository_eyup/controller/account_controller.dart';
import 'package:repository_eyup/controller/login_controller.dart';

class HelpLoginPage extends StatefulWidget {
  const HelpLoginPage({Key? key}) : super(key: key);

  @override
  State<HelpLoginPage> createState() => _HelpLoginPageState();
}

class _HelpLoginPageState extends State<HelpLoginPage> {
  late TextEditingController controller = TextEditingController();
  late TextEditingController name = TextEditingController();
  late TextEditingController surname = TextEditingController();
  late TextEditingController phone = TextEditingController();
  late TextEditingController email = TextEditingController();
  late TextEditingController subject = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode mode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Center(
              child: Row(
                children: [
                  Flexible(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back))),
                  Expanded(
                    flex: 6,
                    child: Image.asset(
                      UIGuide.macyap,
                      height: 100,
                    ),
                  ),
                ],
              ),
            ),
            TextFormField(
              controller: name,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(color: Colors.black),
              maxLines: null,
              autovalidateMode: mode,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Boş geçilemez';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                hintText: "Ad",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: surname,
              autovalidateMode: mode,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(color: Colors.black),
              maxLines: null,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Boş geçilemez';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                hintText: "Soyad",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: phone,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(color: Colors.black),
              maxLines: null,
              autovalidateMode: mode,
              validator: (value) {
                if (!RegExp(
                    r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)')
                    .hasMatch(value ?? '')) {
                  return 'Boş geçilemez';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                hintText: "Telefon",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
              ),
            ),
            const SizedBox(height: 10,),

            TextFormField(
              controller: email,
              autovalidateMode: mode,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(color: Colors.black),
              maxLines: null,
              validator: (value) {
                if (value!.isNotEmpty && !RegExp(
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                    .hasMatch(value)) {
                  return 'Email doğru giriniz.';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                hintText: "Email",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
              ),
            ),
            const SizedBox(height: 10,),

            TextFormField(
              controller: subject,
              keyboardType: TextInputType.multiline,
              style: const TextStyle(color: Colors.black),
              autovalidateMode: mode,
              maxLines: null,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Boş geçilemez';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                hintText: "Konu",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              minLines: 6,
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Boş geçilemez';
                }
                return null;
              },
              keyboardType: TextInputType.multiline,
              autovalidateMode: mode,
              style: const TextStyle(color: Colors.black),
              maxLines: null,
              decoration: const InputDecoration(
                labelStyle: TextStyle(color: Colors.white),
                hintText: "Nasıl yardımcı olabiliriz?",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  EasyLoading.show(status: 'loading...');
                  /*
                  {
  "name": "string",
  "surname": "string",
  "phone": "string",
  "email": "string",
  "subject": "string",
  "message": "string"
}
                   */
                  LoginController()
                      .help({
                    "name": name.text,
                    "surname": surname.text,
                    "phone": phone.text,
                    "email": email.text,
                    "subject": subject.text,
                    "message": controller.text
                  })
                      .then((value) {
                    if (value.success!) {
                      EasyLoading.dismiss();
                      showToast("Mesajınız iletildi.", color: Colors.green);
                      Navigator.pop(context);
                    }
                  }).catchError((err) {
                    EasyLoading.dismiss();
                    showToast(err);
                  });
                } else {
                  setState(() {
                    mode = AutovalidateMode.always;
                  });
                }
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                height: 50,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.5,
                child: const Align(
                  child: Text(
                    'Gönder',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Theme
                        .of(context)
                        .primaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}