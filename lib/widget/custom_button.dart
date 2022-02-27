import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String? text;
  final String? text2;
  final bool? textChange;
  final String? assetName;
  final double? width;
  final double? height;
  final double? fontSize;
  final VoidCallback? onClick;

  const CustomButton(
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
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
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
        widget.onClick!();
        setState(() {
          createdProfile = true;
        });
        //Navigator.pushReplacementNamed(context, "/")
      },
      child: Transform.scale(
        scale: _scale,
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(widget.assetName!), fit: BoxFit.fill),
          ),
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Text(
                widget.text!,
                softWrap: true,
                maxLines: 1,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
