import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:schedo_final/controller/functions.dart';
import 'package:schedo_final/model/models.dart';
import 'package:schedo_final/view/components/components.dart';

class MyDayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Provider.of<FirestoreService>(context).users.orderBy('timestamp').snapshots(),
      // stream: Provider.of<FirestoreService>(context).users.orderBy('timestamp').snapshots(),
      // stream: FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser.uid).snapshots(),
      builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('There was a problem'),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: Text('There is nothing yet. Add something'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('Waiting...'),
            );
          }

          return ListView(
            children: snapshot.data.docs.map((document) {
              return TaskWidget(
                title: document.data()['title'],
                startTime: getDateTime(document.data()['start_time']),
                endTime: document.data()['end_time']  == null ? null : getDateTime(document.data()['end_time']),
                date: getDateTime(document.data()['date']).day.toString(),
                day: DateFormat.EEEE().format((getDateTime(document.data()['date']))).substring(0, 3),
                // startTime: DateTime.fromMillisecondsSinceEpoch(int.tryParse(document.data()['start_time'].toString().substring(18, 28)) * 1000),
                // endTime: document.data()['end_time']  == null ? null : DateTime.fromMillisecondsSinceEpoch(int.tryParse(document.data()['end_time'].toString().substring(18, 28)) * 1000),
                // date: DateTime.fromMillisecondsSinceEpoch(int.tryParse(document.data()['date'].toString().substring(18, 28)) * 1000).day.toString(),
                // day: DateFormat.EEEE().format((DateTime.fromMillisecondsSinceEpoch(int.tryParse(document.data()['date'].toString().substring(18, 28)) * 1000))).substring(0, 3),
                isCompleted: document.data()['is_completed'],
              );
            }).toList(),
          );
      },
    );
  }
}