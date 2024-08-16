import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/help/utils.dart';
import 'package:repository_eyup/controller/wallet_controller.dart';

class PromosyonKoduPage extends StatefulWidget {
  const PromosyonKoduPage({Key? key}) : super(key: key);

  @override
  State<PromosyonKoduPage> createState() => _PromosyonKoduPageState();
}

class _PromosyonKoduPageState extends State<PromosyonKoduPage> {
  final TextEditingController promosyonController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  AutovalidateMode validate = AutovalidateMode.always;

  final WalletController _walletController = WalletController();

  @override
  void initState() {
    super.initState();
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
                "Promosyon Kodu",
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
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.star,
                        color: Colors.redAccent.withAlpha(150),
                        size: 25,
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: "Promosyon Kodu",
                      labelStyle:
                          const TextStyle(color: Colors.black, fontSize: 14),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      return val!.isNotEmpty ? null : "Boş Geçilemez";
                    },
                    onChanged: (val) {},
                    controller: promosyonController,
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
                  'SORGULA',
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
    _walletController.setPromosyon(promosyonController.text).then((value) {
      EasyLoading.dismiss();
      showToast("${value.description}");
      value.success! ? Navigator.pop(context) : null;
    }).catchError((onError) {
      EasyLoading.dismiss();
      showToast(onError);
    });
  }
}
