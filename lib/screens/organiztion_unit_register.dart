import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/components/input_text.dart';
import 'package:registroponto/components/personalized_duration_picker.dart';
import 'package:registroponto/components/rounded_button.dart';
import 'package:intl/intl.dart';
import 'package:registroponto/components/select_type_reclaim_punch.dart';

class OrganizationUnitRegister extends StatefulWidget {
  OrganizationUnitRegister({Key? key}) : super(key: key);

  @override
  State<OrganizationUnitRegister> createState() => _OrganizationUnitRegisterState();
}

class _OrganizationUnitRegisterState extends State<OrganizationUnitRegister> {
  bool status = false;
  final dateFormat = DateFormat("dd-MM-yyyy");
  final hourFormat = DateFormat("HH:mm");
  List<String> teste = ['123', '456', '897'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarRp(showBackArrow: true, showImage: false, appBarTitle: 'Unidade',),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              const InputText(labelText: 'Descrição', hintText: 'Digite um descrição', keyboardType: TextInputType.text,),
              const InputText(labelText: 'CNPJ', hintText: 'Digite o CNPJ', keyboardType: TextInputType.number,),
              Padding(
                padding: const EdgeInsets.fromLTRB (16.0, 0.0, 16.0, 0.0),
                child: DateTimeField(
                  format: dateFormat,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Data de Abertura',
                    hintText: 'Digite a data de Abertura da Empresa'
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
                padding: const EdgeInsets.all(32.0),
                child: FlutterSwitch(
                  width: 125.0,
                  height: 35.0,
                  valueFontSize: 17.0,
                  toggleSize: 25.0,
                  value: status,
                  borderRadius: 15.0,
                  padding: 8.0,
                  showOnOff: true,
                  activeColor: Colors.greenAccent,
                  activeText: 'Ativa',
                  inactiveColor: Colors.redAccent,
                  inactiveText: 'Inativa',
                  onToggle: (val) {
                    setState(() {
                      status = val;
                    });
                  },
                ),
              ),
              const InputText(hintText: '(11) 99999-9999', labelText: 'Telefone', keyboardType: TextInputType.phone,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SelectType(list: teste),
              ),
              const InputText(hintText: 'Digite o nome da Rua', labelText: 'Rua', keyboardType: TextInputType.text,),
              const InputText(hintText: 'Digite o número', labelText: 'Número', keyboardType: TextInputType.number,),
              const InputText(hintText: 'Digite o bairro', labelText: 'Bairro', keyboardType: TextInputType.text,),
              const InputText(hintText: 'Digite a cidade', labelText: 'Cidade', keyboardType: TextInputType.text,),
              const InputText(hintText: 'Digite o estado', labelText: 'Estado', keyboardType: TextInputType.text,),
              Padding(
                padding: const EdgeInsets.fromLTRB (16.0, 0.0, 16.0, 0.0),
                child: DateTimeField(
                  format: hourFormat,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Hora Abertura',
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
              Padding(
                padding: const EdgeInsets.fromLTRB (16.0, 15.0, 16.0, 0.0),
                child: DateTimeField(
                  format: hourFormat,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Hora Fechamento',
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
              RoundedButton(
                  text: "SALVAR",
                  press: () {

                  },
                  textColor: Colors.white),

            ],
          ),
        ),
      ),
    );
  }
}
test(BuildContext context) {
  Picker(
    adapter: NumberPickerAdapter(data: <NumberPickerColumn>[
      const NumberPickerColumn(begin: 0, end: 999, suffix: Text(' hours')),
      const NumberPickerColumn(begin: 0, end: 60, suffix: Text(' minutes'), jump: 15),
    ]),
    delimiter: <PickerDelimiter>[
      PickerDelimiter(
        child: Container(
          width: 30.0,
          alignment: Alignment.center,
          child: Icon(Icons.more_vert),
        ),
      )
    ],
    hideHeader: true,
    confirmText: 'OK',
    confirmTextStyle: TextStyle(inherit: false, color: Colors.red, fontSize: 22),
    title: const Text('Select duration'),
    selectedTextStyle: TextStyle(color: Colors.blue),
    onConfirm: (Picker picker, List<int> value) {
      // You get your duration here
      Duration _duration = Duration(hours: picker.getSelectedValues()[0], minutes: picker.getSelectedValues()[1]);
    },
  ).showDialog(context);
}