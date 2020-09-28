import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe_app/constants.dart';
import 'package:recipe_app/screens/home/components/progress_Indicator.dart';
import 'package:recipe_app/screens/home/models/BidBundel.dart';

import '../../../size_config.dart';

class BidBundelCard extends StatefulWidget {
  final BidBundle bidBundle;
  final Function press;

  const BidBundelCard({Key key, this.bidBundle, this.press}) : super(key: key);

  @override
  _BidBundelCardState createState() => _BidBundelCardState();
}

class _BidBundelCardState extends State<BidBundelCard> {
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    // Now we dont this Aspect ratio
    return GestureDetector(
      onTap: widget.press,
      child: Card(
        color: Colors.white,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Image.network(
                  widget.bidBundle.imageSrc,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(width: defaultSize * 0.5),
              Expanded(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        child: RaisedButton(
                          onPressed: () {},
                          color: kPrimaryColor,
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Bid ${widget.bidBundle.startingPrice}Br',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: kTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                      child: TimerProgressIndicator(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildInfoRow(double defaultSize, {String iconSrc, text}) {
    return Row(
      children: <Widget>[
        SvgPicture.asset(iconSrc),
        SizedBox(width: defaultSize), // 10
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
