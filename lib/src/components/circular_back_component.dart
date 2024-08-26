import 'package:flutter/material.dart';
import '../utils/colours.dart';

class CircularField extends StatelessWidget {
  final Widget widget;

  const CircularField({
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 35,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.6),
        borderRadius: BorderRadius.circular(45.0),
        border: Border.all(
          color: kPrimaryDarkColor,
          width: 1,
        ),
      ),
      child: widget,
    );
  }
}
