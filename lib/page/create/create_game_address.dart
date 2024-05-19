import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:halisaha/help/payment_card.dart';
import 'package:halisaha/help/utils.dart';
import 'package:halisaha/page/create/create_game_team.dart';
import 'package:halisaha/widget/checkbox_button.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:repository_eyup/controller/venues_controller.dart';
import 'package:repository_eyup/model/create_game.dart';
import 'package:repository_eyup/model/venues_model.dart';

import '../../help/hex_color.dart';

class CreateGameAddress extends StatefulWidget {
  CreateGame gameModel;

  CreateGameAddress({Key? key, required this.gameModel}) : super(key: key);

  @override
  State<CreateGameAddress> createState() => _CreateGameAddressState();
}

class _CreateGameAddressState extends State<CreateGameAddress> {
  bool kendiSaham = false, listedeVar = false, ozelOyun = false;
  int selectIndex = 1;
  final _formKey = GlobalKey<FormState>();
  late AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'TR');
  VenuesController _venuesController = VenuesController();
  String phoneNumber = "";
  Venues selectedItem = new Venues();
  VenusModel venusModel = VenusModel();

  @override
  void initState() {
    super.initState();
    venusModel.venues = [];
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Oyunu Başlat > Adres Bilgileri',
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Column(
                children: [
                  CheckBoxButton(
                    select: ozelOyun,
                    text1: "ÖZEL (Yalnızca davet edilen oyuncular girebilir.)",
                    callback: () {
                      setState(() {
                        ozelOyun = !ozelOyun;
                      });
                    },
                  ),
                  CheckBoxButton(
                    select: kendiSaham,
                    text1: "Kendi Saham Var",
                    callback: () {
                      setState(() {
                        kendiSaham = !kendiSaham;
                      });
                    },
                  ),
                  Visibility(
                    visible: kendiSaham,
                    child: CheckBoxButton(
                      select: listedeVar,
                      text1: "Listede Var",
                      callback: () {
                        setState(() {
                          listedeVar = !listedeVar;
                        });
                      },
                    ),
                  ),
                  Visibility(
                      visible: (!listedeVar && kendiSaham),
                      child: kendiSahamVar()),
                  Visibility(
                      visible: (listedeVar || !kendiSaham),
                      child: comboWidget()),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    children: List<Widget>.generate(3, (index) {
                      return Container(
                        width: 10,
                        height: 10,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: selectIndex == index
                              ? Colors.redAccent
                              : Colors.white,
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(
                            25.0,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          setState(() {
                            _autovalidateMode = AutovalidateMode.always;
                          });
                        } else if ((kendiSaham &&
                                listedeVar &&
                                selectedItem.id == 0) ||
                            (!kendiSaham &&
                                !listedeVar &&
                                selectedItem.id == 0)) {
                          showToast("Lütfen mekan seçiniz.");
                        } else {
                          navigate();
                        }
                      },
                      child: const Text("Takım Bilgileri >>"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget comboWidget() {
    return DropdownSearch<Venues>(
        popupProps: const PopupProps.menu(
            showSelectedItems: true, showSearchBox: true),
        itemAsString: (u) => u.name!,
        onChanged: (d) {
          selectedItem = d!;
        },
        enabled: true,
        dropdownButtonProps: const DropdownButtonProps(
          icon: Icon(
            Icons.arrow_drop_down,
            size: 24,
            color: Colors.white60,
          ),
        ),
        items: venusModel.venues!,
        dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: HexColor.fromHex("#f0243a")),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: HexColor.fromHex("#f0243a")),
              ),
            )),
        selectedItem: selectedItem);
  }

  Widget kendiSahamVar() {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Column(
        children: [
          TextFormField(
            maxLines: 1,
            controller: nameController,
            textInputAction: TextInputAction.search,
            onChanged: (String val) {
              // comment = val;
            },
            validator: (val) {
              return val!.isNotEmpty ? null : Strings.fieldReq;
            },
            decoration: InputDecoration(
              hintText: "Özel Saha İsmi *",
              icon: const Icon(
                Icons.title,
                color: Colors.redAccent,
              ),
              labelStyle: const TextStyle(fontSize: 11),
              hintStyle:
                  TextStyle(fontSize: 12, color: Colors.grey.withAlpha(150)),
              // prefixIcon: const Icon(Icons.search),
              // border: const OutlineInputBorder(
              //     borderRadius: BorderRadius.all(
              //         Radius.circular(25.0)))
            ),
          ),
          InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              phoneNumber = number.phoneNumber!;
            },
            selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.DIALOG),
            autoValidateMode: _autovalidateMode,
            initialValue: number,
            errorMessage: "Telefon numarası hatalı",
            inputDecoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(80, 80, 80, 1),
                ),
              ),
              hintText: "Özel Saha Numarası *",
              hintStyle:
                  TextStyle(color: Colors.grey.withAlpha(150), fontSize: 12),
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
          TextFormField(
            maxLines: 2,
            minLines: 2,
            controller: addressController,
            textInputAction: TextInputAction.search,
            onChanged: (String val) {
              // comment = val;
            },
            validator: (val) {
              return val!.isNotEmpty ? null : Strings.fieldReq;
            },
            decoration: InputDecoration(
              hintText: "Özel Adres *",
              icon: const Icon(
                Icons.navigation_sharp,
                color: Colors.redAccent,
              ),
              labelStyle: const TextStyle(fontSize: 11),
              hintStyle:
                  TextStyle(fontSize: 12, color: Colors.grey.withAlpha(150)),
              // prefixIcon: const Icon(Icons.search),
              // border: const OutlineInputBorder(
              //     borderRadius: BorderRadius.all(
              //         Radius.circular(25.0)))
            ),
          ),
        ],
      ),
    );
  }

  void navigate() {
    CreateGame game = widget.gameModel;
    game.ksha = kendiSaham ? 1 : 0;
    game.ksha1 = listedeVar ? 0 : 1;
    game.ozelOyun = ozelOyun ? 1 : 0;
    if (kendiSaham && !listedeVar) {
      game.ozelSahaAdress = addressController.text;
      game.ozelSahaIsim = nameController.text;
      game.ozelSahaTel = phoneNumber;
    }
    if (selectedItem.id != 0) {
      game.venueId = selectedItem.id;
    }
    Navigator.of(context).push(createRoute(CreateGameTeam(
      game: widget.gameModel,
    )));
  }
  getData(){
    _venuesController.getLazyVenues("").then((value) {
      venusModel.venues!.addAll(value.venues!);
    });
  }
}
