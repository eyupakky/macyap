import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({Key? key}) : super(key: key);

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  final List<String> _status = [
    "ÜCRETLİ",
    "EN DÜŞÜK ÜCRET",
    "EN YÜKSEK ÜCRET",
    "EN YAKIN MESAFE",
    "EN ERKEN SAAT",
    "EN GEÇ SAAT",
    "EN DOLU MAÇ",
    "EN BOŞ MAÇ"
  ];
  String _verticalGroupValue = "Pending";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Wrap(
        children: [
          RadioGroup<String>.builder(
            groupValue: _verticalGroupValue,
            onChanged: (value) => setState(() {
              _verticalGroupValue = value!;
            }),
            items: _status,
            topMargin: 18,
            itemBuilder: (item) => RadioButtonBuilder(
              item,
            ),
          ),
          Expanded(
            flex: 1,
            child: TextButton(
                onPressed: () {},
                child: Container(
                  padding: const EdgeInsets.only(top: 4,bottom: 4,right:20,left: 20),
                  color: Colors.blue,
                  child: const Text("İptal",style: TextStyle(color: Colors.white),),
                )),
          ),
          Expanded(
            flex: 1,
            child: TextButton(
                onPressed: () {},
                child: Container(
                  padding: const EdgeInsets.only(top: 4,bottom: 4,right:20,left: 20),
                  color: Colors.blue,
                  child: const Text("Uygula",style: TextStyle(color: Colors.white),),
                )),
          ),
        ],
      ),
    );
  }
}
