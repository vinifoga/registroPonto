import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registroponto/components/background.dart';
import 'package:registroponto/components/input_text.dart';
import 'package:registroponto/components/rounded_button.dart';
import 'package:http/http.dart' as http;
import 'package:registroponto/screens/password_recovery_screen_fail.dart';
import 'package:registroponto/screens/password_recovery_screen_success.dart';

import '../constants.dart';
import 'forget_password_check.dart';
import 'login_screen.dart';

Uri url = Uri.parse("https://registro-ponto-api.herokuapp.com/usuarios/reset-senha-padrao");
class PasswordRecoveryScreen extends StatelessWidget {
  PasswordRecoveryScreen({
    Key? key,
  }) : super(key: key);
  final mailController = TextEditingController();


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
                  InputText(hintText: 'Email',labelText: 'Email', controller: mailController,),
                  Text('Ao clicar em confirmar sua senha voltará à \'senha padrão\' !',style: GoogleFonts.robotoCondensed(
                      fontSize: 20, color: titleColor,), textAlign: TextAlign.center,),
                  RoundedButton(
                      text: "CONFIRMAR", press: () {
                    resetPassword(mailController.text, context);
                  }, textColor: Colors.white),
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
  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      Uri urlEmail = Uri.parse(url.toString()+"/"+email);
      var responsePunch = await http.put((urlEmail), headers: {
        'Content-type': 'application/json',
      });
      if (responsePunch.statusCode == 200) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PasswordRecoveryScreenSuccess(),
          ),
        );
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PasswordRecoveryScreenFail(),
          ),
        );
      }
    } catch (e) {
      ('Falha ao buscar Usuário');
    }
  }
}
