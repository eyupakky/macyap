// ignore_for_file: prefer_const_constructors, unused_field

import 'package:animate_do/animate_do.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:halisaha/help/app_context.dart';
import 'package:halisaha/help/hex_color.dart';
import 'package:halisaha/help/ui_guide.dart';
import 'package:halisaha/help/utils.dart';
import 'package:halisaha/widget/check_hizmet_sozlesmesi.dart';
import 'package:halisaha/widget/custom_text_field.dart';
import 'package:halisaha/widget/register_button.dart';
import 'package:halisaha/widget/register_dot.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:repository_eyup/controller/login_controller.dart';
import 'package:repository_eyup/controller/register_controller.dart';
import 'package:repository_eyup/model/city_model.dart';
import 'package:repository_eyup/model/count_model.dart';
import 'package:repository_eyup/model/gender.dart';

class NewRegister extends StatefulWidget {
  const NewRegister({super.key});

  @override
  State<NewRegister> createState() => _NewRegisterState();
}

class _NewRegisterState extends State<NewRegister> {
  late final PageController _pageController;
  late int _currentPage;
  SizeConfig sizeConfig = SizeConfig();
  final format = DateFormat('dd.MM.yyyy');
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
  AutovalidateMode validate = AutovalidateMode.always;
  final _formKey = GlobalKey<FormState>();
  List<Gender> gender = [];
  List<Gender> alan = [];
  PhoneNumber number = PhoneNumber(isoCode: 'TR');
  String phoneNumber = "";
  int? selectedCity = 1;
  int? selectedCountry = 1;
  int? selectedGender = 0;
  String? seciliAlan = "Futbol";
  List<Cities>? cityList = [];
  bool sartlarVeKosullar = false;
  bool gizlilikPolitikasi = false;
  List<Counties>? countiesList = [];

