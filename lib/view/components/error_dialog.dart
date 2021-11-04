import 'package:flutter/material.dart';
import 'package:schedo_final/view/components/colors.dart';

void showError({@required BuildContext context, @required String title, @required String error}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(30)
            ),
            padding: EdgeInsets.only(top: 30),
            height: 170,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Gilroy',
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Text(error, textAlign: TextAlign.center,),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: pink,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
                    ),
                    child: Center(
                      child: Text(
                          'Okay',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          // actions: [
          //   FlatButton(
          //     child: Text('OK'),
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //   )
          // ],
        );
      }
  );
}
