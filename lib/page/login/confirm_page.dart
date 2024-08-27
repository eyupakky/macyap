import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/help/app_context.dart';
import 'package:halisaha/help/utils.dart';
import 'package:pinput/pinput.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/controller/account_controller.dart';
import 'package:repository_eyup/controller/login_controller.dart';
import 'package:smart_auth/smart_auth.dart';

class ConfirmPage extends StatefulWidget {
  final Map<String, dynamic>? data;
  const ConfirmPage({Key? key, this.data}) : super(key: key);

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  final AccountController _accountController = AccountController();
  final LoginController _loginController = LoginController();
  BaseContext get appContext => ContextProvider.of(context)!.current;

  late final SmsRetriever smsRetriever;
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;
  late final int userId;
  String phoneNumber = '';

  @override
  void initState() {
    super.initState();
    phoneNumber = widget.data!["phoneNumber"];
    userId = widget.data!["userId"];
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
    smsRetriever = SmsRetrieverImpl(SmartAuth());
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Future<void> login(int code, int userId) async {
    EasyLoading.show(status: "Kontrol ediliyor...");
    _loginController.smsVerification(code, userId).then((value) {
      if (value["isSuccess"] ?? false) {
        EasyLoading.dismiss();
        Constant.accessToken = value["userToken"];
        authenticate(value["userToken"]);
      }
    }).catchError((err) {
      EasyLoading.dismiss();
      showToast(err, color: Colors.redAccent);
    });
  }

  Future<void> authenticate(String accessToken) async {
    appContext.setAccessToken(accessToken);

    _accountController.getMyUser().then((value) {
      Constant.image = value.image!;
      Constant.userId = value.userId!;
      Constant.userName = value.username!;
      Constant.name = value.firstname!;
      Constant.surname = value.lastname!;
      appContext.setMyUser(value);
      Navigator.pushReplacementNamed(context, "/home");
    }).catchError((err) {
      EasyLoading.dismiss();
      showToast(err, color: Colors.redAccent);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor, width: 2),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/images/otp.gif',
                      width: MediaQuery.of(context).size.width * 0.5,
                      fit: BoxFit.contain,
                    ),
                    Column(
                      children: [
                        const Text("Doğrulama kodu şuraya gönderildi",
                            style: TextStyle(fontSize: 18)),
                        const SizedBox(height: 10),
                        Text(
                          phoneNumber,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        errorBuilder: (errorText, pin) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                textAlign: TextAlign.center,
                                errorText ?? '',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          );
                        },
                        smsRetriever: smsRetriever,
                        length: 6,
                        controller: pinController,
                        focusNode: focusNode,
                        defaultPinTheme: defaultPinTheme,
                        separatorBuilder: (index) => const SizedBox(width: 8),
                        // validator: (value) {
                        //   return value == correctPin
                        //       ? null
                        //       : 'Doğrulama Kodu Hatalı';
                        // },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 9),
                              width: 22,
                              height: 1,
                              color: focusedBorderColor,
                            ),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            color: fillColor,
                            borderRadius: BorderRadius.circular(19),
                            border: Border.all(color: focusedBorderColor),
                          ),
                        ),
                        errorPinTheme: defaultPinTheme.copyBorderWith(
                          border: Border.all(color: Colors.redAccent),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                      ),
                      onPressed: () {
                        focusNode.unfocus();
                        // final answer = formKey.currentState!.validate();

                        // if (answer) {
                        //   login();
                        // }

                        login(
                            int.tryParse(pinController.text) ?? 000000, userId);
                      },
                      child: const Text(
                        "Devam Et",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SmsRetrieverImpl implements SmsRetriever {
  const SmsRetrieverImpl(this.smartAuth);

  final SmartAuth smartAuth;

  @override
  Future<void> dispose() {
    return smartAuth.removeSmsListener();
  }

  @override
  Future<String?> getSmsCode() async {
    final res = await smartAuth.getSmsCode(useUserConsentApi: true);
    if (res.succeed && res.codeFound) {
      return res.code!;
    }
    return null;
  }

  @override
  bool get listenForMultipleSms => false;
}
