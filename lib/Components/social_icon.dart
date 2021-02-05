import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hqclass/Util/Constants/common_colors.dart';

class SocialIcon extends StatelessWidget {
  final String iconStr;
  final Function press;

  const SocialIcon({
    Key key,
    this.iconStr,
    this.press,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: CommonColors.kPrimaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconStr,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
