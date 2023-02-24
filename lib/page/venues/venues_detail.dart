import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/help/utils.dart';
import 'package:halisaha/widget/custom_button.dart';
import 'package:repository_eyup/controller/register_controller.dart';
import 'package:repository_eyup/controller/venues_controller.dart';
import 'package:repository_eyup/model/city_model.dart';
import 'package:repository_eyup/model/count_model.dart';
import 'package:repository_eyup/model/urun_details.dart';

import '../../help/hex_color.dart';

class VenuesDetail extends StatefulWidget {
  VenuesDetail({Key? key}) : super(key: key);

  @override
  State<VenuesDetail> createState() => _VenuesDetailState();
}

class _VenuesDetailState extends State<VenuesDetail>
    with SingleTickerProviderStateMixin {
  CarouselController _controller = CarouselController();
  final VenuesController _venuesController = VenuesController();
  late UrunDetailModel detailModel = UrunDetailModel();
  late int urunId;
  int _selectedIndex = 0;
  int adet = 1;
  Color selectedColor = Colors.red;
  String url = "";
  final List<String> imgList = [];
  int _current = 0;
  TextEditingController addressController = TextEditingController();
  late RegisterController registerController;
  List<Cities>? cityList = [];
  List<Counties>? countiesList = [];
  Counties? selectedCountry = Counties(id: 0);
  Cities? selectedCity = Cities(id: 0);
  List<int> list = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int cityId = 0;

  @override
  void initState() {
    super.initState();
    registerController = RegisterController();
  }

  @override
  Widget build(BuildContext context) {
    urunId = ModalRoute.of(context)!.settings.arguments as int;

    return FutureBuilder<UrunDetailModel>(
        future: _venuesController.getShoppingDetail(urunId),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(child: Text("Sonuç bekleniyor..."));
          }
          EasyLoading.dismiss();
          detailModel = snapshot.data ?? UrunDetailModel();
          imgList.clear();
          imgList.add(
              'https://macyap.com.tr/Content/UrunImg/${detailModel.value!.img}');
          imgList.add(
              'https://macyap.com.tr/Content/UrunImg/${detailModel.value!.img2}');
          imgList.add(
              'https://macyap.com.tr/Content/UrunImg/${detailModel.value!.img3}');
          imgList.add(
              'https://macyap.com.tr/Content/UrunImg/${detailModel.value!.img4}');
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                '${detailModel.value!.baslik}',
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(children: [
                  CarouselSlider(
                    items: imgList
                        .map((item) => Container(
                              height: MediaQuery.of(context).size.height * 0.8,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0)),
                                  child: Stack(
                                    children: <Widget>[
                                      Image.network(item,
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.8,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width),
                                    ],
                                  )),
                            ))
                        .toList(),
                    carouselController: _controller,
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                  SizedBox(
                    height: 20,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imgList
                            .map((e) => Container(
                                  width: 12.0,
                                  height: 12.0,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black)
                                          .withOpacity(
                                              _current == imgList.indexOf(e)
                                                  ? 0.9
                                                  : 0.4)),
                                ))
                            .toList()),
                  ),
                  const Text("Beden Seçiniz"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: choiceChips(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Row(
                      children: [
                        const Expanded(flex: 2, child: Text("Adet :")),
                        Expanded(
                          flex: 8,
                          child: Container(
                            margin:
                                const EdgeInsets.only(right: 18.0, left: 18),
                            child: DropdownButton<int>(
                              value: adet,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              elevation: 16,
                              style: const TextStyle(color: Colors.red),
                              underline: Container(
                                height: 0.5,
                                color: Colors.red,
                              ),
                              onChanged: (int? value) {
                                setState(() {
                                  adet = value ?? 0;
                                });
                              },
                              items:
                                  list.map<DropdownMenuItem<int>>((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: SizedBox(
                                      child: Text(
                                    '$value',
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  )),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder<List<Cities>>(
                    future: registerController.getCities(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        //EasyLoading.show(status: 'Şehirler yükleniyor...');
                        return const SizedBox();
                      } else {
                        var list = snapshot.data;
                        cityList!.add(Cities(id: 0, il: "Şehir seçiniz"));
                        cityList!.addAll(list!);
                        EasyLoading.dismiss();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18),
                        child: Row(
                          children: [
                            const Expanded(flex: 2, child: Text("Şehir :")),
                            Expanded(
                              flex: 6,
                              child: DropdownSearch<Cities>(
                                  mode: Mode.MENU,
                                  // onFind: (String filter) => getData(filter),
                                  itemAsString: (u) => u!.getCities(),
                                  dropdownSearchTextAlign: TextAlign.center,
                                  dropdownSearchTextAlignVertical:
                                      TextAlignVertical.center,
                                  onChanged: (d) {
                                    setState(() {
                                      selectedCity = d;
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
                                    color: Colors.white,
                                  ),
                                  items: snapshot.data,
                                  dropdownSearchDecoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.5,
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
                        ),
                      );
                    },
                  ),
                  FutureBuilder<List<Counties>>(
                    future:
                        registerController.getCounties(selectedCity!.id ?? 0),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        if (selectedCity != 0) {
                          EasyLoading.isShow
                              ? EasyLoading.show(
                                  status: 'İlçeler yükleniyor...')
                              : null;
                        }
                        return const SizedBox();
                      } else {
                        var list = snapshot.data;
                        countiesList!.clear();
                        countiesList!.addAll(list!);
                        EasyLoading.dismiss();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18),
                        child: Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                "İlçe ",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Expanded(
                              flex: 6,
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
                                          width: 0.5,
                                          color: HexColor.fromHex("#f0243a")),
                                    ),
                                    hintStyle: const TextStyle(fontSize: 14),
                                    // labelStyle: const TextStyle(
                                    //     color: Color.fromRGBO(246, 164, 182, 1),
                                    //     fontSize: 14),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.5,
                                          color: HexColor.fromHex("#f0243a")),
                                    ),
                                  ),
                                  onChanged: (d) {
                                    selectedCountry = d;
                                    print(d.toString());
                                  },
                                  selectedItem: countiesList![0]),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 18, top: 8),
                      child: const Text(
                        "Adres :",
                        textAlign: TextAlign.left,
                      )),
                  Container(
                    margin: const EdgeInsets.only(left: 18, right: 18),
                    child: TextFormField(
                      controller: addressController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0.5, color: Colors.red), //<-- SEE HERE
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    height: 75,
                    text: "Satın Al",
                    text2: "Satın Al",
                    textChange: false,
                    assetName: "assets/images/giris_button.png",
                    onClick: () {
                      if (adet > 0 &&
                          selectedCity!.id! > 0 &&
                          selectedCountry!.id! > 0 &&
                          addressController.text.isNotEmpty) {
                        siparisVer();
                      } else {
                        showToast("Boş Alanları Doldurunuz.");
                      }
                    },
                    key: UniqueKey(),
                  ),
                ]),
              ),
            ),
          );
        });
  }

  List<Widget> choiceChips() {
    List<Widget> chips = [];
    for (int i = 0; i < detailModel.value!.bedenList!.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: ChoiceChip(
          label: Text('${detailModel.value!.bedenList![i].beden}'),
          labelStyle: TextStyle(
              color: (_selectedIndex == i ? Colors.red : Colors.black)),
          backgroundColor:
              _selectedIndex == i ? Colors.red : Colors.grey.shade50,
          selected: _selectedIndex == i,
          selectedColor: Colors.grey.shade300,
          onSelected: (bool value) {
            setState(() {
              _selectedIndex = i;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }

  siparisVer() {
    _venuesController
        .siparisVer(urunId, _selectedIndex, adet,
            addressController.text + ' ${selectedCity!.il} / ${selectedCountry!.ilce}')
        .then((value) {
      if (value.success!) {
        showToast(
            "Sipariş başarılı. Profil ekranından siparişinizin durumunu görebilirsiniz.");
        Navigator.pop(context);
      } else {
        showToast('${value.description}');
      }
    }).catchError((onError) {
      showToast(onError);
    });
  }
}
