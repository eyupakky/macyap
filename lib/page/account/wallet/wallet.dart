import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repository_eyup/controller/wallet_controller.dart';

class WalletPage extends StatelessWidget {
  WalletPage({Key? key}) : super(key: key);
  final WalletController _walletController = WalletController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
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
                  primary: Colors.red, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () {},
                child: const Text(
                  'Bakiye Yükle',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const ListTile(
                      title: Text("20 tl yükleme gerçekleştirildi."),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      thickness: 1,
                    );
                  },
                ),
              )
            ],
          ),
        );
      }),
    ));
  }
}
