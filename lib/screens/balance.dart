import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:registroponto/components/app_bar_rp_with_bottom.dart';
import 'package:intl/intl.dart';
import 'package:registroponto/components/input_text.dart';
import 'package:registroponto/components/rounded_button.dart';
import 'package:registroponto/components/select_type_reclaim_punch.dart';
import 'package:registroponto/models/punch_clocking.dart';
import 'package:registroponto/models/user.dart';



class Balance extends StatefulWidget {
  final String token;
  final String balance;
  final User user;
  const Balance({Key? key, required this.token, required this.balance, required this.user}) : super(key: key);

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  final haveBreak = TextEditingController();
  final dateFormat = DateFormat("yyyy-MM-dd");
  final hourFormat = DateFormat("HH:mm:ss");
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _showError = false;
  PunchClocking? _editedPunch;

  final dateController = TextEditingController();
  final hourController = TextEditingController();
  final statusController = TextEditingController();
  final descriptionController = TextEditingController();

  final moreInfo = TextEditingController();

  get balance => widget.balance;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat("dd-MM-yyyy");
    final hourFormat = DateFormat("HH:mm");
    return Scaffold(
      appBar: AppBarRpWithBottom(showBackArrow: true, showImage: false, appBarTitle: 'Utilizar Saldo', bottomText: balance.toString(),),
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
                  InputText(labelText: 'Descrição', hintText: 'Digite um descrição', keyboardType: TextInputType.text, controller: descriptionController,),
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
    }
  }
}
