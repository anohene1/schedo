import 'package:flutter/material.dart';
import 'components.dart';

// Widget SocialButton(String social, String image) {
//   return
// }

class SocialButton extends StatelessWidget {

  SocialButton({
   @required this.title,
   @required this.imageIcon,
   @required this.onTap,
  });

  final String title;
  final String imageIcon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        height: 65,
        width: double.infinity,
        decoration:
        BoxDecoration(color: Theme.of(context).buttonColor, borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: <Widget>[
            Container(
                height: 65,
                child: Container(
                  height: 20,
                  width: 20,
                  child: Image.asset(imageIcon),
                )),
            Container(
              height: 65,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Continue with $title',
                  style:
                  TextStyle( color: Theme.of(context).primaryColorLight, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
