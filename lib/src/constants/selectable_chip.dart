import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_project_2/src/utils/colours.dart';

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
        label: Text(
          widget.label,
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            color: _isSelected ? Colors.white : kPrimaryDarkShade,
          ),
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
