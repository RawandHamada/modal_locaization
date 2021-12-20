import 'package:flutter/material.dart';

class OutBoardingContent extends StatelessWidget {
  final int imageNumber;



  OutBoardingContent({required this.imageNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 493,
      margin: EdgeInsetsDirectional.only(top: 92),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Column(
          children: [
            Image.asset('images/out_boarding_$imageNumber.png'),
            //Title Text
          ],
        ),
      ),
    );
  }
}