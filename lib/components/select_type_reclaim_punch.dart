import 'package:flutter/material.dart';
import 'package:registroponto/constants.dart';

class SelectType extends StatefulWidget {
  final List<String> list;
  const SelectType({Key? key, required this.list}) : super(key: key);

  @override
  State<SelectType> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<SelectType> {
  late List<String> list = widget.list;
  late String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                  ),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
