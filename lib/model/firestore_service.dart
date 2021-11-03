import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedo_final/model/task.dart';

class FirestoreService with ChangeNotifier {

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String uid = FirebaseAuth.instance.currentUser.uid;

  CollectionReference users = FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser.uid);

  bool isLoading = true;

  void setLoadingStatus() {
    isLoading = false;
    notifyListeners();
  }

  Future<void> addTask(Task task) {
      return users.add({
        'title': task.title,
        'description': task.description,
        'type': task.type,
        'start_time': task.startTime,
        'end_time': task.endTime,
        'date': task.date,
        'get_alert': task.getAlert,
        'is_completed': task.isCompleted,
        'timestamp': DateTime.now().millisecondsSinceEpoch
      }).then((value){
        setLoadingStatus();
        print('Task added!');
        print(isLoading);
      }).catchError((e){
        print(e);
      });
  }

  Future<void> updateTask(bool isCompleted, String id) {
    return users.doc(id).update({'is_completed': isCompleted});
  }

}