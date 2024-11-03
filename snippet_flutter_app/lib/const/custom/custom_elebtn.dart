import 'package:flutter/material.dart';

class CustomElebtn extends StatelessWidget {
  final double width;
  final double height;
  final String txt;
  final Function() onPressed;
  const CustomElebtn({super.key, required this.width, required this.height, required this.txt, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    int txtLen = txt.length;
    double fontSize = (width/txtLen).clamp(10,12);
    return ElevatedButton(
      
      onPressed:  onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, height)
      ),
      child: Text(
      txt,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        
      ),)
      );
  }
}