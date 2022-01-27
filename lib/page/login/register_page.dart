import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halisaha/base_widget.dart';
import 'package:halisaha/help/app_context.dart';
import 'package:halisaha/help/ui_guide.dart';
import 'package:halisaha/help/utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:repository_eyup/controller/login_controller.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:repository_eyup/controller/register_controller.dart';
import 'package:repository_eyup/model/city_model.dart';
import 'package:repository_eyup/model/count_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  SizeConfig sizeConfig = SizeConfig();
  final f = DateFormat('dd.MM.yyyy');

  BaseContext get appContext => ContextProvider.of(context)!.current;
  late RegisterController registerController;
  final LoginController _loginController = LoginController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AutovalidateMode validate = AutovalidateMode.disabled;
  PhoneNumber number = PhoneNumber(isoCode: 'TR');
  String phoneNumber = "";
  int? selectedCity = 0;
  int? selectedCountry = 0;
  List<Cities>? cityList = [Cities(id: 0, il: "Şehir seçiniz")];
  List<Counties>? countiesList = [
    // Counties(id: 0, ilce: "İlçe seçiniz", ilId: 0)
  ];

  @override
  void initState() {
    super.initState();
    registerController = RegisterController();
  }

  @override
  Widget build(BuildContext context) {
    sizeConfig.init(context);
    return Scaffold(
        body: BaseWidget(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Image.asset(
              UIGuide.pirpleLogo,
              height: SizeConfig.blockSizeVertical * 18,
              fit: BoxFit.fill,
            ),
            _emailFiled(),
          ],
        ),
      ),
    ));
  }

  Widget _emailFiled() {
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: userNameController,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                focusColor: Colors.black,
                hintText: "Kullanıcı adınız",
                hintStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w300, color: Colors.black),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: nameController,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                focusColor: Colors.black,
                hintText: "Adınız",
                hintStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w300, color: Colors.black),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: surnameController,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                focusColor: Colors.black,
                hintText: "Soyadınız",
                hintStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w300, color: Colors.black),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            controller: emailController,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                focusColor: Colors.black,
                hintText: "Email adresi",
                hintStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w300, color: Colors.black),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
            keyboardType: TextInputType.emailAddress,
          ),
          InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              phoneNumber = number.phoneNumber!;
              setState(() {
                validate = AutovalidateMode.always;
              });
            },
            selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.DIALOG),
            autoValidateMode: validate,
            initialValue: number,
            errorMessage: "Telefon numarası hatalı",
            inputDecoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(80, 80, 80, 1),
                ),
              ),
              labelText: "Cep telefonunuz".toUpperCase(),
              labelStyle: const TextStyle(
                  color: Color.fromRGBO(246, 164, 182, 1), fontSize: 14),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(246, 164, 182, 1)),
              ),
            ),
            keyboardType: const TextInputType.numberWithOptions(
                signed: true, decimal: true),
            inputBorder: const OutlineInputBorder(),
            onSaved: (PhoneNumber number) {
              print('On Saved: $number');
            },
          ),
          TextField(
            controller: passwordController,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.remove_red_eye,
                  color: Colors.grey,
                ),
                hintText: "Şifre girin",
                fillColor: Colors.black,
                labelStyle: const TextStyle(color: Colors.black),
                hintStyle: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w300, color: Colors.black),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey))),
            obscureText: true,
          ),
          FutureBuilder<List<Cities>>(
            future: registerController.getCities(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                EasyLoading.show(status: 'Şehirler yükleniyor...');
                return SizedBox();
              } else {
                var list = snapshot.data;
                cityList!.addAll(list!);
                EasyLoading.dismiss();
              }
              return Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                child: DropdownSearch<Cities>(
                    mode: Mode.MENU,
                    // onFind: (String filter) => getData(filter),
                    itemAsString: (u) => u!.getCities(),
                    onChanged: (d) {
                      setState(() {
                        selectedCity = d!.id;
                      });
                    },
                    compareFn: (item, selectedItem) =>
                        item?.id == selectedItem?.id,
                    showSearchBox: true,
                    dropdownSearchBaseStyle: const TextStyle(color: Colors.red),
                    showSelectedItems: true,
                    showAsSuffixIcons: true,
                    items: snapshot.data,
                    dropdownSearchDecoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintStyle: TextStyle(fontSize: 14),
                      labelStyle: TextStyle(
                          color: Color.fromRGBO(246, 164, 182, 1),
                          fontSize: 14),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(80, 80, 80, 1)),
                      ),
                    ),
                    // onChanged: (val) {
                    //   if (val != cityList[0]) {
                    //     selectedCity = val!.id;
                    //   } else {
                    //     selectedCity = 0;
                    //   }
                    // },
                    selectedItem: cityList![0]),
              );
            },
          ),
          FutureBuilder<List<Counties>>(
              future: registerController.getCounties(selectedCity ?? 0),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  if (selectedCity != 0) {
                    EasyLoading.isShow
                        ? EasyLoading.show(status: 'İlçeler yükleniyor...')
                        : null;
                  }
                  return SizedBox();
                } else {
                  var list = snapshot.data;
                  countiesList!.clear();
                  countiesList!.addAll(list!);
                  EasyLoading.dismiss();
                }
                return Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                  child: DropdownSearch<Counties>(
                      mode: Mode.MENU,
                      showSearchBox: true,
                      compareFn: (item, selectedItem) =>
                          item?.id == selectedItem?.id,
                      dropdownSearchBaseStyle:
                          const TextStyle(color: Colors.red),
                      showSelectedItems: true,
                      itemAsString: (u) => u!.ilce ?? "",
                      showAsSuffixIcons: true,
                      items: countiesList,
                      dropdownSearchDecoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintStyle: TextStyle(fontSize: 14),
                        labelStyle: TextStyle(
                            color: Color.fromRGBO(246, 164, 182, 1),
                            fontSize: 14),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromRGBO(80, 80, 80, 1)),
                        ),
                      ),
                      // onChanged: (val) {
                      //   if (val != cityList[0]) {
                      //     selectedCity = val!.id;
                      //   } else {
                      //     selectedCity = 0;
                      //   }
                      // },
                      onChanged: (d) => print(d.toString()),
                      selectedItem: countiesList![0]),
                );
              }),
          const SizedBox(height: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ignore: deprecated_member_use
              FlatButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 130),
                  onPressed: () {
                    register();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    "KAYIT OL",
                    style: GoogleFonts.montserrat(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  color: Colors.blueGrey.withOpacity(0.9))
            ],
          ),
        ],
      ),
    );
  }

  void register() async {
    EasyLoading.show(status: 'Yükleniyor...');
    Map<String, dynamic> body = {};
    body.putIfAbsent("firstname", () => nameController.text);
    body.putIfAbsent("lastname", () => surnameController.text);
    body.putIfAbsent("password", () => passwordController.text);
    body.putIfAbsent("email", () => emailController.text);
    body.putIfAbsent("tel", () => phoneNumber.substring(2, phoneNumber.length));
    body.putIfAbsent("city", () => selectedCity);
    body.putIfAbsent("county", () => selectedCountry);
    body.putIfAbsent("username", () => userNameController.text);
    // body.putIfAbsent("date", () => f.format(DateTime.now()));
    body.putIfAbsent("gender", () => 0);
    registerController.register(body).then((value) {
      EasyLoading.dismiss();
      if (value.success!) {
        showToast(value.description ?? "", color: Colors.green);
        Navigator.pop(context);
      } else {
        showToast(value.description ?? "", color: Colors.red);
      }
    }).catchError((onError) {
      EasyLoading.dismiss();
      showToast(onError, color: Colors.red);
    });
  }
}
