
import 'package:flutter/material.dart';
import 'package:registroponto/constants.dart';

class SelectType extends StatefulWidget {
  const SelectType({Key? key}) : super(key: key);

  @override
  State<SelectType> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<SelectType> {
  String dropdownValue = 'Entrada';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.keyboard_arrow_down,),
        elevation: 16,
        style: const TextStyle(color: Colors.black),
        underline: Container(
          height: 2,
          color: kPrimaryColor,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['Entrada', 'Saida', 'Saida Intervalo', 'Retorno Intervalo', 'Outro']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
