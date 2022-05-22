import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:registroponto/components/app_bar_rp.dart';
import 'package:registroponto/components/input_text.dart';
import 'package:registroponto/components/rounded_button.dart';
import 'package:registroponto/components/select_type_reclaim_punch.dart';
import 'package:registroponto/models/punch_clocking.dart';
import 'package:registroponto/models/sort_pageable_punch_clocking.dart';
import 'package:registroponto/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:registroponto/screens/punch_clocking.dart';

Uri url = Uri.parse("https://registro-ponto-api-v2.herokuapp.com/registros");
class PunchUpdate extends StatefulWidget {
  final String token;
  final PunchClocking punch;
  final User user;
  const PunchUpdate({Key? key, required this.token, required this.punch, required this.user}) : super(key: key);

  @override
  State<PunchUpdate> createState() => _PunchUpdateState();
}

class _PunchUpdateState extends State<PunchUpdate> {
  final dateFormat = DateFormat("yyyy-MM-dd");
  final hourFormat = DateFormat("HH:mm:ss");
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _showError = false;
  PunchClocking? _editedPunch;

  final dateController = TextEditingController();
  final hourController = TextEditingController();
  final statusController = TextEditingController();


  @override
  void initState() {
    super.initState();
    if(widget.punch != null){
      _editedPunch = widget.punch;
      dateController.text = _editedPunch!.data ?? "";
      hourController.text = _editedPunch!.hora ?? "";
      statusController.text = _editedPunch!.status ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarRp(
        appBarTitle: 'Corrigir',
        showImage: true,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB (16.0, 0.0, 16.0, 0.0),
                    child: DateTimeField(
                      controller: dateController,
                      format: dateFormat,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Data',
                          hintText: 'Digite a data'
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
                    padding: const EdgeInsets.fromLTRB (16.0, 16.0, 16.0, 0.0),
                    child: DateTimeField(
                      controller: hourController,
                      format: hourFormat,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Hora',
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
                  InputText(labelText: 'Status', hintText: 'Digite APROVADO ou REPROVADO', keyboardType: TextInputType.text, controller: statusController,),
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
      ),
    );
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

        Map<String, String> header = {
          'Content-type': 'application/json',
          'Authorization': widget.token
        };

        final body = jsonEncode({
          "data": dateController.text,
          "hora": hourController.text,
          "status": statusController.text,
        });

        Uri urlUpdatePunch = Uri.parse(url.toString()+'/'+_editedPunch!.codRegistro.toString());
        var responseUser = await http.put(urlUpdatePunch,
            headers: header,
            body: body);
        if (responseUser.statusCode == 201 || responseUser.statusCode == 200) {
          print('Registro Alterado');
          updateList();

        } else {
          print(responseUser.statusCode);
          print('Erro ao salvar Registro');
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

  Future<void> updateList() async {
    late List<PunchClocking> punchsUpdated = [];
    Uri urlRegistroColaborador = Uri.parse(url.toString()+'?colaboradorId=${widget.user.id}'+'&data=');
    try {
      var responsePunch = await http.get(urlRegistroColaborador, headers: {
        'Content-type': 'application/json',
        'Authorization': widget.token
      });
      if (responsePunch.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(responsePunch.body.toString());
        SortPageablePunchClocking sortPageablePunchClocking =
        SortPageablePunchClocking.fromJson(map);
        punchsUpdated = sortPageablePunchClocking.content;
      } else {
        throw Exception('Falha ao buscar Registros');
      }
    } catch (e) {
      ('Falha ao buscar Registros');
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PunchClockingScreen(token: widget.token, user: widget.user, punchs: punchsUpdated,
        ),
      ),
    );

  }
}
