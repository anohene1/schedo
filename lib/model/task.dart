import 'package:flutter/material.dart';

class Task {
  final String title;
  final String type;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime date;
  final DateTime month;
  bool getAlert;
  bool isCompleted;

  Task({
      this.title,
      this.type,
      this.startTime,
      this.endTime,
      this.date,
    this.month,
      this.getAlert = true,
      this.isCompleted = false,
      });

  void toggleCompleted () {
    isCompleted = !isCompleted;
  }

  void toggleAlert() {
    getAlert = !getAlert;
  }
}
