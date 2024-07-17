import 'package:flutter/material.dart';

import 'text_style.dart';
import '../utils/styles.dart';
import '../utils/colours.dart';

class SelectableChip extends StatefulWidget {
  final String label;
  final bool border;

  const SelectableChip({
    super.key,
    required this.label,
    this.border = true,
  });

  @override
  _SelectableChipState createState() => _SelectableChipState();
}

class _SelectableChipState extends State<SelectableChip> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
      },
      child: Chip(
        label: BuildText(
          text: widget.label,
          color: _isSelected ? Colors.white : kPrimaryDarkShade,
          fontSize: FontSizes.smallTextSize(context),
          fontWeight: FontWeight.bold,
          textStyle: StyleText.baseTextStyle_1,
        ),
        backgroundColor: _isSelected ? kPrimaryLightShade : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(
            color: _isSelected ? Colors.white : kPrimaryDarkShade,
          ),
        ),
      ),
    );
  }
}
