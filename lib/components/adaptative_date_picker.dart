import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdaptativeDate extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime)? onDataChanged;

  const AdaptativeDate({this.selectedDate, this.onDataChanged, Key? key})
      : super(key: key);

  _showDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      onDataChanged!(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2022),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDataChanged!,
            ),
          )
        : Container(
            height: 70,
            child: Row(children: [
              Expanded(
                child: Text(selectedDate == null
                    ? 'Nenhuma data selecionada: '
                    : 'Data Selecionada:  ${DateFormat('dd/MM/y').format(selectedDate as DateTime)}'),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () => _showDatePicker(context),
                  child: Text('Selecione a data'))
            ]),
          );
  }
}
