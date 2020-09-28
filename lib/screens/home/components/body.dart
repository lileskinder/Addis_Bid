import 'dart:async';
import 'dart:math';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/screens/home/models/BidBundel.dart';
import 'package:recipe_app/size_config.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'categories.dart';
import 'bid_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool showSpinner = true;
  List<BidBundle> _bidBundlesList = [];
  GlobalKey<RefreshIndicatorState> refreshKey;
  Random r;
  Query productsRef;

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    r = Random();
    productsRef = FirebaseDatabase.instance
        .reference()
        .child('Products')
        .orderByChild('timeStamp');

    productsRef.once().then((DataSnapshot snapshot) {
      // ignore: non_constant_identifier_names
      var KEYS = snapshot.value.keys;

      // ignore: non_constant_identifier_names
      var DATA = snapshot.value;

      _bidBundlesList.clear();

      for (var individualKey in KEYS) {
        BidBundle bidBundle = new BidBundle(
            DATA[individualKey]['imageSrc'],
            DATA[individualKey]['productName'],
            DATA[individualKey]['productCat'],
            DATA[individualKey]['gapPrice'],
            DATA[individualKey]['startingPrice'],
            DATA[individualKey]['timeStamp']);

        _bidBundlesList.add(bidBundle);
      }

      setState(() {
        this._bidBundlesList = _bidBundlesList;
        showSpinner = false;
      });
    });
  }

  addRandomProduct() {
    // int nextCount = r.nextInt(100);
    productsRef = FirebaseDatabase.instance
        .reference()
        .child('Products')
        .orderByChild('timeStamp');

    productsRef.once().then((DataSnapshot snapshot) {
      // ignore: non_constant_identifier_names
      var KEYS = snapshot.value.keys;
      // ignore: non_constant_identifier_names
      var DATA = snapshot.value;
      _bidBundlesList.clear();

      for (var individualKey in KEYS) {
        BidBundle bidBundle = new BidBundle(
            DATA[individualKey]['imageSrc'],
            DATA[individualKey]['productName'],
            DATA[individualKey]['productCat'],
            DATA[individualKey]['gapPrice'],
            DATA[individualKey]['startingPrice'],
            DATA[individualKey]['timeStamp']);

        _bidBundlesList.add(bidBundle);
      }

      setState(() {
        this._bidBundlesList = _bidBundlesList;
      });
    });
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 3));
    addRandomProduct();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          await refreshList();
        },
        child: SafeArea(
            child: Column(
          children: <Widget>[
            Categories(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.defaultSize * 2),
                child: _bidBundlesList.length == 0
                    ? Text('No Products Available!')
                    : GridView.builder(
                        itemCount: _bidBundlesList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              SizeConfig.orientation == Orientation.landscape
                                  ? 2
                                  : 1,
                          mainAxisSpacing: 20,
                          crossAxisSpacing:
                              SizeConfig.orientation == Orientation.landscape
                                  ? SizeConfig.defaultSize * 2
                                  : 0,
                          childAspectRatio: 1.65,
                        ),
                        itemBuilder: (context, index) => BidBundelCard(
                          bidBundle: _bidBundlesList[index],
                          press: () {},
                        ),
                      ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
