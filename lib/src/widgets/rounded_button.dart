import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

import '../config/snackbar.dart';
import '../utils/colours.dart';
import '../utils/styles.dart';
import 'text_style.dart';

class RoundedButton extends StatefulWidget {
  final String text;
  final Color? textColor;

  final bool loading;
  final bool isborder;

  final double? width;
  final double? height;
  final double? fontsize;
  final double? borderRadius;

  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  const RoundedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.icon,
    this.iconColor,
    this.loading = false,
    this.isborder = false,
    this.fontsize,
    this.textColor,
    this.borderRadius = 30.0,
    this.backgroundColor = kPrimaryDarkShade,
  });

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  Future<void> _handlePress() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      if (mounted) {
        SnackWidget.showSnackbar(
          context,
          "No internet connection",
        );
      }
    } else {
      widget.onPressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: widget.width,
      height: widget.height ?? size.height * 0.07,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          shape: widget.isborder
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 0,
                  ),
                  side: const BorderSide(
                    color:
                        kPrimaryDarkShade, // Set the desired border color here
                    width: 2.0, // Set the desired border width
                  ),
                )
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? 0,
                  ),
                ),
        ),
        onPressed: widget.loading ? null : _handlePress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null)
              Icon(
                widget.icon,
                color: widget.iconColor ?? widget.textColor,
              ),
            if (widget.icon != null)
              SizedBox(
                width: size.width * 0.02,
              ), // Add some space between the icon and text
            BuildText(
              text: widget.text,
              color: widget.textColor ?? Colors.white,
              fontSize: widget.fontsize ?? FontSizes.regularTextSize(context),
              fontWeight: FontWeight.bold,
              textStyle: StyleText.baseTextStyle_3,
            ),
          ],
        ),
      ),
    );
  }
}
