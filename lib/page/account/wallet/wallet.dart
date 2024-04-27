import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:repository_eyup/controller/wallet_controller.dart';
import 'package:repository_eyup/model/payment_history_model.dart';

import '../../../help/payment_card.dart';

class WalletPage extends StatelessWidget {
  WalletPage({Key? key}) : super(key: key);
  final WalletController _walletController = WalletController();
  final f = DateFormat('yyyy-MM-dd');
  final f2 = DateFormat('dd.MM.yyyy');
  final TextEditingController promosyonKoduController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              ListTile(
                title: const Text(
                  "Cüzdanım",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<String>(
                  future: _walletController.getUserBalance(),
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data ?? "",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    );
                  }),
              const Text(
                "Bakiye",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // background
                  foregroundColor: Colors.white, // foreground
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/tcCheck");
                },
                child: const Text(
                  '  Bakiye Yükle ',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // background
                  foregroundColor: Colors.white, // foreground
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/promosyonKodu");
                },
                child: const Text(
                  'Promosyon Kodu Kullan',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.60,
                child: FutureBuilder<PaymentHistoryModel>(
                    future: _walletController.getPaymentLogs(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Center(
                          child: Text("Satın alma geçmişi yükleniyor.."),
                        );
                      } else if (snapshot.data!.paymentHistory!.isEmpty) {
                        return const Center(
                          child:
                              Text("Satın alma geçmişiniz bulunmamaktadır..."),
                        );
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.paymentHistory!.length,
                        itemBuilder: (context, index) {
                          PaymentHistory item =
                              snapshot.data!.paymentHistory![index];
                          return ListTile(
                            title: Text(
                              "${item.description}",
                              style: const TextStyle(fontSize: 12),
                            ),
                            subtitle: Text(
                              f2.format(f.parse(item.date!.split("T")[0])),
                              style: const TextStyle(fontSize: 10),
                            ),
                            trailing: Text(
                              "${item.arti == 1 ? '+' : '-'} ${item.cash} TL",
                              style: TextStyle(
                                  color: item.arti == 1
                                      ? Colors.green
                                      : Colors.redAccent),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            thickness: 1,
                          );
                        },
                      );
                    }),
              )
            ],
          ),
        );
      }),
    ));
  }
}
