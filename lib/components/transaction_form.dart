import 'package:expenses/components/adaptative_textfield.dart';
import 'package:flutter/material.dart';
import 'adaptative_date_picker.dart';
import 'adaptative_button.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: 10,
          ),
          child: Column(
            children: <Widget>[
              AdaptativeTextField(
                controller: _titleController,
                submit: (_) => _submitForm(),
                label: 'Título',
                typeInput: TextInputType.text,
              ),
              AdaptativeTextField(
                controller: _valueController,
                submit: (_) => _submitForm(),
                label: 'Valor R\$',
                typeInput: TextInputType.numberWithOptions(decimal: true),
              ),
              AdaptativeDatePicker(
                dataSelecionada: _selectedDate,
                onDateChanged: (newDate) => {
                  setState(() {
                    _selectedDate = newDate;
                  }),
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AdaptativeButton(
                    label: 'Adicionar Transação',
                    onPressed: _submitForm,
                  ),
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
