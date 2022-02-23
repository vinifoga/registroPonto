import 'package:flutter/material.dart';

class PersonalizedDurationPicker extends StatefulWidget {
  const PersonalizedDurationPicker({Key? key}) : super(key: key);

  @override
  _PersonalizedDurationPickerState createState() => _PersonalizedDurationPickerState();
}

class _PersonalizedDurationPickerState extends State<PersonalizedDurationPicker> {
  Duration _duration = Duration(hours: 0, minutes: 0);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

        ],
      ),
    );
  }
}
