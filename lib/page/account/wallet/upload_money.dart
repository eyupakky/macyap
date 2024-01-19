import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/help/input_formatter.dart';
import 'package:halisaha/help/payment_card.dart';
import 'package:halisaha/help/utils.dart';
import 'package:repository_eyup/controller/wallet_controller.dart';

class UploadMoney extends StatefulWidget {
  UploadMoney({Key? key}) : super(key: key);

  @override
  State<UploadMoney> createState() => _UploadMoneyState();
}

class _UploadMoneyState extends State<UploadMoney> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController uploadMoney = TextEditingController();
  final WalletController _walletController = WalletController();
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode validate = AutovalidateMode.disabled;
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  double minTutar=201;

  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    minTutar = remoteConfig.getDouble("ios_min_odeme") != 0 ? remoteConfig.getDouble("ios_min_odeme") : 200;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: const Text(
                "Cüzdana yükleme yap",
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
                  Text(
                    "* Minimum yükleme miktarı $minTutar TL'dir",
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.money,
                        color: Colors.green.withAlpha(150),
                        size: 25,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                      ),
                      hintText: "Yüklenecek miktar(TRY)",
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 14),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      return val!.isEmpty
                          ?Strings.uploadMoneyError
                          : (double.parse(val) < minTutar ? "* Minimum yükleme miktarı $minTutar TL'dir": null  );
                    },
                    onChanged: (val) {
                      print(val);
                    },
                    controller: uploadMoney,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.all(4),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.green.withAlpha(150),
                          size: 25,
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: "Kart Sahibinin adı soyadı",
                        hintStyle: const TextStyle(fontSize: 14),
                        labelStyle:
                            const TextStyle(color: Colors.black, fontSize: 14),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                        ),
                      ),
                      onChanged: (val) {},
                      validator: (val) {
                        return val!.isNotEmpty ? null : Strings.fieldReq;
                      },
                      controller: fullNameController,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(4),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.credit_card,
                          color: Colors.green.withAlpha(150),
                          size: 25,
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: "1234 1234 1234 1234",
                        labelStyle:
                            const TextStyle(color: Colors.black, fontSize: 14),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent),
                        ),
                      ),
                      validator: (val) {
                        return CardUtils.validateCardNum(val);
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16),
                        CardNumberInputFormatter()
                      ],
                      onChanged: (val) {},
                      controller: cardNumberController,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.date_range_outlined,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                hintText: "12/25",
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.redAccent),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(5),
                                CardMonthInputFormatter()
                              ],
                              validator: (val) {
                                return CardUtils.validateDate(val);
                              },
                              onChanged: (val) {},
                              controller: dateController,
                            )),
                        const Expanded(
                            flex: 1,
                            child: SizedBox(
                              width: 0,
                            )),
                        Expanded(
                            flex: 2,
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.credit_card,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                hintText: "000",
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 14),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.redAccent),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              validator: (val) {
                                return CardUtils.validateCVV(val);
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3),
                              ],
                              onChanged: (val) {},
                              controller: cvvController,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () {
                setState(() {
                  validate = AutovalidateMode.always;
                });
                if (_formKey.currentState!.validate()) {
                  _createPayment();
                }
                // Navigator.pushNamed(context, "/uploadMoney");
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                alignment: Alignment.center,
                child: const Text(
                  'Bakiye Yükle',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _createPayment() {
    EasyLoading.show();
    Map<String, String> map = {
      "CardNumber": CardUtils.getCleanedNumber(cardNumberController.text),
      "CardMonthYear": dateController.text,
      "SecurityCode": cvvController.text,
      "CardOwner": fullNameController.text,
      "miktar": uploadMoney.text,
      "Installment": "0",
      "Ozel_Oran_SK_ID": "",
    };
    _walletController.createPayment(map).then((value) {
      Navigator.pushNamed(context, "/webview", arguments: value);
    }).catchError((onError) {
      showToast(onError);
      EasyLoading.dismiss();
    });
  }
}
