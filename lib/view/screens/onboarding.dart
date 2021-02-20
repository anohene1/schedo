import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:schedo_final/main.dart';
import 'package:schedo_final/model/auth_service.dart';
import "../components/components.dart";
import "screens.dart";
import '../../model/models.dart';

class OnboardingScreen extends StatelessWidget {

  final double iOSVersion;
  OnboardingScreen({this.iOSVersion});

  @override
  Widget build(BuildContext context) {

    //Get the AuthService
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 150),
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(30),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).buttonColor,
                  borderRadius: BorderRadius.circular(40)),
              child: Image.asset('assets/images/check.png'),
            ),
            VerticalSpacing(80),
            Text(
              'Welcome to Schedo',
              style: TextStyle(
                  fontSize: 28,
                  color: Theme.of(context).primaryColorLight,
                  // fontWeight: FontWeight.w900,
              ),
            ),
            VerticalSpacing(20),
            Text(
              "Create an account to save all schedules and access them from anywhere.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).dividerColor,
                  fontWeight: FontWeight.w400),
            ),
            VerticalSpacing(80),
            SocialButton(
                title:'Facebook',
                imageIcon: 'assets/images/Facebook.png',
              onTap: () {
                authService.signInWithFacebook().then((value){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Navigation()));
                }).catchError((e){
                  print(e);
                });
                // currentTheme.switchTheme();
              },
            ),
            VerticalSpacing(15),
           Platform.isIOS ? SizedBox.shrink() :  SocialButton(
             title:'Twitter',
             imageIcon: 'assets/images/Twitter.png',
             onTap: () {
               authService.signInWithTwitter().then((value){
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Navigation()));
               }).catchError((e){
                 print(e);
               });
               // currentTheme.switchTheme();
             },
           ),
            Platform.isIOS ? SizedBox.shrink() : VerticalSpacing(15),
            SocialButton(
                title: 'Google',
                imageIcon: 'assets/images/Google.png',
              onTap: () {
                  authService.signInWithGoogle().then((value){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Navigation()));
                  }).catchError((e){
                    print(e);
                  });
              },
            ),
            VerticalSpacing(15),
            Platform.isIOS && iOSVersion >= 13 ? SocialButton(
                title: 'Apple',
                imageIcon: 'assets/images/Apple-${Theme.of(context).brightness == Brightness.dark ? 'white' : 'black'}.png',
                onTap: (){
                  authService.signInWithApple().then((value){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Navigation()));
                  }).catchError((e){
                    print(e);
                  });
                }
            ) : SizedBox.shrink()
          ]
        ),
      ),
    );
  }
}
