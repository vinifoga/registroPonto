import 'package:flutter/material.dart';
import 'package:registroponto/constants.dart';

class CardAlertInputOption extends StatelessWidget {
  final String title;
  const CardAlertInputOption({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        child: ListTile(
          title: Text(title),
          subtitle: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(),
          ),
          tileColor: kPrimaryLightColor,
        ),
      ),
    );
  }
}
