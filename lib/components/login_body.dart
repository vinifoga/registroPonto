import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registroponto/components/rounded_button.dart';
import 'package:http/http.dart' as http;
import 'package:registroponto/models/roles.dart';
import 'package:registroponto/models/user.dart';
import 'package:registroponto/screens/dashboard.dart';
import 'package:registroponto/screens/dashboard_hr_analist.dart';

import '../constants.dart';
import 'background.dart';

Uri url = Uri.parse("https://registro-ponto-api.herokuapp.com/auth");
Uri urlUser = Uri.parse("https://registro-ponto-api.herokuapp.com/usuarios");

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final formKey = GlobalKey<FormState>();
  late String _email = '';
  late String _password = '';
  bool _isLoading = false;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      print(_email);
      print(_password);
      setState(() {
        _isLoading = true;
      });
      var response = await http.post(
        url,
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({'email': _email, 'senha': _password}),
      );
      print(response.body);
      var responseDecode = jsonDecode(response.body);
      var token = responseDecode['token'];
      var tipo = responseDecode['tipo'];
      String tokenEnvia = tipo + ' ' + token;

      Uri urlUserByEmail = Uri.parse(urlUser.toString() + "/email/" + _email);

      var responseUser = await http.get(
          urlUserByEmail,
          headers: {
            'Content-type': 'application/json',
            'Authorization': tokenEnvia
          }
      );

      Map<String, dynamic> userMap = jsonDecode(responseUser.body.toString());
      User user = User.fromJson(userMap);
      String perfil = '';
      for(Roles role in user.roles){
        if(role.nomeRole == 'ROLE_RESPONSAVEL_RH'){
          perfil = 'responsavelRh';
        } else if(role.nomeRole == 'ROLE_COLABORADOR') {
          perfil = 'colaborador';
        }
      }
      setState(() {
        _isLoading=false;
      });
      if(perfil == ''){

      } else if(perfil == 'responsavelRh'){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DashboardHRAnalist(tokenEnvia)));
      } else if(perfil == 'colaborador'){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dashboard(tokenEnvia)));
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
                      const AlertDialog(
                        content: CircularProgressIndicator(
                          strokeWidth: 5,
                        ),
                      );
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
                Container(
                  padding: const EdgeInsets.all(50),
                  margin: const EdgeInsets.all(50),
                  child: Center(
                    child: !_isLoading ? const Text ('') : const CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
