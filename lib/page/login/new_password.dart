import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halisaha/help/ui_guide.dart';
import 'package:halisaha/help/utils.dart';
import 'package:repository_eyup/controller/home_controller.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  @override
  void initState() {
    super.initState();
    EasyLoading.dismiss();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    UIGuide.pirpleLogo,
                    height: SizeConfig.blockSizeVertical * 18,
                    fit: BoxFit.fill,
                  ),
                ),
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(hintText: "Yeni şifre"),
                  onChanged: (val) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: controller2,
                  decoration: const InputDecoration(hintText: "Kod"),
                  onChanged: (val) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                FlatButton(
                    height: 40,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 100),
                    onPressed: () {
                      if (controller.text != "" &&
                          controller.text.length > 4 &&
                          controller2.text != "" &&
                          controller2.text.length > 4) {
                        submit();
                      } else {
                        showToast("Tüm alanları doldurunuz.");
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "GÖNDER",
                      style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    color: Colors.redAccent.withOpacity(0.9))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submit() {
    EasyLoading.show();
    HomeController()
        .resetMyPassword(controller.text, controller2.text)
        .then((value) {
          if(value){
            showToast("Şifre değiştirme başarılı.",color: Colors.green);
            EasyLoading.dismiss();
            Navigator.pushReplacementNamed(context, "/login");
          }else{
            showToast("Bir hata oluştu.");
          }
    }).catchError((onError) {
      showToast(onError);
      EasyLoading.dismiss();
    });
  }
}
