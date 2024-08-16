import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:halisaha/help/payment_card.dart';
import 'package:halisaha/help/utils.dart';
import 'package:halisaha/page/create/create_game_address.dart';
import 'package:intl/intl.dart';
import 'package:repository_eyup/model/create_game.dart';

class CreateGamePage extends StatefulWidget {
  const CreateGamePage({Key? key}) : super(key: key);

  @override
  State<CreateGamePage> createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  DateTime selectedDate = DateTime.now();
  TextEditingController timeCtl = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final format = DateFormat("dd-MM-yyyy");

  final _formKey = GlobalKey<FormState>();
  int selectIndex = 0;
  late AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  late CreateGame gameMode = CreateGame();

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
          'Oyunu Başlat > Maç Bilgileri',
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
                  const Text(
                    "Lütfen, oyunun planlanan başlama süresinden 4 saat önce yarıdan fazla açıklık bırakması durumunda, sistem tarafından otomatik olarak iptal edileceğini unutmayın.",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Montserrat-normal",
                        fontSize: 12),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text.rich(TextSpan(
                      text:
                          "Organizatörlerin maç başlatırken Kendi Sahası Yok İse ",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Montserrat-normal",
                          fontSize: 12),
                      children: [
                        TextSpan(
                            text: " 150 TL ",
                            style: TextStyle(
                                color: Colors.red,
                                fontFamily: "Montserrat-bold")),
                        TextSpan(text: "ödeme yapıcaklardır.")
                      ])),
                  const SizedBox(
                    height: 20,
                  ),
                  DateTimeField(
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    textAlign: TextAlign.left,
                    controller: dateController,
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.today,
                        color: Colors.redAccent,
                      ),
                      hintText: 'Maç tarihi *',
                      labelStyle: const TextStyle(fontSize: 11),
                      hintStyle: TextStyle(
                          fontSize: 12, color: Colors.grey.withAlpha(150)),
                    ),
                    format: format,
                    onShowPicker: (cntx, currentValue) {
                      return showDatePicker(
                          firstDate: DateTime.now(),
                          initialDate: DateTime.now(),
                          lastDate: DateTime(
                              DateTime.now().year, DateTime.now().month + 2),
                          context: context);
                    },
                    validator: (value) {
                      if ((value.toString().isEmpty) ||
                          (DateTime.tryParse(value.toString()) == null)) {
                        return 'Lütfen uygun bir tarih giriniz.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      // birthDay =f.format(value);
                    },
                  ),
                  TextFormField(
                    controller: timeCtl, // add this line.
                    decoration: InputDecoration(
                        hintText: 'Saat *',
                        labelStyle: const TextStyle(fontSize: 11),
                        hintStyle: TextStyle(
                            fontSize: 12, color: Colors.grey.withAlpha(150)),
                        icon: const Icon(
                          Icons.access_time_outlined,
                          color: Colors.red,
                        )),
                    onTap: () async {
                      TimeOfDay time = TimeOfDay.now();
                      FocusScope.of(context).requestFocus(FocusNode());

                      TimeOfDay? picked = await showTimePicker(
                          context: context, initialTime: time);
                      if (picked != null && picked != time) {
                        timeCtl.text =
                            '${picked.hour}:${picked.minute}'; // add this line.
                        setState(() {
                          time = picked;
                        });
                      }
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Strings.fieldReq;
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    maxLines: 1,
                    controller: titleController,
                    textInputAction: TextInputAction.search,
                    onChanged: (String val) {
                      // comment = val;
                    },
                    validator: (val) {
                      return val!.isNotEmpty ? null : Strings.fieldReq;
                    },
                    decoration: InputDecoration(
                      hintText: "Başlık *",
                      icon: const Icon(
                        Icons.title,
                        color: Colors.redAccent,
                      ),
                      labelStyle: const TextStyle(fontSize: 11),
                      hintStyle: TextStyle(
                          fontSize: 12, color: Colors.grey.withAlpha(150)),
                      // prefixIcon: const Icon(Icons.search),
                      // border: const OutlineInputBorder(
                      //     borderRadius: BorderRadius.all(
                      //         Radius.circular(25.0)))
                    ),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.search,
                    onChanged: (String val) {
                      // comment = val;
                    },
                    validator: (val) {
                      return val!.isNotEmpty ? null : Strings.fieldReq;
                    },
                    minLines: 3,
                    maxLines: 4,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: "Açıklama *",
                      icon: const Icon(
                        Icons.description,
                        color: Colors.redAccent,
                      ),
                      labelStyle: const TextStyle(fontSize: 11),
                      hintStyle: TextStyle(
                          fontSize: 12, color: Colors.grey.withAlpha(150)),
                      // prefixIcon: const Icon(Icons.search),
                      // border: const OutlineInputBorder(
                      //     borderRadius: BorderRadius.all(
                      //         Radius.circular(25.0)))
                    ),
                  ),
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
                        } else {
                          navigate();
                        }
                      },
                      child: const Text("Adres bilgileri >>"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navigate() {
    gameMode.gameDesc = descriptionController.text;
    gameMode.gameTitle = titleController.text;
    //21-01-2022 02:02
    gameMode.gameDate = dateController.text + ' ' + timeCtl.text;
    Navigator.of(context).push(createRoute(CreateGameAddress(
      gameModel: gameMode,
    )));
  }
}
