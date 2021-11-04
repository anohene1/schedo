import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedo_final/model/models.dart';
import 'package:schedo_final/model/task.dart';
import 'package:schedo_final/view/components/components.dart';

class TaskType extends ChangeNotifier {

  List<Category> taskTypes = [
    Category(title: 'Important'),
    Category(title: 'Planned')
  ];

  void deselectAllButtons() {
    taskTypes.forEach((element) { element.isSelected = false; });
    notifyListeners();
  }

  void setSelected(Category item) {
    item.isSelected = true;
    notifyListeners();
  }
}

TextEditingController taskTitleController = TextEditingController();
TextEditingController taskDescriptionController = TextEditingController();

String title;
String description;
DateTime selectedDate;
TimeOfDay startTime;
TimeOfDay endTime;
bool getAlert = true;
String taskType;

class AddTaskScreen extends StatefulWidget {

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).brightness == Brightness.dark
          ? Color(0xFF0F0F15)
          : Color(0xFF757575),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50), topLeft: Radius.circular(50))),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 5,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Color(0xFF4B4B4B)
                    : Color(0xFFE5E6E8),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            VerticalSpacing(25),
            Text(
              'Create a task',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
            VerticalSpacing(25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Task title'),
                VerticalSpacing(10),
                TextField(
                  style: TextStyle(
                    fontSize: 20
                  ),
                  controller: taskTitleController,
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                  onChanged: (value) {
                    title = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Task Title',
                    filled: true,
                    fillColor: Theme.of(context).buttonColor,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color(0xFF4B4B4B)
                              : Color(0xFFE5E6E8),
                          width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color(0xFF4B4B4B)
                              : Color(0xFFE5E6E8),
                          width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                )
              ],
            ),
            VerticalSpacing(30),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Task type'),
                  VerticalSpacing(10),
                  Container(
                    height: 70,
                    child: Consumer<TaskType>(
                      builder: (context, tTypes, child) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: tTypes.taskTypes.length,
                          itemBuilder: (context, index) {
                            return CategoryButton(
                              title: tTypes.taskTypes[index].title,
                              isSelected: tTypes.taskTypes[index].isSelected,
                              onTap: () {
                                tTypes.deselectAllButtons();
                                tTypes.setSelected(tTypes.taskTypes[index]);
                                setState(() {
                                  taskType = tTypes.taskTypes[index].title;
                                });
                              },
                            );
                          },
                        );
                      }
                    ),
                  )
                ],
            ),
            VerticalSpacing(30),
            taskType == 'Planned' ? TextField(
              minLines: 1,
              maxLines: 5,
              style: TextStyle(
                  fontSize: 20
              ),
              controller: taskDescriptionController,
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
              },
              onChanged: (value) {
                description = value;
              },
              decoration: InputDecoration(
                hintText: 'Task Description',
                filled: true,
                fillColor: Theme.of(context).buttonColor,
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Color(0xFF4B4B4B)
                          : Color(0xFFE5E6E8),
                      width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Color(0xFF4B4B4B)
                          : Color(0xFFE5E6E8),
                      width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ) : SizedBox.shrink(),
            VerticalSpacing(30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Choose date & time'),
                VerticalSpacing(10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                       selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year),
                          lastDate: DateTime(2099),
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: Theme.of(context).brightness == Brightness.light
                                    ? ColorScheme.light(
                                  primary: Theme.of(context).primaryColor,
                                  surface: Theme.of(context).accentColor,
                                )
                                : ColorScheme.dark(
                                  primary: Theme.of(context).primaryColor,
                                  surface: Theme.of(context).primaryColor,
                                  onPrimary: Colors.white
                                ),
                                dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              ),
                              child: child,
                            );
                          }
                        );
                      },
                      child: Container(
                        height: 70,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).buttonColor,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).primaryColorLight,
                            ),
                            HorizontalSpacing(10),
                            Text(
                              'Select date',
                              style: TextStyle(
                                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).primaryColorLight,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        showModalBottomSheet<dynamic>(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return Wrap(
                                children: [
                                  Container(
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? Color(0xFF0F0F15)
                                        : Color(0xFF757575),
                                    child: Container(
                                      height: 200,
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CategoryButton(
                                              title: 'Start time',
                                            onTap: () {
                                                Navigator.of(context).push(
                                                  showPicker(
                                                    context: context,
                                                      barrierDismissible: false,
                                                      value: TimeOfDay.now(),
                                                      borderRadius: 50,
                                                      onChange: (time) {
                                                          startTime = time;
                                                      },
                                                  )
                                                );
                                            },
                                          ),
                                          CategoryButton(
                                            title: 'End time',
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  showPicker(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    value: TimeOfDay.now(),
                                                    borderRadius: 50,
                                                    onChange: (time) {
                                                      endTime = time;
                                                    },
                                                  )
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              );
                            }
                        );
                      },
                      child: Container(
                        height: 70,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: Theme.of(context).buttonColor,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Row(
                          children: [
                            Icon(
                                Icons.access_time,
                              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).primaryColorLight,
                            ),
                            HorizontalSpacing(10),
                            Text(
                                'Select time',
                              style: TextStyle(
                                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Theme.of(context).primaryColorLight,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            VerticalSpacing(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Get alert for this task',
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
                CupertinoSwitch(
                  activeColor: Theme.of(context).primaryColor,
                  value: getAlert,
                  onChanged: (value) {
                    setState(() {
                      getAlert = value;
                    });
                  },
                )
              ],
            ),
            VerticalSpacing(30),
            GestureDetector(
              onTap: () {
                if (taskTitleController.text.isEmpty) {
                  showError(context: context, title: 'Error!', error: 'Task title cannot be empty.');
                } else if (startTime == null) {
                  showError(context: context, title: 'Error!' ,error: 'Select the time the task should start.');
                } else if (selectedDate == null) {
                  showError(context: context, title: 'Error!' ,error: 'Select the date of the task.');
                }
                else {
                  Provider.of<FirestoreService>(context, listen: false).addTask(
                      Task(
                        title: title,
                        description: description,
                        type: taskType,
                        date: selectedDate,
                        startTime: DateTime(selectedDate.year, selectedDate.month, selectedDate.day, startTime.hour, startTime.minute),
                        endTime: endTime == null ? null : DateTime(selectedDate.year, selectedDate.month, selectedDate.day, endTime.hour, endTime.minute),
                        getAlert: getAlert,
                      )
                  ).then((value){
                  }).catchError((e){
                    print(e);
                  });

                  // Resets the add task form
                  Navigator.pop(context);
                  Provider.of<TaskType>(context, listen: false).deselectAllButtons();
                  taskTitleController.clear();
                  taskDescriptionController.clear();
                  taskType = null;
                  selectedDate = null;
                  startTime = null;
                  endTime = null;
                }
                // if (Provider.of<FirestoreService>(context, listen: false).isLoading){
                //   showDialog(
                //     context: context,
                //     barrierDismissible: false,
                //     builder: (context) {
                //       return Center(child: CircularProgressIndicator());
                //     }
                //   );
                // }
              },
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: pink,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                  child: Text(
                      'Done',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ),
                  ),
                ),
              ),
            ),
            VerticalSpacing(30),
          ],
        ),
      ),
    );
  }
}

