import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:repository_eyup/controller/account_controller.dart';

import '../../../help/ui_guide.dart';
import '../../../help/utils.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  late TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
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
            minLines: 6,
            controller: controller,
            keyboardType: TextInputType.multiline,
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
              if (controller.text != "" && controller.text.isNotEmpty) {
                EasyLoading.show(status: 'loading...');
                AccountController()
                    .sendAComplaint(controller.text)
                    .then((value) {
                  if (value.success!) {
                    EasyLoading.dismiss();
                    showToast("Mesajınız iletildi.",color: Colors.green);
                    Navigator.pop(context);
                  }
                }).catchError((err) {
                  EasyLoading.dismiss();
                  showToast(err);
                });
              }
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 50,
              width: MediaQuery.of(context).size.width * 0.5,
              child: const Align(
                child: Text(
                  'Gönder',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
