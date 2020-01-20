import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:analog_clock/widgets/weather_card.dart';
import 'package:analog_clock/constants.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({
    @required this.condition,
    @required this.temperatureString,
    @required this.location,
    @required this.temperature,
    @required this.minTemperature,
    @required this.maxTemperature,
    @required this.unitString,
  });

  final String condition;
  final String temperatureString;
  final String location;
  final String unitString;
  final int temperature;
  final int minTemperature;
  final int maxTemperature;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: MediaQuery.of(context).size.width / 2.5,
      decoration: BoxDecoration(
        color: Colors.white12.withOpacity(0.1),
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            color: Colors.white54.withOpacity(0.2),
            child: Padding(
              padding: EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0),
              child: Text(
                '$LOCATION $location',
                style: kDefaultTextStyle.copyWith(fontSize: 20.0),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  WeatherCard(
                    cardTitle: TEMPERATURE,
                    content: Center(
                      child: RichText(
                        text: TextSpan(
                            text: '$temperature',
                            style: kDefaultTextStyle.copyWith(fontSize: 45.0),
                            children: <TextSpan>[
                              TextSpan(
                                text: unitString,
                                style:
                                    kDefaultTextStyle.copyWith(fontSize: 45.0),
                              )
                            ]),
                      ),
                    ),
                    footer: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white54.withOpacity(0.2),
                                borderRadius: BorderRadius.only(
                                    bottomLeft:
                                        Radius.circular(kCardBorderRadius))),
                            child: Center(
                              child: Text(
                                MIN,
                                style:
                                    kDefaultTextStyle.copyWith(fontSize: 15.0),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              '$minTemperature',
                              style: kDefaultTextStyle.copyWith(fontSize: 15.0),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white54.withOpacity(0.2),
                            ),
                            child: Center(
                              child: Text(
                                MAX,
                                style:
                                    kDefaultTextStyle.copyWith(fontSize: 15.0),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              '$maxTemperature',
                              style: kDefaultTextStyle.copyWith(fontSize: 15.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  WeatherCard(
                      cardTitle: CONDITION,
                      footer: Container(
                        child: Center(
                          child: Text(
                            '$condition',
                            textAlign: TextAlign.center,
                            style: kDefaultTextStyle.copyWith(fontSize: 15.0),
                          ),
                        ),
                      ),
                      content: Center(
                        child: Image.asset(
                          conditionImage[condition],
                          height: 60.0,
                          fit: BoxFit.fitHeight,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
