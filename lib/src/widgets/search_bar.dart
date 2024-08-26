import 'package:flutter/material.dart';

class SearchBarOne extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;

  const SearchBarOne({
    super.key,
    required this.controller,
    this.icon = Icons.search,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.grey,
    this.borderRadius = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 15),
              ),
            ),
          ),
          const Icon(
            Icons.search,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
