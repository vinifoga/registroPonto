import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registroponto/components/background.dart';
import 'package:registroponto/components/input_text.dart';
import 'package:registroponto/components/rounded_button.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'forget_password_check.dart';
import 'login_screen.dart';

class PasswordRecoveryScreenFail extends StatelessWidget {
  const PasswordRecoveryScreenFail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Background(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: size.height * 0.15),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: Text(
                        "NOVA SENHA",
                        style: GoogleFonts.robotoCondensed(
                            fontSize: 50, color: titleColor),
                      ),
                    ),
                  ),
                  Image(
                    image: AssetImage("assets/images/password_recovery.png"),
                    height: size.height * 0.3,
                  ),
                  Text('Ocorreu um erro ao tentar recuperar sua senha, consulte o RH !',style: GoogleFonts.robotoCondensed(
                      fontSize: 20, color: titleColor,), textAlign: TextAlign.center,),
                  RoundedButton(
                      text: "VOLTAR", press: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );

                  }, textColor: Colors.white),
                ],
              ),
            ),
          ),
        ),
      );
  }
}
