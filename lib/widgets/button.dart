import 'package:flutter/material.dart';
import 'package:shipping_app/utils/utils.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    required this.title,
    super.key,
    this.onPressed,
    this.width,
    this.height = 58,
    this.padding,
    this.busy = false,
    this.background = kPrimaryBlack,
    this.foreground = white,
    this.textSize = 16,
    this.borderRadius = 100,
    this.isDisabled = false,
    this.isBordered = false,
  });
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final String title;
  final Color? background;
  final Color? foreground;
  final double? textSize;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool busy;
  final bool isDisabled;
  final bool isBordered;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: busy
            ? null
            : isDisabled
                ? null
                : onPressed,
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          backgroundColor: MaterialStatePropertyAll(background),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        child: busy
            ? const CircularProgressIndicator(
                color: white,
              )
            : Text(
                title,
                style: TextStyle(
                  color: isDisabled ? foreground!.withOpacity(0.5) : foreground,
                  fontSize: textSize,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                ),
              ),
      ),
    );
  }
}
