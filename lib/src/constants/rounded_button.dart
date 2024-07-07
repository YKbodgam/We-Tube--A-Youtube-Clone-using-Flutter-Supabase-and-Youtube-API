// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colours.dart';

class RoundedButton extends StatefulWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  final bool loading;
  final double borderRadius;
  final EdgeInsets margin;
  final bool isborder;
  final double fontsize;

  const RoundedButton({
    super.key,
    required this.text,
    required this.press,
    this.color = kPrimaryDarkShade,
    this.textColor = Colors.white,
    this.loading = false,
    this.borderRadius = 30.0,
    this.margin = const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    this.isborder = false,
    this.fontsize = 16,
  });

  @override
  _RoundedButtonState createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  // The state of the button

  Future<void> _handlePress() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No internet connection"),
          ),
        );
      }
    } else {
      widget.press();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: widget.margin,
      child: ElevatedButton(
        onPressed: widget.loading ? null : _handlePress,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,
          shape: widget.isborder
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius,
                  ),
                  side: const BorderSide(
                    color:
                        kPrimaryDarkShade, // Set the desired border color here
                    width: 2.0, // Set the desired border width
                  ),
                )
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius,
                  ),
                ),
        ),
        child: Center(
          child: widget.loading
              ? const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                )
              : Text(
                  widget.text,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      color: widget.textColor,
                      fontSize: widget.fontsize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
