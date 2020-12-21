import 'package:flutter/material.dart';
import 'package:book_club/src/commons/colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final TextAlign align;

  CustomText(
      {@required this.text, this.size, this.color, this.weight, this.align});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align ?? null,
      style: TextStyle(
          fontSize: size ?? 16,
          color: color ?? black,
          fontWeight: weight ?? FontWeight.normal),
    );
  }
}
