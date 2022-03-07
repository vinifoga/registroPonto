import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/components/app_bar_rp_with_bottom.dart';
import 'package:intl/intl.dart';
import 'package:registroponto/components/input_text.dart';
import 'package:registroponto/components/rounded_button.dart';
import 'package:registroponto/components/select_type_reclaim_punch.dart';


class Balance extends StatelessWidget {
  Balance({Key? key}) : super(key: key);
  List<String> teste = ['123', '456', '897'];

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat("dd-MM-yyyy");
    final hourFormat = DateFormat("HH:mm");
    return Scaffold(
      appBar: AppBarRpWithBottom(showBackArrow: true, showImage: false, appBarTitle: 'Utilizar Saldo', bottomText: 'Saldo +5 horas',),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB (16.0, 16.0, 16.0, 0.0),
              child: DateTimeField(
                format: dateFormat,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Data',
                    hintText: 'Digite uma data'
                ),
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
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB (16.0, 15.0, 16.0, 0.0),
              child: DateTimeField(
                format: hourFormat,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Hora',
                    hintText: 'Digite a Hora de Entrada'
                ),
                onShowPicker: (context, currentValue) async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(
                        currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.convert(time);
                },
              ),
            ),
            InputText(hintText: 'Duração', labelText: 'Intervalo', keyboardType: TextInputType.number,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SelectType(list: teste,),
            ),
            InputText(hintText: 'Outro', labelText: 'Outro', keyboardType: TextInputType.text,),

            RoundedButton(
                text: "Solicitar",
                press: () {

                },
                textColor: Colors.white),
          ],

        ),
      ),
    );
  }
}
