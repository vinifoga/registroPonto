import 'package:flutter/material.dart';
import 'package:registroponto/constants.dart';

class IconButtonText extends StatelessWidget {
  final Icon icon;
  final String text;
  final Function function;

  const IconButtonText({Key? key, required this.icon, required this.text, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: icon,
            iconSize: 25.0,
            color: kSecondaryColor,
            onPressed: () {
             function();
            },
          ),
          Text(
            text,
            style: const TextStyle(color: kSecondaryColor, fontSize: 25.0),
          ),
        ],
      ),
    );
  }
}
