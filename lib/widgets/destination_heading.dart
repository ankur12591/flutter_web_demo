import 'package:flutter/material.dart';

class DestinationHeading extends StatelessWidget {
  const DestinationHeading({
    Key key,
    this.screenSize,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: screenSize.height / 10,
        bottom: screenSize.height / 15,
      ),
      width: screenSize.width,
      // color: Colors.black,
      child: Text(
        'Destinations diversity',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 40,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
