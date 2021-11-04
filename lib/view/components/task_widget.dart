import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components.dart';

class TaskWidget extends StatelessWidget {

  final String title;
  final String day;
  final String date;
  final DateTime startTime;
  final DateTime endTime;
  bool isCompleted;
  bool withDate;

  TaskWidget({
    this.title,
    this.day,
    this.date,
    this.startTime,
    this.endTime,
    this.isCompleted = false,
    this.withDate = true,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: withDate ? 10 : 20, right: 20),
      margin: EdgeInsets.only(bottom: 20),
      decoration:
      BoxDecoration(color: Theme.of(context).buttonColor, borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: Theme.of(context).canvasColor,
            style: BorderStyle.solid,
            width: 2
        ),
      ),
      height: 100,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          withDate ? Container(
            height: 80,
            width: 60,
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(15)
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(day, style: TextStyle(color: Theme.of(context).primaryColorLight),),
                  SizedBox(height: 3,),
                  Text(date, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Theme.of(context).primaryColorLight),)
                ],
              ),
            ),
          ) : SizedBox.shrink(),
          withDate ? SizedBox(width: 30,) : SizedBox.shrink(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '$title',
                style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 20,
                    // color: Theme.of(context).primaryColorLight,
                    decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none
                ),
              ),

              SizedBox(height: 10,),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.baseline,
                children: <Widget>[
                  Icon(Icons.access_time, size: 13, color: Theme.of(context).dividerColor,),
                  SizedBox(width: 4,),
                  Text('${TimeOfDay.fromDateTime(startTime).format(context)}' +
                      "${endTime != null ? ' - ${TimeOfDay.fromDateTime(endTime).format(context)}' : ''}", style: TextStyle(color: Theme.of(context).dividerColor, fontSize: 12),)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
