import 'package:flutter/material.dart';

class CreateGame extends StatelessWidget {
  CreateGame({Key? key}) : super(key: key);
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FlatButton(
          color: Colors.redAccent,
          onPressed: () {
            _selectDate(context);
          },
          child: Text("tarih"),
        ),
      ),
    );
  }
}
