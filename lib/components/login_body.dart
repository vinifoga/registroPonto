import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registroponto/components/rounded_button.dart';

import '../constants.dart';
import 'background.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final formKey = GlobalKey<FormState>();
  late String _email = '';
  late String _password = '';

  bool validateAndSave() {
    final form = formKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if(validateAndSave()){
      try{

      } catch (e){
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: size.height * 0.04, vertical: size.height * 0.15),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "LOGIN",
                    style: GoogleFonts.robotoCondensed(
                        fontSize: 50, color: titleColor),
                  ),
                ),
                Image(
                  image: AssetImage("assets/images/login.png"),
                  height: size.height * 0.3,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Seu Email'),
                  validator: (value) =>
                  value!.isEmpty ? 'Email não pode ser vazio' : null,
                  onSaved: (value) => _email = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  validator: (value) =>
                  value!.isEmpty ? 'Senha não pode ser vazio' : null,
                  onSaved: (value) => _password = value!,
                ),
                // RoundedInputField(
                //   hintText: "Seu Email",
                //   onChanged: (value) {},
                //   icon: Icons.person,
                // ),
                // RoundedPasswordField(onChanged: (value) {}),
                RoundedButton(
                    text: "LOGIN",
                    press: () {
                      validateAndSubmit();
                    },
                    textColor: Colors.white),
                // ForgetPassword(
                //   text: "Esqueceu sua senha?",
                //   press: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) {
                //           return PasswordRecoveryScreen();
                //         },
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
          )),
    );
  }
}
