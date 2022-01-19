import 'package:flutter/material.dart';
import 'package:registroponto/constants.dart';

class CardOptions extends StatelessWidget {
  final String text;
  final IconData icon;
  const CardOptions({Key? key, required this.text, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(text),
        trailing: Icon(icon,
          color: Colors.blue,
        ),
        tileColor: kPrimaryLightColor,
      ),
    );
  }
}
