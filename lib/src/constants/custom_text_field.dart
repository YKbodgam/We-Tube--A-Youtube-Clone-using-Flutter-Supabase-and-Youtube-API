import 'package:flutter/material.dart';

import '../utils/styles.dart';

class CustomTextField extends StatefulWidget {
  final Color? backgroundColor;
  final double? borderRadius;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String hintText;
  final Color? focusedBorderColor;
  final double? height;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    this.height,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    this.backgroundColor,
    this.focusedBorderColor,
    this.controller,
    this.focusNode,
    this.validator,
    this.onChanged,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: Container(
        height: widget.height,
        margin: EdgeInsets.symmetric(
          vertical: size.height * 0.01,
        ),
        child: TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            filled: widget.backgroundColor != null,
            fillColor: widget.backgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
              borderSide: BorderSide(
                color: widget.focusedBorderColor ?? Colors.grey,
              ),
            ),
            prefixIcon:
                widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
            suffixIcon:
                widget.suffixIcon != null ? Icon(widget.suffixIcon) : null,
            labelText: _isFocused ? widget.hintText : null,
            hintText: !_isFocused ? widget.hintText : null,
            hintStyle: StyleText.baseTextStyle_1.copyWith(
              fontSize: FontSizes.mediumSmallTextSize(context),
              fontWeight: FontWeight.bold,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: size.width * 0.04,
              vertical: size.height * 0.02,
            ),
          ),
          validator: widget.validator,
        ),
      ),
    );
  }
}
