import 'package:flutter/material.dart';
import 'package:schedo_final/view/components/components.dart';

class ListHeading extends StatelessWidget {
  final String title;

  const ListHeading({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Text(title, style: TextStyle(fontSize: 20),),
        ),
        VerticalSpacing(10),
      ],
    );
  }
}
