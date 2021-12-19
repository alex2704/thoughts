import 'package:flutter/material.dart';
import 'package:thoughts/theme/colors.dart';

class MyOrangeElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry edgeInsetsGeometry;
  final double? fontSize;

  const MyOrangeElevatedButton({required this.child, required this.onPressed,
    required this.edgeInsetsGeometry, this.fontSize = 18,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton
      (onPressed: onPressed, child: child,
      style: ElevatedButton.styleFrom(
          primary: CustomColors.orange,
          padding: edgeInsetsGeometry,
          textStyle: TextStyle(fontSize: fontSize, color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50)
          )
      ),);
  }


}