import 'package:flutter/material.dart';

import 'text_style.dart';
import '../utils/styles.dart';
import '../utils/colours.dart';

class SelectableChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const SelectableChip({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Chip(
        label: BuildText(
          text: label,
          color: isSelected ? Colors.white : kPrimaryDarkShade,
          fontSize: FontSizes.smallTextSize(context),
          fontWeight: FontWeight.bold,
          textStyle: StyleText.baseTextStyle_1,
        ),
        backgroundColor: isSelected ? kPrimaryLightShade : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(
            color: isSelected ? Colors.white : kPrimaryDarkShade,
          ),
        ),
      ),
    );
  }
}
