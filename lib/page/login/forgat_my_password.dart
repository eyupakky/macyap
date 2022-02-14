import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halisaha/help/ui_guide.dart';
import 'package:halisaha/help/utils.dart';
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
    return  Scaffold(
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
                  decoration: const InputDecoration(
                    hintText: "Kullanıcı adı yada email"
                  ),
                  onChanged: (val){

                  },
                ),
                const SizedBox(height: 20,),
                FlatButton(
                    height: 40,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 100),
                    onPressed: () {
                      if(controller.text!="" && controller.text.length>4){
                        submit();
                      }else{
                        showToast("Email yada kullanıcı adınızı doğru giriniz.");
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
    HomeController().lostMyPassword(controller.text).then((value){
      Navigator.pushReplacementNamed(context, "/newPassword");
    }).catchError((onError){
      EasyLoading.dismiss();
      showToast("Bir hata oluştu.");
    });
  }
}