  @override
  void initState() {
    _pageController = PageController();

    super.initState();
    _currentPage = 0;
    _pageController.addListener(() {
      setState(() {
        if (_pageController.page != null) {
          _currentPage = _pageController.page!.toInt();
        }
      });
    });
    registerController = RegisterController();
    gender.add(Gender(0, 'Kadın'));
    gender.add(Gender(1, 'Erkek'));

    alan.add(Gender(0, 'Futbol'));
    alan.add(Gender(1, 'Voleybol'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sizeConfig.init(context);
    return Scaffold(
      body: Stack(
        children: [
          Transform.translate(
            offset: const Offset(-100, -100),
            child: Image.asset(scale: .7, 'assets/images/blob.png'),
          ),
          Column(
            children: [
              Expanded(
                child: SafeArea(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Image.asset(
                          color: Colors.red,
                          UIGuide.pirpleLogo,
                          width: 150,
                          fit: BoxFit.contain,
                        ),
                        Text("Üye ol", style: TextStyle(fontSize: 20)),
                        const SizedBox(height: 20),
                        Expanded(
                          child: PageView(
                            allowImplicitScrolling: true,
                            controller: _pageController,
                            children: [
                              FadeInRight(
                                child: SingleChildScrollView(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: FadeInRight(
                                          child: InternationalPhoneNumberInput(
                                            locale: "tr_TR",
                                            onInputChanged:
                                                (PhoneNumber number) {
                                              phoneNumber = number.phoneNumber!;
                                            },
                                            selectorConfig:
                                                const SelectorConfig(
                                                    leadingPadding: 10,
                                                    selectorType:
                                                        PhoneInputSelectorType
                                                            .DIALOG,
                                                    trailingSpace: false),
                                            initialValue: number,
                                            textStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            keyboardAction:
                                                TextInputAction.next,
                                            inputDecoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                  color: Colors.red,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                  color: Colors.red,
                                                ),
                                              ),
                                              hintText: "Cep telefonunuz",
                                              hintStyle: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            keyboardType: const TextInputType
                                                .numberWithOptions(
                                                signed: true, decimal: true),
                                            inputBorder:
                                                const OutlineInputBorder(),
                                            onSaved: (PhoneNumber number) {
                                              if (kDebugMode) {
                                                print('On Saved: $number');
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomTextField(
                                            nameController: userNameController,
                                            validate: validate,
                                            hintText: "Kullanıcı adınız",
                                            icon: Icons.accessibility,
                                            textInputType:
                                                TextInputType.emailAddress,
                                          ),
                                          CustomTextField(
                                            nameController: nameController,
                                            validate: validate,
                                            hintText: "Adınız",
                                            icon: Icons.person,
                                            textInputType:
                                                TextInputType.emailAddress,
                                          ),
                                          CustomTextField(
                                            nameController: surnameController,
                                            validate: validate,
                                            hintText: "Soyadınız",
                                            icon: Icons.person,
                                            textInputType:
                                                TextInputType.emailAddress,
                                          ),
                                          CustomTextField(
                                            nameController: emailController,
                                            validate: validate,
                                            hintText: "E-posta adresiniz",
                                            icon: Icons.email,
                                            textInputType:
                                                TextInputType.emailAddress,
                                          ),
                                          CustomTextField(
                                            nameController: passwordController,
                                            validate: validate,
                                            hintText: "Şifreniz",
                                            icon: Icons.lock,
                                            textInputType:
                                                TextInputType.emailAddress,
                                            textInputAction:
                                                TextInputAction.done,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              FadeInRight(
                                child: SingleChildScrollView(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: SizedBox(
                                    height: SizeConfig.screenHeight * 0.5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: DropdownSearch<Gender>(
                                                      popupProps:
                                                          PopupProps.menu(
                                                        constraints:
                                                            BoxConstraints(
                                                          maxHeight:
                                                              120.0, // Adjust this value based on your item height and number of items
                                                        ),
                                                      ),
                                                      itemAsString: (u) =>
                                                          u.text,
                                                      onChanged: (d) {
                                                        setState(() {
                                                          selectedGender =
                                                              d!.id;
                                                        });
                                                      },
                                                      compareFn: (item,
                                                              selectedItem) =>
                                                          item.id ==
                                                          selectedItem.id,
                                                      enabled: true,
                                                      dropdownButtonProps:
                                                          const DropdownButtonProps(
                                                        icon: Icon(
                                                          Icons.arrow_drop_down,
                                                          size: 30,
                                                        ),
                                                      ),
                                                      items: gender,
                                                      dropdownDecoratorProps:
                                                          DropDownDecoratorProps(
                                                        dropdownSearchDecoration:
                                                            InputDecoration(
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: HexColor
                                                                    .fromHex(
                                                                        "#f0243a")),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: HexColor
                                                                    .fromHex(
                                                                        "#f0243a")),
                                                          ),
                                                        ),
                                                      ),
                                                      selectedItem: gender[0]),
                                                ),
                                              ),
                                              Expanded(
                                                child: DropdownSearch<Gender>(
                                                    popupProps: PopupProps.menu(
                                                      constraints:
                                                          BoxConstraints(
                                                        maxHeight:
                                                            120.0, // Adjust this value based on your item height and number of items
                                                      ),
                                                    ),
                                                    itemAsString: (u) => u.text,
                                                    onChanged: (d) {
                                                      setState(() {
                                                        seciliAlan = d!.text;
                                                      });
                                                    },
                                                    compareFn:
                                                        (item, selectedItem) =>
                                                            item.id ==
                                                            selectedItem.id,
                                                    items: alan,
                                                    enabled: true,
                                                    dropdownButtonProps:
                                                        const DropdownButtonProps(
                                                      icon: Icon(
                                                        Icons.arrow_drop_down,
                                                        size: 30,
                                                      ),
                                                    ),
                                                    dropdownDecoratorProps:
                                                        DropDownDecoratorProps(
                                                      dropdownSearchDecoration:
                                                          InputDecoration(
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: HexColor
                                                                  .fromHex(
                                                                      "#f0243a")),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: HexColor
                                                                  .fromHex(
                                                                      "#f0243a")),
                                                        ),
                                                      ),
                                                    ),
                                                    selectedItem: alan[0]),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: FutureBuilder<List<Cities>>(
                                            future:
                                                registerController.getCities(),
                                            builder: (context, snapshot) {
                                              if (snapshot.data == null) {
                                                return SizedBox(
                                                  height: 50,
                                                  child: Center(
                                                      child:
                                                          const CircularProgressIndicator()),
                                                );
                                              } else {
                                                var list = snapshot.data;
                                                cityList!.addAll(list!);
                                                EasyLoading.dismiss();
                                              }
                                              return Row(
                                                children: [
                                                  const Expanded(
                                                    child: Text(
                                                      "Şehir seçiniz ",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: DropdownSearch<
                                                            Cities>(
                                                        popupProps:
                                                            const PopupProps
                                                                .menu(
                                                                showSelectedItems:
                                                                    true,
                                                                showSearchBox:
                                                                    false),
                                                        // onFind: (String filter) => getData(filter),
                                                        itemAsString: (u) =>
                                                            u.getCities(),
                                                        onChanged: (d) {
                                                          setState(() {
                                                            selectedCity =
                                                                d!.id;
                                                          });
                                                        },
                                                        compareFn: (item,
                                                                selectedItem) =>
                                                            item.id ==
                                                            selectedItem.id,
                                                        enabled: true,
                                                        dropdownButtonProps:
                                                            const DropdownButtonProps(
                                                          icon: Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            size: 30,
                                                            //   color: Colors.white60,
                                                          ),
                                                        ),
                                                        items: snapshot.data!,
                                                        dropdownDecoratorProps:
                                                            DropDownDecoratorProps(
                                                                dropdownSearchDecoration:
                                                                    InputDecoration(
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: HexColor
                                                                    .fromHex(
                                                                        "#f0243a")),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: HexColor
                                                                    .fromHex(
                                                                        "#f0243a")),
                                                          ),
                                                        )),
                                                        selectedItem:
                                                            cityList![0]),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: FutureBuilder<List<Counties>>(
                                              future: registerController
                                                  .getCounties(
                                                      selectedCity ?? 0),
                                              builder: (context, snapshot) {
                                                if (snapshot.data == null) {
                                                  if (selectedCity != 0) {
                                                    EasyLoading.isShow
                                                        ? EasyLoading.show(
                                                            status:
                                                                'İlçeler yükleniyor...')
                                                        : null;
                                                  }
                                                  return SizedBox(
                                                      height: 50,
                                                      child: Center(
                                                          child:
                                                              const CircularProgressIndicator()));
                                                } else {
                                                  var list = snapshot.data;
                                                  countiesList!.clear();
                                                  countiesList!.addAll(list!);
                                                  EasyLoading.dismiss();
                                                }
                                                return Row(
                                                  children: [
                                                    const Expanded(
                                                      child: Text(
                                                        "İlçe seçiniz ",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: DropdownSearch<
                                                              Counties>(
                                                          popupProps:
                                                              const PopupProps
                                                                  .menu(
                                                                  showSelectedItems:
                                                                      true,
                                                                  showSearchBox:
                                                                      false),
                                                          compareFn: (item,
                                                                  selectedItem) =>
                                                              item.id ==
                                                              selectedItem.id,
                                                          itemAsString: (u) =>
                                                              u.ilce ?? "",
                                                          enabled: true,
                                                          dropdownButtonProps:
                                                              const DropdownButtonProps(
                                                            icon: Icon(
                                                              Icons
                                                                  .arrow_drop_down,
                                                              size: 30,
                                                            ),
                                                          ),
                                                          items: countiesList!,
                                                          dropdownDecoratorProps:
                                                              DropDownDecoratorProps(
                                                                  dropdownSearchDecoration:
                                                                      InputDecoration(
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: HexColor
                                                                      .fromHex(
                                                                          "#f0243a")),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: HexColor
                                                                      .fromHex(
                                                                          "#f0243a")),
                                                            ),
                                                          )),
                                                          onChanged: (d) {
                                                            selectedCountry =
                                                                d!.id;
                                                            if (kDebugMode) {
                                                              print(
                                                                  d.toString());
                                                            }
                                                          },
                                                          selectedItem:
                                                              countiesList![0]),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                        CustomTextField(
                                          nameController: mahalleController,
                                          validate: validate,
                                          hintText: "Mahalle",
                                          icon: Icons.home,
                                          textInputType:
                                              TextInputType.emailAddress,
                                          textInputAction: TextInputAction.done,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          2,
                          (index) => RegisterDot(
                              color: _currentPage == index
                                  ? Color.fromARGB(255, 15, 2, 87)
                                  : Colors.grey.shade400,
                              width: _currentPage == index ? 25 : 15)),
                    ),
                  ),
                  CheckBoxHizmetButton(
                    callback: () {
                      sartlarVeKosullar = !sartlarVeKosullar;
                    },
                    key: UniqueKey(),
                    text1: "Şartlar ve Koşullar",
                    text2: "",
                    url: "https://macyap.com.tr/Views/home/NonuserTerms",
                  ),
                  RegisterButton(
                    height: 75,
                    text: _currentPage == 0 ? "Devam" : "Kayıt Ol",
                    text2: "Kayıt ol",
                    textChange: false,
                    assetName: "assets/images/giris_button.png",
                    onClick: _currentPage == 0
                        ? () {
                            _pageController.animateToPage(1,
                                duration: Duration(milliseconds: 100),
                                curve: Curves.bounceIn);
                          }
                        : () {
                            if (_formKey.currentState!.validate()) {
                              if (sartlarVeKosullar == false) {
                                showToast(
                                    "Şartları kabul etmeden kayıt işlemi yapılamaz...");
                              } else {
                                register();
                              }
                            } else {
                              showToast("Tüm alanları doldurunuz...");
                            }
                          },
                    key: UniqueKey(),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, "/loginwithnumber"),
                    child: RichText(
                      text: TextSpan(
                        text: 'Üye misin? ',
                        style: DefaultTextStyle.of(context).style,
                        children: const [
                          TextSpan(
                            text: 'Giriş Yap',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
              bottom: -120,
              right: -120,
              child: Transform.rotate(
                  angle: 3.14,
                  child: Image.asset(scale: .7, 'assets/images/blob.png'))),
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
    body.putIfAbsent(
        "tel",
        () => phoneNumber.isNotEmpty
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
