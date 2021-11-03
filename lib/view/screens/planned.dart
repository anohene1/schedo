import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:schedo_final/controller/functions.dart';
import 'package:schedo_final/model/models.dart';
import 'package:schedo_final/view/components/components.dart';

class PlannedScreen extends StatefulWidget {

  @override
  _PlannedScreenState createState() => _PlannedScreenState();
}

class _PlannedScreenState extends State<PlannedScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarTimeline(
            initialDate: selectedDate,
            firstDate: DateTime(2020, 1, 1),
            lastDate: DateTime(2022, 12, 31),
            onDateSelected: (date) {
              setState(() {
                selectedDate = date;
              });
            },
            monthColor: Theme.of(context).primaryColorLight,
          dayColor: Theme.of(context).primaryColorLight,
          dayNameColor: Theme.of(context).primaryColorLight,
          activeBackgroundDayColor: Theme.of(context).primaryColor,
          activeDayColor: Colors.white,
          dayBackgroundColor: Theme.of(context).buttonColor,
          dotsColor: Theme.of(context).primaryColor,
          // showYears: true,
        ),
        VerticalSpacing(20),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: Provider.of<FirestoreService>(context)
                .users
                .where('type', isEqualTo: 'Planned')
                .orderBy('timestamp')
                .snapshots(),
            // stream: Provider.of<FirestoreService>(context).users.where('type', isEqualTo: 'Planned').orderBy('timestamp').snapshots(),
            // stream: FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser.uid).snapshots(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
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

              List<QueryDocumentSnapshot> completed = snapshot.data.docs.where((item) => item['is_completed']).toList();
              List<QueryDocumentSnapshot> uncompleted = snapshot.data.docs.where((item) => item['is_completed'] == false).toList();
              List<QueryDocumentSnapshot> completedOnDay = completed.where((element) => getDateTime(element['date']).year == selectedDate.year && getDateTime(element['date']).month == selectedDate.month && getDateTime(element['date']).day == selectedDate.day).toList();
              List<QueryDocumentSnapshot> uncompletedOnDay = uncompleted.where((element) => getDateTime(element['date']).year == selectedDate.year && getDateTime(element['date']).month == selectedDate.month && getDateTime(element['date']).day == selectedDate.day).toList();

              return ListView(
                children: [
                  ...uncompletedOnDay.map((document) => CheckableTaskWidget(
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
                  completedOnDay.isEmpty ? SizedBox.shrink() : ListHeading(title: 'Completed',),
                  ...completedOnDay.map((document) => CheckableTaskWidget(
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
          ),
        ),
      ],
    );
  }
}
