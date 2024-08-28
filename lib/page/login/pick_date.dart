import 'package:flutter/material.dart';

class PickDate extends StatefulWidget {
  const PickDate({
    super.key,
    required this.onDateChanged,
  });

  final Function(String) onDateChanged;

  @override
  State<PickDate> createState() => _PickDateState();
}

class _PickDateState extends State<PickDate> {
  String selectedDate = "Doğum Tarihiniz";

  void changeDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime(1998, 3, 5),
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
    ).then((value) {
      setState(() {
        selectedDate = value.toString().substring(0, 10);
        widget.onDateChanged(selectedDate);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => changeDate(),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.red),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () => changeDate(),
              icon: const Icon(Icons.calendar_today),
            ),
            Expanded(
              child: Text(
                selectedDate,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
