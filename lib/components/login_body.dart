import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registroponto/components/input_text.dart';
import 'package:registroponto/components/rounded_button.dart';
import 'package:http/http.dart' as http;
import 'package:registroponto/models/punch_clocking.dart';
import 'package:registroponto/models/roles.dart';
import 'package:registroponto/models/sort_pageable_punch_clocking.dart';
import 'package:registroponto/models/user.dart';
import 'package:registroponto/screens/dashboard.dart';
import 'package:registroponto/screens/dashboard_hr_analist.dart';
import 'package:registroponto/screens/forget_password_check.dart';
import 'package:registroponto/screens/password_recovery_screen.dart';

import '../constants.dart';
import 'background.dart';

Uri url = Uri.parse("https://registro-ponto-api-v2.herokuapp.com/auth");
Uri urlUser = Uri.parse("https://registro-ponto-api-v2.herokuapp.com/usuarios");
Uri urlRegistros = Uri.parse("https://registro-ponto-api-v2.herokuapp.com/registros");


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
  bool _showError = false;
  bool obscurePassword = true;
  Color colorShowPassword = Colors.grey;
  late List<PunchClocking> punchs = [];

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void showPassword(){
    setState(() {
      colorShowPassword==Colors.grey ? colorShowPassword=kPrimaryColor : colorShowPassword=Colors.grey;
      obscurePassword ? obscurePassword=false : obscurePassword=true;
    });
  }

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
      setState(() {
        _isLoading = true;
        _showError = false;
      });
      try {
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

        var responseUser = await http.get(urlUserByEmail, headers: {
          'Content-type': 'application/json',
          'Authorization': tokenEnvia
        });

        Map<String, dynamic> userMap = jsonDecode(responseUser.body.toString());
        User user = User.fromJson(userMap);
        String perfil = '';
        for (Roles role in user.roles) {
          if (role.nomeRole == 'ROLE_RESPONSAVEL_RH') {
            perfil = 'responsavelRh';
          } else if (role.nomeRole == 'ROLE_COLABORADOR') {
            perfil = 'colaborador';
          } else if (role.nomeRole == 'ROLE_ADMIN'){
            perfil = 'admin';
          }
        }
        setState(() {
          _isLoading = false;
        });
        if (perfil == '') {
        } else if (perfil == 'responsavelRh') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DashboardHRAnalist(tokenEnvia: tokenEnvia,user: user,)));
        } else if (perfil == 'colaborador') {
          late List<PunchClocking> punchs = [];
          punchs = await findPunchClocking(tokenEnvia, user);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Dashboard(tokenEnvia: tokenEnvia, user: user, punchs: punchs)));
        }
      } catch (e) {
        print(e);
        setState(() {
          _isLoading = false;
          _showError = true;
        });
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
                  decoration: InputDecoration(
                      labelText: 'Seu Email',
                  border:  const OutlineInputBorder(),),
                  validator: (value) =>
                      value!.isEmpty ? 'Email não pode ser vazio' : null,
                  onSaved: (value) => _email = value!,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Senha',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: () {
                        showPassword();
                      },
                      icon: Icon(Icons.remove_red_eye), color: colorShowPassword,), ),
                  obscureText: obscurePassword,
                  validator: (value) =>
                      value!.isEmpty ? 'Senha não pode ser vazio' : null,
                  onSaved: (value) => _password = value!,
                ),
                Visibility(
                  visible: _showError,
                  child: Container(
                    margin: EdgeInsets.only(top:6),
                    child: const Center(
                      child: Text('Usuario ou Senha Inválidos'),
                    ),
                  ),
                ),
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
                ForgetPassword(
                  text: "Esqueceu sua senha?",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PasswordRecoveryScreen();
                        },
                      ),
                    );
                  },
                ),

                Container(
                  padding: const EdgeInsets.all(50),
                  margin: const EdgeInsets.all(50),
                  child: Center(
                    child: !_isLoading
                        ? const Text('')
                        : const CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Future<List<PunchClocking>> findPunchClocking(String tokenEnvia, User user) async {
    DateTime data = DateTime.now();
    Uri urlRegistroColaborador = Uri.parse(urlRegistros.toString()+'/${user.colaboradorId}/'+formatDate(data, [yyyy,'-',mm,'-',dd]));
    try {
      var responsePunch = await http.get(urlRegistroColaborador, headers: {
        'Content-type': 'application/json',
        'Authorization': tokenEnvia
      });
      if (responsePunch.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(responsePunch.body.toString());
        SortPageablePunchClocking sortPageablePunchClocking =
        SortPageablePunchClocking.fromJson(map);
        punchs = sortPageablePunchClocking.content;
      } else {
        throw Exception('Falha ao buscar Registros');
      }
    } catch (e) {
      ('Falha ao buscar Registros');
    }
    return punchs;
  }
}
