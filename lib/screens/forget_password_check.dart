import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';

class ForgetPassword extends StatelessWidget {
  final String text;
  final Function() press;
  const ForgetPassword({
    Key? key,
    required this.press,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: press,
          child: Text(text,
              style:
              GoogleFonts.robotoCondensed(fontSize: 20, color: titleColor)),
        ),
      ],
    );
  }
}
