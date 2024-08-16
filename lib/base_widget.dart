import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class BaseWidget extends StatelessWidget {
  Widget child;

  BaseWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: Image.asset("assets/images/beyaz_zemin.png").image,
                fit: BoxFit.fill)),
        child: child,
      ),
    );
  }
}
