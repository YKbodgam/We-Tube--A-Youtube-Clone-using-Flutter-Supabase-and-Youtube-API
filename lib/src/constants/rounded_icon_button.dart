import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import '../utils/colours.dart';

class RoundedIconButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final Color backgroundColor;
  final String? badgeText;
  final bool border;
  final void Function()? onpress;

  const RoundedIconButton({
    super.key,
    required this.icon,
    this.iconSize = 24.0,
    this.iconColor = Colors.white,
    this.backgroundColor = kPrimaryLightShade,
    this.badgeText,
    this.border = false,
    this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () async {
            var connectivityResult = await Connectivity().checkConnectivity();
            if (connectivityResult == ConnectivityResult.none) {
              // No internet connection, you can display a snackbar or dialog
              // to inform the user.
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("No internet connection"),
                ),
              );
            } else {
              // Internet connection is available, call the press function.
              onpress ?? () {};
            }
          },
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 40,
              maxHeight: 40,
            ),
            decoration: border
                ? BoxDecoration(
                    color: backgroundColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  )
                : BoxDecoration(
                    color: backgroundColor,
                    shape: BoxShape.circle,
                  ),
            child: Center(
              child: Icon(
                icon,
                size: iconSize,
                color: iconColor,
              ),
            ),
          ),
        ),
        if (badgeText != null)
          Positioned(
            top: -2,
            right: -2,
            child: Container(
              decoration: const BoxDecoration(
                color: kPrimaryDarkShade,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(
                minWidth: 20,
                minHeight: 20,
              ),
              child: Center(
                child: Text(
                  badgeText!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
