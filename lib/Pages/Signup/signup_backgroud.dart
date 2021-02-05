
import 'package:flutter/material.dart';

class SigupBackgroud extends StatelessWidget {
  final Widget child;

  const SigupBackgroud({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/img/signup_top.png",
              width: size.width * 0.35,
            ),
          ),
          Positioned(bottom: 0,
            left: 0,
            child: Image.asset(
                "assets/img/main_bottom.png",
                width: size.width * 0.25
            ),
          ),
          child,
        ],
      ),
    );
  }
}
