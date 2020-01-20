import 'package:flutter/material.dart';
import 'package:analog_clock/constants.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    @required this.cardTitle,
    @required this.footer,
    @required this.content,
  });

  final String cardTitle;
  final Widget footer;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kCardSize,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kCardBorderRadius),
            border: Border.all(
                color: Colors.white54.withOpacity(0.2),
                style: BorderStyle.solid)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white54.withOpacity(0.2),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(kCardBorderRadius),
                    topLeft: Radius.circular(kCardBorderRadius)),
              ),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  cardTitle,
                  textAlign: TextAlign.center,
                  style: kDefaultTextStyle.copyWith(fontSize: 20.0),
                ),
              ),
            ),
            Expanded(child: this.content),
            Container(
                height: kFooterSize,
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: Colors.white54.withOpacity(0.2), width: 1.0)),
                ),
                child: this.footer)
          ],
        ),
      ),
    );
  }
}
