import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'custom_button.dart';

class CheckBoxHizmetButton extends StatefulWidget {
  final String text1;
  final String text2;
  final String url;
  final VoidCallback callback;

  const CheckBoxHizmetButton(
      {required Key key,
      required this.text1,
      required this.text2,
      required this.callback,
      required this.url})
      : super(key: key);

  @override
  State<CheckBoxHizmetButton> createState() => _CheckBoxButtonState();
}

class _CheckBoxButtonState extends State<CheckBoxHizmetButton> {
  bool check = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          checkColor: Colors.white,
          activeColor: Theme.of(context).primaryColor,
          value: check,
          onChanged: (value) {
            widget.callback();
            setState(() {
              check = value!;
            });
          },
        ),
        Text.rich(
          TextSpan(
            style: const TextStyle(
              fontSize: 15,
            ),
            children: <TextSpan>[
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _showDialog();
                  },
                style: const TextStyle(
                  decoration: TextDecoration.underline,
                ),
                text: widget.text1,
              ),
              TextSpan(
                  text: ' ${widget.text2}',
                  style: const TextStyle(fontSize: 15)),
              // can add more TextSpans here...
            ],
          ),
        ),
      ],
    );
  }

  _showDialog() {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width - 20,
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 18, bottom: 12),
                height: MediaQuery.of(context).size.height - 50,
                child: FullScreenDialog(
                  url: widget.url,
                  callback: () {
                    widget.callback();
                    setState(() {
                      check = true;
                    });
                  },
                  title: 'Hizmet Sözleşmesi',
                  key: UniqueKey(),
                )),
          );
        });
  }
}

class FullScreenDialog extends StatefulWidget {
  final VoidCallback callback;
  final String url;
  final String title;

  const FullScreenDialog(
      {required Key key,
      required this.callback,
      required this.title,
      required this.url})
      : super(key: key);

  @override
  State<FullScreenDialog> createState() => _FullScreenDialogState();
}

class _FullScreenDialogState extends State<FullScreenDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomButton(
        height: 75,
        text: "KABUL EDİYORUM",
        text2: "KABUL EDİYORUM",
        textChange: false,
        assetName: "assets/images/giris_button.png",
        onClick: () {
          widget.callback();
          Navigator.pop(context);
        },
        key: UniqueKey(),
      ),
      body: SafeArea(
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
        ),
      ),
    );
  }
}
