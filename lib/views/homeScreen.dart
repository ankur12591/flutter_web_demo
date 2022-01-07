import 'package:flutter/material.dart';
import 'package:flutter_wb_ui_demo/widgets/carousel.dart';
import 'package:flutter_wb_ui_demo/widgets/destination_heading.dart';
import 'package:flutter_wb_ui_demo/widgets/floating_quick_access_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double _opacity = 0;

  final List _isHovering = [
    false,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        //backgroundColor: Theme.of(context).backgroundColor,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 1000),
          child: Container(
            color: Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'EXPLORE',
                    style: TextStyle(
                      color: Colors.blueGrey[100],
                      fontSize: 20,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 3,
                    ),
                  ),
                  InkWell(
                      onHover: (value) {
                        setState(() {
                          value
                              ? _isHovering[0] = true
                              : _isHovering[0] = false;
                        });
                      },
                      onTap: () {},
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          color: _isHovering[0] ? Colors.white : Colors.white70,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: screenSize.height * 0.45,
                    width: screenSize.width,
                    child: Image.asset(
                      'assets/images/cover.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  FloatingQuickAccessBar(
                    screenSize: screenSize,
                  ),

                ],
              ),
              DestinationHeading(screenSize: screenSize,),
              DestinationCarousel(screenSize: screenSize,),
              SizedBox(height: 30,)
            ],
          ),
        ));
  }
}
