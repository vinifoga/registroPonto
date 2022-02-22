import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/components/select_type_reclaim_punch.dart';

class ReclaimPunch extends StatelessWidget {
  final dateFormat = DateFormat("dd-MM-yyyy");
  final hourFormat = DateFormat("HH:mm");

  ReclaimPunch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarRp(
        appBarTitle: 'Corrigir',
        showImage: true,
        showBackArrow: true,
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Colaborador'),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
              ),
              const Text('Data'),
              DateTimeField(
                format: dateFormat,
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      fieldLabelText: 'Data',
                      locale: const Locale('pt'),
                      firstDate: DateTime(2022),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
              ),
              const Text('Hora'),
              DateTimeField(
                format: hourFormat,
                onShowPicker: (context, currentValue) async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(
                        currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.convert(time);
                },
              ),
              const Text('Tipo'),
              const SelectType(),
              const Text('Descrição'),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    print('Salvar');
                  },
                  child: const Text('Salvar'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
