import 'package:flutter/material.dart';
import 'package:analog_clock/constants.dart';

class DayReport extends StatelessWidget {
  const DayReport({
    @required this.dayNumber,
    @required this.monthString,
    @required this.dayOfTheWeekString,
  });

  final num dayNumber;
  final String monthString;
  final String dayOfTheWeekString;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: MediaQuery.of(context).size.width / 2.5,
      child: Center(
        child: Container(
          height: 230.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$dayOfTheWeekString',
                style: kDefaultTextStyle.copyWith(fontSize: 35.0),
              ),
              Text(
                DAY,
                style: kDefaultTextStyle,
              ),
              Expanded(
                child: Text('$dayNumber',
                    style: kDefaultTextStyle.copyWith(
                      fontSize: kDayNumberTextSize,
                    )),
              ),
              Text(
                '$MONTH $monthString',
                style: kDefaultTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
