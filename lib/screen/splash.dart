import 'dart:async';

import 'package:brew_crew/screen/wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(milliseconds: 3000), () => Navigator.popAndPushNamed(context, '/wrapper'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Opacity(
              opacity: 0.5,
              child: Image.asset('asset/bg.png'),
            ),
            Shimmer.fromColors(
              period: Duration(milliseconds: 2000),
              baseColor: Colors.brown[600],
              highlightColor:  Color(0xFF8D6E63),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Brew Crew',
                  style: TextStyle(
                    fontSize: 60.0,
                    fontFamily: 'Pacifico',
                    shadows: <Shadow> [
                      Shadow(
                        blurRadius: 18.0,
                        color: Colors.black,
                        offset: Offset.fromDirection(120,12)
                      )
                    ]
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


/*
*/