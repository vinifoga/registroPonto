import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/constants.dart';
import 'package:registroponto/models/punch_clocking.dart';
import 'package:registroponto/screens/reclaim_punch.dart';

class PunchClockingScreen extends StatefulWidget {
  final List<PunchClocking> punchs;
  PunchClockingScreen({Key? key, required this.punchs}) : super(key: key);


  @override
  State<PunchClockingScreen> createState() => _PunchClockingScreenState();
}

class _PunchClockingScreenState extends State<PunchClockingScreen> {
  late List<bool> isSelected;
  late int _index = 0;
  bool _isLoading = true;
  bool _showError = false;


  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarRp(appBarTitle: 'Últimas Marcações', showImage: true, showBackArrow: true,),
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
      floatingActionButton: Visibility(
        visible: _index == 0 ? false : true,
        child: FloatingActionButton(
          onPressed: () => {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ReclaimPunch(),
              ),
            ),
          },
          child: const Icon(Icons.add),
          backgroundColor: floatActionButtonColor,
        ),
      ),
    );
  }

  Column selectedItem(int index) {
    if (index == 0) {
      return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: widget.punchs.length,
                itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.hourglass_bottom),
                      title: Text(widget.punchs[index].status),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Data: ${widget.punchs[index].data}'),
                          Text('Hora: ${widget.punchs[index].hora}'),
                        ],
                      ),
                    ),
                  );
                },
                // Card(
                //   child: ListTile(
                //     title: Text(punchs[punchs.length].colaboradorNome),
                //     subtitle: Text(punchs[punchs.length].data.toString().substring(8, 10) + '/'
                //         + punchs[punchs.length].data.toString().substring(5, 7) + '/'
                //         + punchs[punchs.length].data.toString().substring(0, 4) + '    '
                //         + punchs[punchs.length].hora.toString()),
                //     trailing: const Icon(
                //       Icons.call_received,
                //       color: Colors.green,
                //     ),
                //     tileColor: kPrimaryLightColor,
                //   ),
                // ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(50),
              margin: const EdgeInsets.all(50),
              child: Center(
                child: _isLoading
                    ? const Text('')
                    : const CircularProgressIndicator(),
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
