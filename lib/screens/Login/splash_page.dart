import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/screens/Login/login_page.dart';
import 'package:recipe_app/screens/Login/stores/login_store.dart';
import 'package:recipe_app/screens/UserData/userData_Screen.dart';
import 'package:recipe_app/screens/home/home_screen.dart';
import 'theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  Query userRef;
  String uid;

  @override
  void initState() {
    super.initState();
    Provider.of<LoginStore>(context, listen: false)
        .isAlreadyAuthenticated()
        .then((result) {
      if (result) {
        try {
          final user = _auth.currentUser;
          if (user != null) {
            loggedInUser = user;
            uid = user.uid;
          }
        } catch (e) {
          print(e);
        }

        //print('user is $loggedInUser');
        FirebaseFirestore.instance
            .collection('Users')
            .doc(uid)
            .get()
            .then((DocumentSnapshot documentSnapshot) {
          if (documentSnapshot.exists) {
            print('Document exists on the database');
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => HomeScreen()),
                (Route<dynamic> route) => false);
          } else {
            print('Document not exists on the database');
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => UserDataScreen()),
                (Route<dynamic> route) => false);
          }
        });

        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (_) => HomeScreen()),
        //     (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (Route<dynamic> route) => false);
      }
    });
  }

  // void getCurrentUser() async {
  //   try {
  //     final user = _auth.currentUser;
  //     if (user != null) {
  //       loggedInUser = user;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //
  //   var dbRef = FirebaseDatabase.instance.reference().child('Users');
  //   dbRef.orderByKey().equalTo('phone').once().then((DataSnapshot snapshot) {
  //     if (snapshot.value.isNotEmpty) {
  //       var ref = FirebaseDatabase.instance.reference();
  //       ref.child('Users').once().then((DataSnapshot snapshot) {
  //         print(snapshot.value);
  //         snapshot.value.forEach((key, values) {
  //           print(values["phone"]);
  //           phoneNum = values['phone'];
  //           print("this is the num $phoneNum");
  //         });
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
    );
  }
}
