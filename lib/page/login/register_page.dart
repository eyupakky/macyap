import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halisaha/base_widget.dart';
import 'package:halisaha/help/app_context.dart';
import 'package:halisaha/help/hex_color.dart';
import 'package:halisaha/help/ui_guide.dart';
import 'package:halisaha/help/utils.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/widget/custom_button.dart';
import 'package:intl/intl.dart';
import 'package:repository_eyup/controller/login_controller.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:repository_eyup/controller/register_controller.dart';
import 'package:repository_eyup/model/city_model.dart';
import 'package:repository_eyup/model/count_model.dart';
import 'package:repository_eyup/model/gender.dart';

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
  TextEditingController mahalleController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AutovalidateMode validate = AutovalidateMode.disabled;
  final _formKey = GlobalKey<FormState>();
  List<Gender> gender=[];
  List<Gender> alan=[];
  PhoneNumber number = PhoneNumber(isoCode: 'TR');
  String phoneNumber = "";
  int? selectedCity = 0;
  int? selectedCountry = 0;
  int? selectedGender = 0;
  String? seciliAlan="Futbol";
  List<Cities>? cityList = [];
  List<Counties>? countiesList = [
    // Counties(id: 0, ilce: "İlçe seçiniz", ilId: 0)
  ];

  @override
  void initState() {
    super.initState();
    registerController = RegisterController();
    gender.add(Gender(0,'Kadın'));
    gender.add(Gender(1,'Erkek'));

    alan.add(Gender(0,'Futbol'));
    alan.add(Gender(1,'Voleybol'));
  }

  @override
  Widget build(BuildContext context) {
    sizeConfig.init(context);
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.asset("assets/images/giris_ng.jpg").image,
              fit: BoxFit.fill)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              UIGuide.pirpleLogo,
              width: SizeConfig.blockSizeVertical * 24,
              fit: BoxFit.contain,
            ),
            Text("Üye ol",
                style: TextStyle(
                    color: HexColor.fromHex("#f0243a"), fontSize: 18)),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin:
                  const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
              child: InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  phoneNumber = number.phoneNumber!;
                },
                selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.DIALOG),
                initialValue: number,
                inputDecoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: HexColor.fromHex("#f0243a"),
                    ),
                  ),
                  labelText: "Cep telefonunuz (Zorunlu değil.)".toUpperCase(),
                  labelStyle: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400,
                      color: Colors.white60,
                      fontSize: 10),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: HexColor.fromHex("#f0243a")),
                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                inputBorder: const OutlineInputBorder(),
                onSaved: (PhoneNumber number) {
                  print('On Saved: $number');
                },
              ),
            ),
            _emailFiled(),
          ],
        ),
      ),
    ));
  }

  Widget _emailFiled() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: userNameController,
              style: const TextStyle(color: Colors.white),
              autovalidateMode: validate,
              decoration: InputDecoration(
                  focusColor: Colors.black,
                  hintText: "Kullanıcı adınız",
                  hintStyle: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400, color: Colors.white60),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: HexColor.fromHex("#f0243a")))),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: nameController,
              style: const TextStyle(color: Colors.white),
              autovalidateMode: validate,
              decoration: InputDecoration(
                  focusColor: Colors.black,
                  hintText: "Adınız",
                  hintStyle: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400, color: Colors.white60),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: HexColor.fromHex("#f0243a")))),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: surnameController,
              style: const TextStyle(color: Colors.white),
              autovalidateMode: validate,
              decoration: InputDecoration(
                  focusColor: Colors.black,
                  hintText: "Soyadınız",
                  hintStyle: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400, color: Colors.white60),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: HexColor.fromHex("#f0243a")))),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: emailController,
              autovalidateMode: validate,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  focusColor: Colors.black,
                  hintText: "Email adresi",
                  hintStyle: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400, color: Colors.white60),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: HexColor.fromHex("#f0243a")))),
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              controller: passwordController,
              style: const TextStyle(color: Colors.white),
              autovalidateMode: validate,
              decoration: InputDecoration(
                  hintText: "Şifre girin",
                  fillColor: Colors.black,
                  labelStyle: const TextStyle(color: Colors.white),
                  hintStyle: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400, color: Colors.white60),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: HexColor.fromHex("#f0243a")))),
            ),
            DropdownSearch<Gender>(
                mode: Mode.MENU,
                itemAsString: (u) => u!.text,
                onChanged: (d) {
                  setState(() {
                    selectedGender = d!.id;
                  });
                },
                compareFn: (item, selectedItem) =>
                item?.id == selectedItem?.id,
                showSearchBox: false,
                showSelectedItems: true,
                showAsSuffixIcons: true,
                dropDownButton: const Icon(
                  Icons.arrow_drop_down,
                  size: 24,
                  color: Colors.white60,
                ),
                items: gender,
                dropdownSearchDecoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: HexColor.fromHex("#f0243a")),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: HexColor.fromHex("#f0243a")),
                  ),
                ),
                selectedItem: gender[0]),
            DropdownSearch<Gender>(
                mode: Mode.MENU,
                itemAsString: (u) => u!.text,
                onChanged: (d) {
                  setState(() {
                    seciliAlan = d!.text;
                  });
                },
                compareFn: (item, selectedItem) =>
                item?.id == selectedItem?.id,
                showSearchBox: false,
                showSelectedItems: true,
                showAsSuffixIcons: true,
                dropDownButton: const Icon(
                  Icons.arrow_drop_down,
                  size: 24,
                  color: Colors.white60,
                ),
                items: alan,
                dropdownSearchDecoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: HexColor.fromHex("#f0243a")),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: HexColor.fromHex("#f0243a")),
                  ),
                ),
                selectedItem: alan[0]),
            FutureBuilder<List<Cities>>(
              future: registerController.getCities(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  //EasyLoading.show(status: 'Şehirler yükleniyor...');
                  return const SizedBox();
                } else {
                  var list = snapshot.data;
                  cityList!.addAll(list!);
                  EasyLoading.dismiss();
                }
                return Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text(
                        "Şehir seçiniz ",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white60, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex: 2,
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
                          showSelectedItems: true,
                          showAsSuffixIcons: true,
                          dropDownButton: const Icon(
                            Icons.arrow_drop_down,
                            size: 24,
                            color: Colors.white60,
                          ),
                          items: snapshot.data,
                          dropdownSearchDecoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: HexColor.fromHex("#f0243a")),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: HexColor.fromHex("#f0243a")),
                            ),
                          ),
                          selectedItem: cityList![0]),
                    ),
                  ],
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
                    return const SizedBox();
                  } else {
                    var list = snapshot.data;
                    countiesList!.clear();
                    countiesList!.addAll(list!);
                    EasyLoading.dismiss();
                  }
                  return Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Text(
                          "İlçe seçiniz ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: DropdownSearch<Counties>(
                            mode: Mode.MENU,
                            showSearchBox: true,
                            compareFn: (item, selectedItem) =>
                                item?.id == selectedItem?.id,
                            dropdownSearchBaseStyle:
                                const TextStyle(color: Colors.white60),
                            showSelectedItems: true,
                            itemAsString: (u) => u!.ilce ?? "",
                            showAsSuffixIcons: true,
                            dropDownButton: const Icon(
                              Icons.arrow_drop_down,
                              size: 24,
                              color: Colors.white60,
                            ),
                            items: countiesList,
                            dropdownSearchDecoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: HexColor.fromHex("#f0243a")),
                              ),
                              hintStyle: const TextStyle(fontSize: 14),
                              // labelStyle: const TextStyle(
                              //     color: Color.fromRGBO(246, 164, 182, 1),
                              //     fontSize: 14),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: HexColor.fromHex("#f0243a")),
                              ),
                            ),
                            onChanged: (d) {
                              selectedCountry = d!.id;
                              print(d.toString());
                            },
                            selectedItem: countiesList![0]),
                      ),
                    ],
                  );
                }),
            TextFormField(
              controller: mahalleController,
              style: const TextStyle(color: Colors.white),
              autovalidateMode: validate,
              decoration: InputDecoration(
                  focusColor: Colors.black,
                  hintText: "Mahalle",
                  hintStyle: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w400, color: Colors.white60),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(color: HexColor.fromHex("#f0243a")))),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10,),
            CustomButton(
              height: 75,
              text: "Kayıt ol",
              text2: "Kayıt ol",
              textChange: false,
              assetName: "assets/images/giris_button.png",
              onClick: () {
                if (_formKey.currentState!.validate()) {
                  register();
                }
              },
              key: UniqueKey(),
            ),
            Row(
              children: [
                const Expanded(flex: 1,child: Text("")),
                Expanded(
                  flex: 4,
                  child: Text(
                    "Zaten üye misin?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Expanded(
                  flex:5,
                  child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      child: createUser()),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget createUser() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: 120,
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 90,
                child: Text(
                  "ÜYE GİRİŞİ   ",
                  textAlign: TextAlign.right,
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Icon(
              Icons.navigate_next,
              size: 24,
              color: HexColor.fromHex("#f0243a"),
            ),
          ],
        ),
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
    body.putIfAbsent("tel",() => phoneNumber.isNotEmpty
            ? phoneNumber.substring(2, phoneNumber.length)
            : "5555555555");
    body.putIfAbsent("city", () => selectedCity);
    body.putIfAbsent("county", () => selectedCountry);
    body.putIfAbsent("username", () => userNameController.text);
    // body.putIfAbsent("date", () => f.format(DateTime.now()));
    body.putIfAbsent("gender", () => selectedGender);
    body.putIfAbsent("alan", () => '$seciliAlan');
    body.putIfAbsent("neighborhood", () => mahalleController.text);
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
