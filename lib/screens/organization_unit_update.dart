import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/Picker.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/components/input_text.dart';
import 'package:registroponto/components/rounded_button.dart';
import 'package:registroponto/components/select_type_reclaim_punch.dart';
import 'package:http/http.dart' as http;
import 'package:registroponto/models/organization_unit.dart';



Uri urlUnit =
Uri.parse("https://registro-ponto-api-v2.herokuapp.com/unidades");
class OrganizationUnitUpdate extends StatefulWidget {
  final String token;
  final OrganizationUnit unit;
  const OrganizationUnitUpdate({Key? key, required this.token, required this.unit}) : super(key: key);

  @override
  State<OrganizationUnitUpdate> createState() => _OrganizationUnitUpdateState();
}

class _OrganizationUnitUpdateState extends State<OrganizationUnitUpdate> {
  final formKey = GlobalKey<FormState>();
  bool status = false;
  final dateFormat = DateFormat("yyyy-MM-dd");
  final hourFormat = DateFormat("HH:mm:ss");
  bool _isLoading = false;
  bool _showError = false;
  OrganizationUnit? _editedUnit;

  final descriptionController = TextEditingController();
  final cnpjController = TextEditingController();
  final openingDateContoller = TextEditingController();
  final phoneNumberController = TextEditingController();
  final streetController = TextEditingController();
  final numberController = TextEditingController();
  final districtControlelr = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final openTimeController = TextEditingController();
  final closeTimeController = TextEditingController();


  @override
  void initState() {
    super.initState();
    if(widget.unit != null){
      _editedUnit = widget.unit;
      descriptionController.text = _editedUnit!.descricao ?? "";
      cnpjController.text = _editedUnit!.cnpj ?? "";
      openingDateContoller.text = _editedUnit!.abertura ?? "";
      status = _editedUnit!.ativo;
      phoneNumberController.text = _editedUnit!.telefone ?? "";
      streetController.text = _editedUnit!.rua ?? "";
      numberController.text = _editedUnit!.numero ?? "";
      districtControlelr.text = _editedUnit!.bairro ?? "";
      cityController.text = _editedUnit!.cidade ?? "";
      stateController.text = _editedUnit!.estado ?? "";
      openTimeController.text = _editedUnit!.horaFuncionaInicio ?? "";
      closeTimeController.text = _editedUnit!.horaFuncionaFim ?? "";
    }
  }

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      setState(() {
        _isLoading = true;
        _showError = false;
      });
      try {
        Uri urlUpdateEmployee = Uri.parse(urlUnit.toString()+'/'+_editedUnit!.codUnidade.toString());
        Map<String, String> header = {
          'Content-type': 'application/json',
          'Authorization': widget.token
        };

        final body = jsonEncode({
          "descricao": descriptionController.text,
          "cnpj": cnpjController.text,
          "abertura": openingDateContoller.text,
          "ativo": status,
          "telefone": phoneNumberController.text,
          "rua": streetController.text,
          "numero": numberController.text,
          "bairro": districtControlelr.text,
          "cidade": cityController.text,
          "estado": stateController.text,
          "horaFuncionaInicio": openTimeController.text,
          "horaFuncionaFim": closeTimeController.text
        });

        var responseUser = await http.put(urlUpdateEmployee,
            headers: header,
            body: body);
        if(responseUser.statusCode == 201 || responseUser.statusCode == 200){
          Navigator.pop(context);
        } else {
          print(responseUser.statusCode);
          print('Erro ao cadastrar Unidade');
        }

        setState(() {
          _isLoading = false;
        });

      } catch (e) {
        setState(() {
          _isLoading = false;
          _showError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarRp(showBackArrow: true, showImage: false, appBarTitle: 'Unidade',),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                InputText(labelText: 'Descrição', hintText: 'Digite um descrição', keyboardType: TextInputType.text, controller: descriptionController,),
                InputText(labelText: 'CNPJ', hintText: 'Digite o CNPJ', keyboardType: TextInputType.number, controller: cnpjController,),
                Padding(
                  padding: const EdgeInsets.fromLTRB (16.0, 0.0, 16.0, 0.0),
                  child: DateTimeField(
                    controller: openingDateContoller,
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
                InputText(hintText: '(11) 99999-9999', labelText: 'Telefone', keyboardType: TextInputType.phone,controller: phoneNumberController,),
                InputText(hintText: 'Digite o nome da Rua', labelText: 'Rua', keyboardType: TextInputType.text, controller: streetController,),
                InputText(hintText: 'Digite o número', labelText: 'Número', keyboardType: TextInputType.number, controller: numberController,),
                InputText(hintText: 'Digite o bairro', labelText: 'Bairro', keyboardType: TextInputType.text, controller: districtControlelr,),
                InputText(hintText: 'Digite a cidade', labelText: 'Cidade', keyboardType: TextInputType.text, controller: cityController,),
                InputText(hintText: 'Digite o estado', labelText: 'Estado', keyboardType: TextInputType.text, controller: stateController,),
                Padding(
                  padding: const EdgeInsets.fromLTRB (16.0, 0.0, 16.0, 0.0),
                  child: DateTimeField(
                    controller: openTimeController,
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
                    controller: closeTimeController,
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
                      const AlertDialog(
                        content: CircularProgressIndicator(
                          strokeWidth: 5,
                        ),
                      );
                      validateAndSubmit();
                    },
                    textColor: Colors.white),

              ],
            ),
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
          child: const Icon(Icons.more_vert),
        ),
      )
    ],
    hideHeader: true,
    confirmText: 'OK',
    confirmTextStyle: const TextStyle(inherit: false, color: Colors.red, fontSize: 22),
    title: const Text('Select duration'),
    selectedTextStyle: const TextStyle(color: Colors.blue),
    onConfirm: (Picker picker, List<int> value) {
      // You get your duration here
      Duration _duration = Duration(hours: picker.getSelectedValues()[0], minutes: picker.getSelectedValues()[1]);
    },
  ).showDialog(context);
}