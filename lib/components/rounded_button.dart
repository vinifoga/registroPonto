import 'package:flutter/material.dart';
import 'package:registroponto/constants.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function() press;
  final Color textColor;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.textColor,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: <Color>[kPrimaryColor, kSecondaryColor],
                )),
              ),
            ),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 12.0),
                  primary: textColor,
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: press,
                child: Text(text),
              ),
            )
          ],
        ),
      ),
    );
  }
}
