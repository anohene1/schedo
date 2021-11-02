import 'package:flutter/material.dart';

DateTime getDateTime(data) {
  return DateTime.fromMillisecondsSinceEpoch(int.tryParse(data.toString().substring(18, 28)) * 1000);
}