// ignore_for_file: body_might_complete_normally_catch_error

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/help/payment_card.dart';
import 'package:halisaha/help/utils.dart';
import 'package:repository_eyup/controller/wallet_controller.dart';

class TcCheckController extends StatefulWidget {
  const TcCheckController({Key? key}) : super(key: key);

  @override
  State<TcCheckController> createState() => _TcCheckControllerState();
}

class _TcCheckControllerState extends State<TcCheckController> {
  final TextEditingController tcCheckController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  AutovalidateMode validate = AutovalidateMode.always;

  final WalletController _walletController = WalletController();

  @override
  void initState() {
    super.initState();
    checkTc();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: const Text(
                "TC No",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            Form(
              key: _formKey,
              autovalidateMode: validate,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "* Tc kimlik numarasını, yasal zorunluluk sebebi ile istenmektedir.\n* Bu bilgi sizden bir defaya mahsus alınacaktır.",
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    maxLength: 11,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.star,
                        color: Colors.redAccent.withAlpha(150),
                        size: 25,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: "TC kimlik numarası",
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 14),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      return val!.isNotEmpty
                          ? (val.length == 11 ? null : Strings.tcNumarasi)
                          : Strings.fieldReq;
                    },
                    onChanged: (val) {},
                    controller: tcCheckController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent, // background
                foregroundColor: Colors.white, // foreground
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
                setTC();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  'TCKNO Onayla',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  setTC() {
    EasyLoading.show();
    _walletController
        .setTc(tcCheckController.text)
        .then((value) => Navigator.pushNamedAndRemoveUntil(
            context, "/uploadMoney", ModalRoute.withName('/')))
        .catchError((onError) {
      EasyLoading.dismiss();
      showToast(onError);
    });
  }

  checkTc() {
    EasyLoading.show();
    _walletController.checkTc().then((value) {
      if (value == true) {
        Navigator.pushReplacementNamed(context, "/uploadMoney");
      } else {
        EasyLoading.dismiss();
      }
    }).catchError((onError) {
      EasyLoading.dismiss();
      showToast(onError);
    });
  }
}
