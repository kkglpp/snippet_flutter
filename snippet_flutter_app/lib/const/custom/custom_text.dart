import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String txt;
  final double width;
  final double height;
  final Color fontColor;
  final double fontSize;
  const CustomText({super.key, required this.txt, this.width = 80, this.height=30, this.fontColor = Colors.black, this.fontSize = 12});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Text(
        txt,
        softWrap: true,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: fontColor,
          fontSize: fontSize,
          
        ),
        
      ),
    );
  }
}