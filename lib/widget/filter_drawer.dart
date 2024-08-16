// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';

typedef TextCallBack = void Function(String);

class FilterDrawer extends StatefulWidget {
  TextCallBack callBack;
  String selectItem;

  FilterDrawer({Key? key, required this.callBack, required this.selectItem})
      : super(key: key);

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  final List<String> _status = [
    // "ÜCRETLİ",
    "EN DÜŞÜK ÜCRET",
    "EN YÜKSEK ÜCRET",
    // "EN YAKIN MESAFE",
    "EN ERKEN SAAT",
    "EN GEÇ SAAT",
    "EN DOLU MAÇ",
    "EN BOŞ MAÇ"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioGroup<String>.builder(
          groupValue: widget.selectItem,
          onChanged: (value) => setState(() {
            widget.selectItem = value!;
          }),
          items: _status,
          topMargin: 18,
          itemBuilder: (item) => RadioButtonBuilder(
            item,
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, right: 5, left: 5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.blue,
                    ),
                    child: const Text(
                      "İptal",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
            Expanded(
              flex: 1,
              child: TextButton(
                  onPressed: () {
                    widget.callBack(widget.selectItem);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, right: 18, left: 18),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.blue,
                    ),
                    child: const Text(
                      "Uygula",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
