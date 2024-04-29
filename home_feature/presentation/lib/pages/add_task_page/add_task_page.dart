import 'package:flutter/material.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새로운 목표'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('추가'),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).colorScheme.secondaryContainer),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: '목표',
                      icon: Icon(Icons.short_text_rounded),
                      contentPadding: EdgeInsets.all(8),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  Divider(),
                  Row(
                    children: [
                      RawChip(
                        label: Text('하루'),
                        backgroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        onPressed: () {},
                        avatar: Radio(
                          value: false,
                          groupValue: false,
                          onChanged: (value) {},
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      SizedBox(width: 10),
                      RawChip(
                        label: Text('기간'),
                        backgroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        onPressed: () {},
                        avatar: Radio(
                          value: true,
                          groupValue: false,
                          onChanged: (value) {},
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: TextEditingController(text: '2024/05/19'),
                    decoration: InputDecoration(
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
