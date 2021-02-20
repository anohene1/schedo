import 'dart:io';

import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedo_final/view/components/components.dart';

class AddTaskScreen extends StatelessWidget {

  DateTime selectedDate;

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
                  Row(
                    children: [
                      CategoryButton(title: 'Important'),
                      CategoryButton(title: 'Planned')
                    ],
                  )
                ],
            ),
            VerticalSpacing(30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Choose date & time'),
                VerticalSpacing(10),
                Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        // TODO: Implement date picking

                        showDatePicker(
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
                                        borderRadius: BorderRadius.circular(50)
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
                                                      value: TimeOfDay.now(),
                                                      borderRadius: 50,
                                                      onChange: (time) {
                                                      //TODO: Handle time picking
                                                          print(time);
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
                                                    value: TimeOfDay.now(),
                                                    borderRadius: 50,
                                                    onChange: (time) {
                                                      //TODO: Handle time picking
                                                      print(time);
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
                  value: true,
                  onChanged: (value) {

                  },
                )
              ],
            ),
            VerticalSpacing(30),
            Container(
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
            VerticalSpacing(30),
          ],
        ),
      ),
    );
  }
}
