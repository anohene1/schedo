import 'package:flutter/material.dart';


class CategoryButton extends StatelessWidget {

  CategoryButton({
   @required this.title,
   this.isSelected = false,
    this.onTap,
});

  final String title;
  bool isSelected;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        width: 150,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).buttonColor,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: isSelected ? Colors.white : Theme.of(context).primaryColorLight,
                  fontWeight: FontWeight.bold,
                fontSize: 17
                  ),
            ),
        ),
      ),
    );
  }
}
