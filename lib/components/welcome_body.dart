import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registroponto/components/rounded_button.dart';
import 'package:registroponto/constants.dart';
import 'package:registroponto/screens/login_screen.dart';

import 'background.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: size.height * 0.04, vertical: size.height * 0.15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              heightFactor: 2,
              child: Text(
                "BEM VINDO",
                style: GoogleFonts.robotoCondensed(
                    fontSize: 50, color: titleColor),
              ),
            ),
            Image(
              image: AssetImage("assets/images/landing_page.png"),
              height: size.height * 0.37,
            ),
            RoundedButton(
                text: "LOGIN",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                }, textColor: Colors.white,)
          ],
        ),
      ),
    );
  }
}
