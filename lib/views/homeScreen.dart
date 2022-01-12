import 'package:flutter/material.dart';
import 'package:flutter_wb_ui_demo/services/authentication.dart';
import 'package:flutter_wb_ui_demo/widgets/auth_dialog.dart';
import 'package:flutter_wb_ui_demo/widgets/carousel.dart';
import 'package:flutter_wb_ui_demo/widgets/destination_heading.dart';
import 'package:flutter_wb_ui_demo/widgets/floating_quick_access_bar.dart';
import 'package:flutter_wb_ui_demo/widgets/web_scrollbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  static const String route = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ScrollController _scrollController;
  // double _scrollPosition = 0;
  // double _opacity = 0;

  bool _isProcessing = false;

  final List _isHovering = [
    false,
    false,
    false,
    false,
    false
  ];

  ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
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
                      onTap: userEmail == null
                          ? () {
                        showDialog(
                          context: context,
                          builder: (context) => AuthDialog(),
                        );
                      }
                          : null,
                      child: userEmail == null
                      ? Text(
                        'Sign in',
                        style: TextStyle(
                          color: _isHovering[0] ? Colors.white : Colors.white70,
                        ),
                      )
                    : Row(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: imageUrl != null
                                ? NetworkImage(imageUrl)
                                : null,
                            child: imageUrl == null
                                ? const Icon(
                              Icons.account_circle,
                              size: 30,
                            )
                                : Container(),
                          ),
                          SizedBox(width: 8),
                          Text(
                            name ?? userEmail,
                            style: TextStyle(
                              color: _isHovering[3]
                                  ? Colors.white
                                  : Colors.white70,
                            ),
                          ),
                          SizedBox(width: 10),
                          TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: _isProcessing
                                ? null
                                : () async {
                              setState(() {
                                _isProcessing = true;
                              });
                              await signOut().then((result) {
                                print(result);
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              }).catchError((error) {
                                print('Sign Out Error: $error');
                              });
                              setState(() {
                                _isProcessing = false;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 8.0,
                                bottom: 8.0,
                              ),
                              child: _isProcessing
                                  ? CircularProgressIndicator()
                                  : Text(
                                'Sign out',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: WebScrollbar(
          color: Colors.blueGrey,
          backgroundColor: Colors.blueGrey.withOpacity(0.3),
          width: 10,
          heightFraction: 0.3,
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
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
                DestinationHeading(
                  screenSize: screenSize,
                ),
                DestinationCarousel(
                  screenSize: screenSize,
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ));
  }
}
