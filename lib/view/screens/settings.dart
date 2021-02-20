import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:schedo_final/view/screens/onboarding.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text(
            'Logout'
          ),
          onPressed: (){
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
            });
          },
        )
      ),
    );
  }
}