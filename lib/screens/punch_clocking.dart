import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/constants.dart';

class PunchClocking extends StatefulWidget {
  PunchClocking({Key? key}) : super(key: key);

  @override
  State<PunchClocking> createState() => _PunchClockingState();
}

class _PunchClockingState extends State<PunchClocking> {
  late List<bool> isSelected;
  late int _index = 0;

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarRp(appBarTitle: 'Últimas Marcações', showImage: true),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ToggleButtons(
                  color: kButtonColorDisable,
                  selectedColor: kButtonColorEnable,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Registros',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Correções',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = i == index;
                      }
                      _index = index;
                    });
                  },
                  isSelected: isSelected,
                ),
              ),
            ],
          ),
          selectedItem(_index),

        ],
      ),
    );
  }

  Column selectedItem(int index) {
    if (index == 0) {
      return Column(
        children: [
          const Card(
            child: ListTile(
              title: Text('Entrada'),
              subtitle: Text('02/09/2021 - 8:00'),
              trailing: Icon(
                Icons.call_received,
                color: Colors.green,
              ),
              tileColor: kPrimaryLightColor,
            ),
          ),
          const Card(
            child: ListTile(
              title: Text('Saída'),
              subtitle: Text('02/09/2021 - 8:00'),
              trailing: Icon(
                Icons.call_made,
                color: Colors.red,
              ),
              tileColor: kPrimaryLightColor,
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          const Card(
            child: ListTile(
              title: Text('Entrada'),
              subtitle: Text('02/09/2021 - 8:00'),
              trailing: Icon(
                Icons.check,
                color: Colors.green,
              ),
              tileColor: kPrimaryLightColor,
            ),
          ),
          const Card(
            child: ListTile(
              title: Text('Saída'),
              subtitle: Text('02/09/2021 - 8:00'),
              trailing: Icon(
                Icons.cancel_outlined,
                color: Colors.red,
              ),
              tileColor: kPrimaryLightColor,
            ),
          ),
        ],
      );
    }
  }
}
