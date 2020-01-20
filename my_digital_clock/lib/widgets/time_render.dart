import 'package:flutter/material.dart';
import 'package:analog_clock/constants.dart';

class TimeRender extends StatelessWidget {
  const TimeRender({
    @required this.timeString,
    @required this.timeSeconds,
    @required this.timePeriod,
  });

  final String timeString;
  final String timeSeconds;
  final String timePeriod;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        RichText(
          text: TextSpan(
              text: '$timeString',
              style: kDefaultTextStyle.copyWith(fontSize: kTimeFontSize)),
        ),
        Padding(
          padding: EdgeInsets.only(left: kTimePaddingBetween),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                timePeriod,
                textAlign: TextAlign.start,
                style: kDefaultTextStyle.copyWith(fontSize: kTimeExtraFontSize),
              ),
              Text(
                ':$timeSeconds',
                textAlign: TextAlign.start,
                style: kDefaultTextStyle.copyWith(fontSize: kTimeExtraFontSize),
              ),
            ],
          ),
        )
      ],
    );
  }
}
