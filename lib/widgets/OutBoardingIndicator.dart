import 'package:flutter/material.dart';

class OutBoardingIndicator extends StatelessWidget {
  final double marginEnd;
  final bool isSelected;


  OutBoardingIndicator({this.marginEnd = 0,required this.isSelected});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: marginEnd),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isSelected ? Color(0xFF11AAFC):Color(0xFFD6D6D6),
      ),
    );
  }
}