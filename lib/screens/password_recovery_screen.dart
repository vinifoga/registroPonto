import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registroponto/components/background.dart';
import 'package:registroponto/components/input_text.dart';
import 'package:registroponto/components/rounded_button.dart';

import '../constants.dart';
import 'forget_password_check.dart';
import 'login_screen.dart';

class PasswordRecoveryScreen extends StatelessWidget {
  const PasswordRecoveryScreen({
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
                  InputText(hintText: 'Email',labelText: 'Email',),
                  Text('Vamos enviar um email com instruções para redefinir sua senha!',style: GoogleFonts.robotoCondensed(
                      fontSize: 20, color: titleColor,), textAlign: TextAlign.center,),
                  RoundedButton(
                      text: "ENVIAR", press: () {}, textColor: Colors.white),
                  ForgetPassword(
                    text: "Lembrou a senha? Faça o Login",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}
