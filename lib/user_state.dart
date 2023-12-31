import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:setp/Jobs/job_screen.dart';
import 'package:setp/LoginPage/login_screen.dart';

class UserState extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, userSnapshot){
        if(userSnapshot.data == null)
          {
            print('USer is not logged in yet.');
            return Login();
          }
        else if(userSnapshot.hasData){
          print('User is already logged in yet.');
          return JobScreen();
        }
        else if (userSnapshot.hasError)
          {
            return const Scaffold(
              body: Center(
                child: Text('An error has been occurred. Try again later'),
              ),
            );
          }
        else if (userSnapshot.connectionState == ConnectionState.waiting)
        {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return const Scaffold(
          body: Center(
            child: Text('Something went Wrong.'),
          ),
        );
      },
    );
  }
}
