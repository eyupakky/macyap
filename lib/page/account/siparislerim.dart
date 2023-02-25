import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:halisaha/help/hex_color.dart';
import 'package:repository_eyup/controller/venues_controller.dart';
import 'package:repository_eyup/model/siparisler.dart';
import 'package:repository_eyup/model/urunler_model.dart';

class SiparislerimPage extends StatefulWidget {
  const SiparislerimPage({Key? key}) : super(key: key);

  @override
  State<SiparislerimPage> createState() => _SiparislerimPageState();
}

class _SiparislerimPageState extends State<SiparislerimPage> {
  late VenuesController _venuesController;

  @override
  void initState() {
    super.initState();
    _venuesController = VenuesController();
  }

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
          'Siparişlerim',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: FutureBuilder<SiparisList>(
          future: _venuesController.siparisler(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(child: Text("Sipariş Bulunamadı"));
            }
            EasyLoading.dismiss();
            var siparisList = snapshot.data;
            return ListView.separated(
              itemCount: siparisList!.value!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                SiparisItem value = siparisList.value![index];
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, "/venuesDetail",
                        arguments: value.id);
                  },
                  title: Text(
                    '${value.baslik}',
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  trailing: Text(
                    '${value.fiyat} TL',
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8,),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${value.adet} Adet",
                              style: const TextStyle(color: Colors.black87, fontSize: 10),
                            ),
                          ), Expanded(
                            child: Text(
                              "Beden : ${value.beden}",
                              style: const TextStyle(color: Colors.black87, fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8,),
                      Text(
                        "Tarih/Saat : ${value.date}",
                        style: const TextStyle(color: Colors.black87, fontSize: 10),
                      ),
                      const SizedBox(height: 8,),
                      Text(
                        "${value.durum}",
                        style:  TextStyle(color: HexColor.fromHex(value.color!), fontSize: 12),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  thickness: 1,
                  color: Colors.red.withAlpha(100),
                );
              },
            );
          }),
    );
  }
}
