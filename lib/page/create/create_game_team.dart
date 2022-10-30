import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/help/payment_card.dart';
import 'package:halisaha/help/utils.dart';
import 'package:halisaha/page/create/create_game_address.dart';
import 'package:intl/intl.dart';
import 'package:repository_eyup/controller/home_controller.dart';
import 'package:repository_eyup/model/create_game.dart';

class CreateGameTeam extends StatefulWidget {
  CreateGame game;

  CreateGameTeam({Key? key, required this.game}) : super(key: key);

  @override
  State<CreateGameTeam> createState() => _CreateGameTeamState();
}

class _CreateGameTeamState extends State<CreateGameTeam> {
  DateTime selectedDate = DateTime.now();
  TextEditingController playerCountController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController gamePriceController = TextEditingController();
  String cinsiyet = "Karma";
  String gameType = "Futbol";
  HomeController _homeController = HomeController();
  final _formKey = GlobalKey<FormState>();
  late AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  int selectedIndex = 2;

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
          'Oyunu Başlat > Takım Bilgileri',
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: Column(
                children: [
                  TextFormField(
                    controller: playerCountController, // add this line.
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Takımlardaki oyuncu sayısı (5-14 arası)',
                        labelStyle: const TextStyle(fontSize: 11),
                        hintStyle: TextStyle(
                            fontSize: 12, color: Colors.grey.withAlpha(150)),
                        icon: const Icon(
                          Icons.person,
                          color: Colors.red,
                        )),
                    validator: (value) {
                      return value!.isEmpty
                          ? "Bu alan gereklidir.."
                          : (int.parse(value) > 4 && int.parse(value) < 15
                              ? null
                              : "Takımlar en az 5, en çok 14 kişi olabilir.");
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropdownButtonFormField<String>(
                    value: cinsiyet,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent)),
                      icon: Icon(
                        Icons.people_rounded,
                        color: Colors.redAccent,
                      ),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        cinsiyet = newValue!;
                      });
                    },
                    validator: (val) {
                      return null;
                    },
                    items: <String>['Karma', 'Erkek', 'Kadın']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                        ),
                      );
                    }).toList(),
                  ),
                  DropdownButtonFormField<String>(
                    value: gameType,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent)),
                      icon: Icon(
                        Icons.sports_esports,
                        color: Colors.redAccent,
                      ),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        gameType = newValue!;
                      });
                    },
                    validator: (val) {
                      return null;
                    },
                    items: <String>['Futbol', 'Voleybol']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLines: 1,
                    controller: gamePriceController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onChanged: (String val) {
                      // comment = val;
                    },
                    validator: (val) {
                      return val!.isNotEmpty ? null : Strings.fieldReq;
                    },
                    decoration: InputDecoration(
                      hintText: "Oyuna giriş fiyat *",
                      icon: const Icon(
                        Icons.monetization_on,
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
                    textInputAction: TextInputAction.next,
                    onChanged: (String val) {
                      // comment = val;
                    },
                    controller: tagController,
                    decoration: InputDecoration(
                      label: const Text("Maç Tagleri"),
                      hintText: "#örnek1,#örnek2,#örnek3",
                      icon: const Icon(
                        Icons.tag,
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
                          color: selectedIndex == index
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
                          saveGame();
                        }
                      },
                      child: const Text("Oyunu Kaydet"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void saveGame() {
    EasyLoading.show();
    CreateGame gameMode = widget.game;
    gameMode.tagler = tagController.text;
    gameMode.gameLimit = int.parse(playerCountController.text);
    gameMode.gender = cinsiyet;
    gameMode.gameType = gameType;
    gameMode.gamePrice = gamePriceController.text;
    _homeController.createGame(gameMode).then((value) {
      EasyLoading.dismiss();
      showToast(value.description!);
      Navigator.pushNamedAndRemoveUntil(
          context, "/home", ModalRoute.withName('/createGame'));
    }).catchError((onError) {
      EasyLoading.dismiss();
      showToast(onError);
    });
  }
}
