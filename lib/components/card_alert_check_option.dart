import 'package:flutter/material.dart';
import 'package:registroponto/constants.dart';

class CardAlertCheckOption extends StatelessWidget {
  final String title;
  final String text;

  const CardAlertCheckOption({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(text),
        trailing: Checkbox(
          onChanged: (bool? value) {},
          value: false,
        ),
        tileColor: kPrimaryLightColor,
      ),
    );
  }
}
