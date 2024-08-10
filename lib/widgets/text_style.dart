import 'package:flutter/material.dart';
import 'package:shipping_app/utils/utils.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({
    required this.text,
    super.key,
    this.textSize = 25,
    this.foreground = kTextColor,
    this.letterSpacing = 0,
    this.fontWeight = FontWeight.w600,
    this.textAlign = TextAlign.left,
  });
  final String text;
  final double textSize;
  final Color? foreground;
  final double letterSpacing;
  final TextAlign textAlign;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: foreground,
        fontSize: textSize,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight,
      ),
    );
  }
}

class SubText extends StatelessWidget {
  const SubText({
    required this.text,
    super.key,
    this.textSize = 15,
    this.foreground = kTextColor,
    this.decoration,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    // this. //letterSpacing,
    this.fontStyle = FontStyle.normal,
    this.fontWeight = FontWeight.w400,
    this.shadows = const [],
    this.height,
  });
  final String text;
  final double textSize;
  final Color? foreground;
  final FontStyle fontStyle;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final List<Shadow> shadows;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
      overflow: overflow,
      style: TextStyle(
        height: height,
        color: foreground,
        overflow: overflow,
        fontSize: textSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        shadows: shadows,
        decoration: decoration,
      ),
    );
  }
}
