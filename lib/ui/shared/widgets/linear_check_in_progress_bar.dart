// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class LinearCheckInProgressBar extends StatelessWidget {
  final int currentDot;

  const LinearCheckInProgressBar({
    super.key,
    required this.currentDot,
  });
  Widget _line({required Color color}) {
    return Expanded(
        child: Container(
      height: 2,
      color: color,
    ));
  }

  Widget _dot(
    
      {required Color borderColor,
      required Color backgroundColor,
      required Color textColor,
      required String step}) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Center(
        child: Text(
          step,
          style: TextStyle(color: textColor),
        ),
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final onPrimary  =Theme.of(context).colorScheme.onPrimary;
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            _dot(
                textColor: currentDot==1?onPrimary:primaryColor,
                borderColor: primaryColor,
                backgroundColor:
                    currentDot == 1 ? primaryColor : Colors.transparent,
                step: '1'),
            _line(color: Colors.grey),
            _dot(
              textColor: currentDot==2?onPrimary:primaryColor,
                borderColor: primaryColor,
                backgroundColor:
                    currentDot == 2 ? primaryColor : Colors.transparent,
                step: '2'),
            _line(color: Colors.grey),
            _dot(
              textColor: currentDot==3?onPrimary:primaryColor,
                borderColor: primaryColor,
                backgroundColor:
                    currentDot == 3 ? primaryColor : Colors.transparent,
                step: '3'),
            // Container(
            //   padding: EdgeInsets.all(8),
            //   child: Center(
            //     child: Text('1'),
            //   ),
            //   decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: primaryColor,
            //       border: Border.all(color: Colors.black, width: 0.1)),
            // ),
            // _line(color: primaryColor),
            // Container(
            //   padding: EdgeInsets.all(8),
            //   child: Center(
            //     child: Text('2'),
            //   ),
            //   decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: Colors.transparent,
            //       border: Border.all(color: primaryColor, width: 2)),
            // ),
            // _line(color: Colors.grey),
            // Container(
            //   padding: EdgeInsets.all(8),
            //   child: Center(
            //     child: Text('3'),
            //   ),
            //   decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: primaryColor,
            //       border: Border.all(color: Colors.black, width: 0.1)),
            // ),
          ],
        )
      ],
    );
  }
}
