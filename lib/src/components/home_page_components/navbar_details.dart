import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colours.dart';
import '../../widgets/profile_avatar.dart';
import '../../widgets/search_bar.dart';
import '../../constants/rounded_icon_button.dart';

class HomeNavbar extends StatefulWidget {
  const HomeNavbar({super.key});

  @override
  State<HomeNavbar> createState() => _HomeNavbarState();
}

class _HomeNavbarState extends State<HomeNavbar> {
  final TextEditingController _searchController = TextEditingController();
  late String imgPath = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.02,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/logo.png",
            height: 50,
            color: kPrimaryDarkShade,
          ),
          Text(
            "WeTube",
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              color: kPrimaryDarkShade,
            ),
          ),
          SizedBox(
            width: size.width * 0.06,
          ),
          Expanded(
            child: SearchBarOne(
              controller: _searchController,
              backgroundColor: Colors.black12,
              borderRadius: 30.0,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: RoundedIconButton(
              icon: Icons.notifications_active_outlined,
              iconSize: 30.0,
              iconColor: Colors.black,
              backgroundColor: Colors.white,
              badgeText: '5',
            ),
          ),
          ProfileAvatar(
            imgPath: imgPath,
          ),
        ],
      ),
    );
  }
}
