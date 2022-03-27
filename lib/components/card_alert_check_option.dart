import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:registroponto/constants.dart';

class CardAlertCheckOption extends StatefulWidget {
  final String title;
  final String text;
  bool? status = false;

  CardAlertCheckOption({
    Key? key,
    required this.title,
    required this.text,
    this.status,
  }) : super(key: key);

  @override
  State<CardAlertCheckOption> createState() => _CardAlertCheckOptionState();
}

class _CardAlertCheckOptionState extends State<CardAlertCheckOption> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Card(
                child: ListTile(
                  title: Text(widget.title),
                  subtitle: Text(widget.text),

                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            FlutterSwitch(
              width: 125.0,
              height: 35.0,
              valueFontSize: 17.0,
              toggleSize: 25.0,
              value: widget.status ?? false,
              borderRadius: 15.0,
              padding: 8.0,
              showOnOff: true,
              activeColor: Colors.greenAccent,
              activeIcon: const Icon(Icons.check),
              activeText: 'Sim',
              inactiveColor: Colors.redAccent,
              inactiveIcon: const Icon(Icons.not_interested),
              inactiveText: 'Não',
              onToggle: (val) {
                setState(() {
                  widget.status = val;
                });
              },
            ),
          ],
        )
      ],
    );
  }
}
