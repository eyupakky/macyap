
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:halisaha/help/utils.dart';

class SearchWidget extends StatelessWidget {
  String hintText;
  FunctionStringCallback callback;

  SearchWidget({Key? key, required this.hintText,required this.callback}) : super(key: key);
  final _debouncer = Debouncer(milliseconds: 700);

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.search,
      onSubmitted: (val) {
        callback(val);
      },
      onEditingComplete: () {},
      onChanged: (String val) {
        _debouncer.run(() {
          callback(val);
        });
      },
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 12, color: Colors.grey.withAlpha(150)),
          prefixIcon: const Icon(Icons.search),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
    );
  }
}

typedef FunctionStringCallback = Function(String result);