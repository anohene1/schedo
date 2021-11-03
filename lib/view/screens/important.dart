import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:schedo_final/controller/functions.dart';
import 'package:schedo_final/model/models.dart';
import 'package:schedo_final/view/components/components.dart';

class ImportantScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Provider.of<FirestoreService>(context)
          .users
          .where('type', isEqualTo: 'Important')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      // stream: Provider.of<FirestoreService>(context).users.snapshots(),
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
        var items = groupBy(snapshot.data.docs,
            (item) => DateFormat.yMMMM().format(getDateTime(item['date'])));
        
        return ListView(
          children: [
            ...items.keys.map((month) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListHeading(title: month,),
                  ...items[month].map((task) {
                    return TaskWidget(
                                title: task.data()['title'],
                                startTime: getDateTime(task.data()['start_time']),
                                endTime: task.data()['end_time']  == null ? null : getDateTime(task.data()['end_time']),
                                date: getDateTime(task.data()['date']).day.toString(),
                                day: DateFormat.EEEE().format((getDateTime(task.data()['date']))).substring(0, 3),
                                isCompleted: task.data()['is_completed'],
                              );
                  })
                ],
              );
            })
          ],
        );

        // return ListView.builder(
        //   itemCount: items.length,
        //   itemBuilder: (context, index) {
        //     return Container(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             items.keys.elementAt(index),
        //             style: TextStyle(fontSize: 20),
        //           ),
        //           VerticalSpacing(10),
        //           Container(
        //             height: 300,
        //             child: ListView.builder(
        //               itemCount: 2,
        //               itemBuilder: (context, i) {
        //                 return Container();
        //               },
        //             ),
        //           ),
        //         ],
        //       ),
        //     );
        //   },
        // );

        // return ListView(
        // children: [

        // Text(
        //   'April 2021',
        //   style: TextStyle(
        //       fontSize: 20
        //   ),
        // ),
        // VerticalSpacing(20),
        // ...snapshot.data.docs.map((document) {
        //
        //
        //
        //   return Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Text(
        //           DateFormat.yMMMM().format(getDateTime(document.data()['date'])),
        //         style: TextStyle(
        //           fontSize: 20
        //         ),
        //       ),
        //       TaskWidget(
        //         title: document.data()['title'],
        //         startTime: getDateTime(document.data()['start_time']),
        //         endTime: document.data()['end_time']  == null ? null : getDateTime(document.data()['end_time']),
        //         date: getDateTime(document.data()['date']).day.toString(),
        //         day: DateFormat.EEEE().format((getDateTime(document.data()['date']))).substring(0, 3),
        //         isCompleted: document.data()['is_completed'],
        //       ),
        //     ],
        //   );
        // }).toList()
        // ]
        // );

        // return ListView(
        //   children: [
        //     // Text(
        //     //   'April 2021',
        //     //   style: TextStyle(
        //     //       fontSize: 20
        //     //   ),
        //     // ),
        //     // VerticalSpacing(20),
        //     ...snapshot.data.docs.map((document) {
        //       return TaskWidget(
        //         title: document.data()['title'],
        //         startTime: getDateTime(document.data()['start_time']),
        //         endTime: document.data()['end_time']  == null ? null : getDateTime(document.data()['end_time']),
        //         date: getDateTime(document.data()['date']).day.toString(),
        //         day: DateFormat.EEEE().format((getDateTime(document.data()['date']))).substring(0, 3),
        //         isCompleted: document.data()['is_completed'],
        //       );
        //     }).toList()
        //   ]
        // );
      },
    );
  }
}
