import 'package:flutter/material.dart';

class BuildText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final TextStyle textStyle;
  final FontWeight fontWeight;

  const BuildText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.textStyle,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 2, // Allow the text to wrap to a second line if needed
      overflow: TextOverflow.ellipsis, // Add ellipsis to overflowed text

      text,
      style: textStyle.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
