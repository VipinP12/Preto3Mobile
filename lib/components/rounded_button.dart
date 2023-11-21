import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  // final EdgeInsets padding;
  final TextStyle style;
  final Function() onClick;
  final String text;
  const RoundedButton({Key? key, required this.height, required this.width, required this.color, /*required this.padding,*/ required this.onClick, required this.text, required this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Text(text,style: style)),
      ),
    );
  }
}
