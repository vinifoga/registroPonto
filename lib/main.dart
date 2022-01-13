import 'package:flutter/material.dart';
import 'package:registroponto/screens/dashboard.dart';

import 'constants.dart';

void main() {
  runApp(const RegistroPonto());
}

class RegistroPonto extends StatelessWidget {
  const RegistroPonto({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro Ponto',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const Dashboard(),
    );
  }
}