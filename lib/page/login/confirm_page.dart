import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/help/app_context.dart';
import 'package:halisaha/help/utils.dart';
import 'package:pinput/pinput.dart';
import 'package:repository_eyup/constant.dart';
import 'package:repository_eyup/controller/account_controller.dart';
import 'package:repository_eyup/controller/register_controller.dart';
import 'package:smart_auth/smart_auth.dart';

class ConfirmPage extends StatefulWidget {
  const ConfirmPage({Key? key}) : super(key: key);

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  final AccountController _accountController = AccountController();
  final RegisterController registerController = RegisterController();
  BaseContext get appContext => ContextProvider.of(context)!.current;

  late final SmsRetriever smsRetriever;
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;
  String correctPin = '';
  String token = '';
  String phoneNumber = '';
  Map<String, dynamic> registerData = {};

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
    smsRetriever = SmsRetrieverImpl(SmartAuth());
    sendOTPCode();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Future<void> sendOTPCode() async {
    //int? userId = await registerController.sendOTPCode(phoneNumber);
    int? userId = 12345;

    if (userId > 0) {
      //correctPin = await registerController.getOTPCode(userId);

      setState(() {
        correctPin = "444444";
      });
    } else {
      showToast("Doğrulama Kodu Gönderilemedi", color: Colors.red);
      Navigator.pop(context);
    }
  }

  Future<void> register() async {
    registerController.register(registerData).then((value) {
      EasyLoading.dismiss();
      if (value.success!) {
        showToast(value.description ?? "", color: Colors.green);
        Constant.accessToken = "temp access token";
        authenticate("temp access token");
      } else {
        showToast(value.description ?? "", color: Colors.red);
        Navigator.pop(context);
      }
    }).catchError((err) {
      EasyLoading.dismiss();
      showToast(err, color: Colors.redAccent);
      Navigator.pop(context);
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
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    phoneNumber = arguments['phoneNumber'];
    registerData = arguments['registerData'];

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
                          arguments['phoneNumber'],
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    Builder(
                      builder: (context) {
                        if (correctPin.isEmpty) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LinearProgressIndicator(),
                                SizedBox(height: 10),
                                Text("Doğrulama Kodu Bekleniyor"),
                              ],
                            ),
                          );
                        }
                        return Directionality(
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
                            length: correctPin.length,
                            controller: pinController,
                            focusNode: focusNode,
                            defaultPinTheme: defaultPinTheme,
                            separatorBuilder: (index) =>
                                const SizedBox(width: 8),
                            validator: (value) {
                              return value == correctPin
                                  ? null
                                  : 'Doğrulama Kodu Hatalı';
                            },
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
                        );
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                      ),
                      onPressed: () {
                        focusNode.unfocus();
                        final answer = formKey.currentState!.validate();

                        if (answer) {
                          register();
                        }
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
