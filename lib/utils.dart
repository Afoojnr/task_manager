import 'package:flutter/material.dart';

List months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'Aay',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

List daysOfWeek = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

String formatDate(DateTime date) {
  return "${daysOfWeek[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}";
}

String formatTime(TimeOfDay time) {
  return "${time.hour < 10 ? "0${time.hour}" : time.hour}:${time.minute < 10 ? "0${time.minute}" : time.minute}";
}

bool isEmoji(String input) {
  final emojiPattern =
      RegExp(r"^(?:[\u203C-\u3299\uD83C-\uDBFF\uDC00-\uDFFF]+)$");

  return emojiPattern.hasMatch(input);
}
