import 'package:flutter/material.dart';

class RegisterButton extends StatefulWidget {
  final String? text;
  final String? text2;
  final bool? textChange;
  final String? assetName;
  final double? width;
  final double? height;
  final double? fontSize;
  final VoidCallback? onClick;

  const RegisterButton(
      {required Key key,
      this.fontSize = 14,
      this.text,
      this.text2,
      this.textChange,
      this.assetName,
      this.onClick,
      this.width = 250,
      this.height = 60})
      : super(key: key);

  @override
  State<RegisterButton> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton>
    with SingleTickerProviderStateMixin {
  bool createdProfile = false;
  late double _scale;
  late AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 10,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        //setState(() {});
      });
    super.initState();
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTap: () {
        _controller.reverse();
        if (widget.onClick != null) {
          widget.onClick!();
        }
        setState(() {
          createdProfile = true;
        });
        //Navigator.pushReplacementNamed(context, "/home")
      },
      child: Transform.scale(
        scale: _scale,
        child: Container(
          margin: const EdgeInsets.all(5),
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 20,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.text!,
              softWrap: true,
              maxLines: 1,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
