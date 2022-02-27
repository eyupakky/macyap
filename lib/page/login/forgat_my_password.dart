import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halisaha/help/hex_color.dart';
import 'package:halisaha/help/ui_guide.dart';
import 'package:halisaha/help/utils.dart';
import 'package:halisaha/widget/custom_button.dart';
import 'package:repository_eyup/controller/home_controller.dart';

class ForgatMyPassword extends StatefulWidget {
  const ForgatMyPassword({Key? key}) : super(key: key);

  @override
  State<ForgatMyPassword> createState() => _ForgatMyPasswordState();
}

class _ForgatMyPasswordState extends State<ForgatMyPassword> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.asset("assets/images/giris_ng.jpg").image,
              fit: BoxFit.fill)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                UIGuide.pirpleLogo,
                height: SizeConfig.blockSizeVertical * 24,
                fit: BoxFit.fill,
              ),
            ),
            Text("Şifremi unuttum",
                style:
                TextStyle(color: HexColor.fromHex("#f0243a"), fontSize: 25)),
            TextField(
              controller: controller,
              decoration:  InputDecoration(
                  hintText: "Kullanıcı adı yada email",
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: Theme.of(context).primaryColor)),
                  labelStyle: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 14),
                  hintStyle: const TextStyle(color: Colors.white60,fontWeight: FontWeight.w500,fontSize: 14)),
              onChanged: (val) {},
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              height: 75,
              text: "GÖNDER",
              text2: "GÖNDER",
              textChange: false,
              assetName: "assets/images/giris_button.png",
              onClick: () {
                if (controller.text != "" && controller.text.length > 4) {
                  submit();
                } else {
                  showToast(
                      "Email yada kullanıcı adınızı doğru giriniz.");
                }
              },
              key: UniqueKey(),
            ),
          ],
        ),
      ),
    ));
  }

  void submit() {
    EasyLoading.show();
    HomeController().lostMyPassword(controller.text).then((value) {
      Navigator.pushReplacementNamed(context, "/newPassword");
    }).catchError((onError) {
      EasyLoading.dismiss();
      showToast("Bir hata oluştu.");
    });
  }
}
