import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:recipe_app/screens/home/home_screen.dart';

class UserDataScreen extends StatefulWidget {
  @override
  _UserDataScreenState createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  String firstName, lastName, userName;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  String timeStamp, uid;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        uid = user.uid;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildFistName() {
      return TextFormField(
        decoration: InputDecoration(labelText: 'First Name'),
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) {
            return 'First Name is Required';
          }
        },
        onSaved: (String value) {
          firstName = value;
        },
      );
    }

    Widget _buildLastName() {
      return TextFormField(
        decoration: InputDecoration(labelText: 'Last Name'),
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) {
            return 'Last Name is Required';
          }
        },
        onSaved: (String value) {
          lastName = value;
        },
      );
    }

    Widget _buildUserName() {
      return TextFormField(
        decoration: InputDecoration(labelText: 'User Name'),
        // ignore: missing_return
        validator: (String value) {
          if (value.isEmpty) {
            return 'User Name is Required';
          }
        },
        onSaved: (String value) {
          userName = value;
        },
      );
    }

    Future<void> addUser() async {
      if (_formKey.currentState.validate()) {
        FirebaseFirestore.instance.collection('Users').doc(uid).set({
          'phone': loggedInUser.phoneNumber,
          'firstName': firstName,
          'lastName': lastName,
          'userName': userName,
          'timeStamp': DateTime.now().toString()
        });

        setState(() {
          loading = false;
        });
      }
    }

    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(24),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildFistName(),
                    _buildLastName(),
                    _buildUserName(),
                    SizedBox(
                      height: 50,
                    ),
                    RaisedButton(
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      onPressed: () {
                        // timeStamp = DateTime.now().millisecondsSinceEpoch;
                        if (!_formKey.currentState.validate()) {
                          setState(() {
                            loading = false;
                          });
                          return;
                        }
                        _formKey.currentState.save();
                        addUser();
                        setState(() {
                          loading = true;
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_) => HomeScreen()),
                              (Route<dynamic> route) => false);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Center(
        child: Image.asset(
          "assets/images/logo.png",
          width: 50,
        ),
      ),
    );
  }
}
