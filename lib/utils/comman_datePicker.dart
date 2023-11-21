import 'package:flutter/material.dart';

Future<DateTime?> showCommonDatePicker(BuildContext context, DateTime? selectedDate) async {
  return await showDatePicker(
    context: context,
    initialDate: selectedDate ?? DateTime.now(),
    firstDate: DateTime(1999),
    lastDate: DateTime(2028),
  );
}
