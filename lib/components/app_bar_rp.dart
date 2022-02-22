import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class AppBarRp extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  final bool showImage;
  final bool showBackArrow;

  const AppBarRp(
      {Key? key,
      required this.appBarTitle,
      required this.showImage, required this.showBackArrow,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: 88,
      backgroundColor: kPrimaryLightColor,
      automaticallyImplyLeading: showBackArrow,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: showImage,
            child: Image.asset(
              "images/logo-app-bar.png",
              fit: BoxFit.contain,
              height: 52,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              appBarTitle,
              style: GoogleFonts.robotoCondensed(
                color: Colors.black,
                fontSize: 24.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
