import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(Duration(days: 5));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: CalendarTimeline(
            showYears: false,
            showMonth: true,
            initialDate: _selectedDate,
            firstDate: DateTime.now(),
            dayHeight: 60,
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              setState(() {
                _selectedDate = date!;
              });
            },
            leftMargin: 20,
            monthColor: Colors.red,
            monthAlpha: 250,
            dayColor: Colors.black,
            dayFontSize: 14,
            dayTextFontSize: 12,
            dayNameColor: Color(0xFF333A47),
            activeDayColor: Colors.white,
            activeBackgroundDayColor: Colors.redAccent[100],
            dotsColor: Color(0xFF333A47),
            //selectableDayPredicate: (date) => date.day != 23,
            locale: 'tr',
          ),
        ),
      ),
    );
  }
}
