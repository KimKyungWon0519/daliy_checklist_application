import 'package:flutter/material.dart';

class DateRangePicker extends StatelessWidget {
  const DateRangePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _DailyChip(),
        SizedBox(width: 10),
        _PeriodChip(),
      ],
    );
  }
}

class _DailyChip extends StatelessWidget {
  const _DailyChip({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseChip(label: '하루');
  }
}

class _PeriodChip extends StatelessWidget {
  const _PeriodChip({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseChip(label: '기간');
  }
}

class _BaseChip extends StatelessWidget {
  final String label;

  const _BaseChip({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return RawChip(
      label: Text(label),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      onPressed: () {},
      avatar: Radio(
        value: false,
        groupValue: false,
        onChanged: (value) {},
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
