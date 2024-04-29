import 'package:flutter/material.dart';

class DateField extends StatelessWidget {
  const DateField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: '2024/05/19'),
      decoration: const InputDecoration(
        labelText: '날짜',
        icon: Icon(Icons.calendar_month),
        contentPadding: EdgeInsets.all(8),
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      readOnly: true,
      onTap: () {
        showDateRangePicker(
          context: context,
          firstDate: DateTime(1900),
          lastDate: DateTime(2300),
        ).then((value) {
          print(value?.start);
          print(value?.end);
        });
      },
    );
  }
}
