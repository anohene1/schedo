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

          DateTime today = DateTime.now();
          List<QueryDocumentSnapshot> completed = snapshot.data.docs.where((item) => item['is_completed'] && item['type'] != 'Important').toList().where((element) => getDateTime(element['date']).year == today.year && getDateTime(element['date']).month == today.month && getDateTime(element['date']).day == today.day).toList();
          List<QueryDocumentSnapshot> uncompleted = snapshot.data.docs.where((item) => item['is_completed'] == false && item['type'] != 'Important').toList().where((element) => getDateTime(element['date']).year == today.year && getDateTime(element['date']).month == today.month && getDateTime(element['date']).day == today.day).toList();


          return ListView(
            children: [
              uncompleted.isEmpty ? SizedBox.shrink() : ListHeading(title: 'Tasks',),
              ...uncompleted.map((document) => CheckableTaskWidget(
                title: document.data()['title'],
                description: document.data()['description'],
                taskID: '${document.id}',
                startTime: getDateTime(document.data()['start_time']),
                endTime: document.data()['end_time'] == null
                    ? null
                    : getDateTime(document.data()['end_time']),
                date: getDateTime(document.data()['date']).day.toString(),
                day: DateFormat.EEEE()
                    .format((getDateTime(document.data()['date'])))
                    .substring(0, 3),
                isCompleted: document.data()['is_completed'],
              )),
              completed.isEmpty ? SizedBox.shrink() : ListHeading(title: 'Completed',),
              ...completed.map((document) => CheckableTaskWidget(
                title: document.data()['title'],
                description: document.data()['description'],
                taskID: '${document.id}',
                startTime: getDateTime(document.data()['start_time']),
                endTime: document.data()['end_time'] == null
                    ? null
                    : getDateTime(document.data()['end_time']),
                date: getDateTime(document.data()['date']).day.toString(),
                day: DateFormat.EEEE()
                    .format((getDateTime(document.data()['date'])))
                    .substring(0, 3),
                isCompleted: document.data()['is_completed'],
              )),
            ],
          );
      },
    );
  }
}