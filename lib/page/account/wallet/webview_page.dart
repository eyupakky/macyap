import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:halisaha/help/utils.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({Key? key}) : super(key: key);

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late InAppWebViewController _webViewController;
  late String? arguments;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    arguments = ModalRoute.of(context)!.settings.arguments as String;
    // arguments["info"].videoId;
    return Scaffold(
      resizeToAvoidBottomInset:true,
      body: Container(
        padding: const EdgeInsets.all(35),
        color: Colors.white,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(arguments!)),
          initialOptions: InAppWebViewGroupOptions(
              android: AndroidInAppWebViewOptions(
                useHybridComposition: true,
              ),
              crossPlatform: InAppWebViewOptions()),
          onWebViewCreated: (InAppWebViewController controller) {
            _webViewController = controller;

            _webViewController.addJavaScriptHandler(
                handlerName: 'handlerFoo', callback: (args) {});

            _webViewController.addJavaScriptHandler(
                handlerName: 'paymentResultCallback',
                callback: (args) {
                  Future.delayed(const Duration(milliseconds: 4000), () {
                    if (!args[0]) {
                      showToast(args[1], color: Colors.redAccent);
                      Navigator.pop(context);
                    } else if (args[0]) {
                      showToast("Ödeme başarılı", color: Colors.green);
                      selectItem();
                    }
                  });

                });
          },
          onConsoleMessage: (controller, consoleMessage) {
            print(consoleMessage);
          },
          onLoadStop: (a, uri) {
            // if (uri.toString().contains("Param/Successfull")) {
            //   selectItem();
            //   showToast("İşlem başarılı.");
            // }else if (uri.toString().contains("Param/Unsuccessfull")) {
            //   showToast("İşlem başarısız.");
            //   selectItem();
            // }
            print(uri);
          },
        ),
      ),
    );
  }

  selectItem() {
    Navigator.pushReplacementNamed(context, "/wallet");
  }
}
