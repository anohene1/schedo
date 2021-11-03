import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedo_final/model/models.dart';
import 'package:schedo_final/model/task.dart';
import 'components.dart';

class CheckableTaskWidget extends StatefulWidget {
  final String title;
  final String description;
  final String day;
  final String date;
  final DateTime startTime;
  final DateTime endTime;
  final String taskID;
  bool isCompleted;

  CheckableTaskWidget({
    this.title,
    this.description,
    this.day,
    this.date,
    this.startTime,
    this.endTime,
    this.taskID,
    this.isCompleted = false,
  });

  @override
  _CheckableTaskWidgetState createState() => _CheckableTaskWidgetState();
}

class _CheckableTaskWidgetState extends State<CheckableTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20) + EdgeInsets.only(left: 20, right: 10),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).buttonColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: Theme.of(context).buttonColor,
            style: BorderStyle.solid,
            width: 2),
      ),
      // height: 100,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${widget.title}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColorLight,
                        decoration: widget.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        size: 13,
                        color: Theme.of(context).dividerColor,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '${TimeOfDay.fromDateTime(widget.startTime).format(context)}' +
                            "${widget.endTime != null ? ' - ${TimeOfDay.fromDateTime(widget.endTime).format(context)}' : ''}",
                        style: TextStyle(
                            color: Theme.of(context).dividerColor, fontSize: 12),
                      )
                    ],
                  )
                ],
              ),
              Transform.scale(
                  scale: 1.5,
                  child: Checkbox(
                    value: widget.isCompleted,
                    side: BorderSide(
                        width: 0.5, color: Theme.of(context).primaryColorLight),
                    onChanged: (value) {
                      Provider.of<FirestoreService>(context, listen: false).updateTask(value, widget.taskID);
                      setState(() {
                        widget.isCompleted = value;
                      });
                    },
                    shape: CircleBorder(),
                    activeColor: Theme.of(context).primaryColor,
                  ))
            ],
          ),
          widget.description == null ? SizedBox.shrink() : VerticalSpacing(20),
          widget.description == null ? SizedBox.shrink() : Text(widget.description, style: TextStyle(
              color: Theme.of(context).dividerColor, fontSize: 18),)
        ],
      ),
    );
  }
}
