import 'package:flutter/material.dart';

class BottomAppBarOption extends StatelessWidget {
  final IconData icon;
  final Function onClick;

  const BottomAppBarOption({
    Key? key,
    required this.icon,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        onPressed: () {
          onClick();
        });
  }
}
