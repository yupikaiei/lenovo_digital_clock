import 'package:flutter/material.dart';

// Background Time colors
const Color kSunsetColor = Colors.deepOrange;
const double kSunsetColorOpacity = 0.7;

const Color kDarkNighColor = Colors.black38;
const Color kLightNighColor = Colors.deepPurple;
const double kLightNighColorOpacity = 0.3;

const Color kDarkDayColor = Colors.blueAccent;
const Color kLightDayColor = Colors.lightBlueAccent;
const double kLightDayColorOpacity = 0.8;

const double kSunsetWeight = 10.0;
const double kDayWeight = 40.0;
const double kNightWeight = 40.0;

// Particles
const int kNumberOfParticles = 150;
const Color kParticleColor = Colors.amber;
const double kMaxParticleSize = 1.0;

// Digital Clock
const double kTimeFontSize = 155.0;
const double kTimeExtraFontSize = 50.0;
// Padding between time and extra time info
const double kTimePaddingBetween = 15.0;

// Day Report
const double kDayNumberTextSize = 100.0;

// Temperature Colors
const Color kMaxTemperatureColor = Colors.red;
const Color kMinTemperatureColor = Colors.cyan;

// TextStyles
const TextStyle kDefaultTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'Orbitron');

// Weather Card
const double kCardSize = 200.0;
const double kFooterSize = 35.0;
const double kCardBorderRadius = 10.0;

// Condition
const conditionImage = {
  'cloudy': 'assets/images/cloudy.png',
  'foggy': 'assets/images/foggy.png',
  'rainy': 'assets/images/rainy.png',
  'snowy': 'assets/images/snowy.png',
  'sunny': 'assets/images/sunny.png',
  'thunderstorm': 'assets/images/thunderstorm.png',
  'windy': 'assets/images/windy.png',
};

// Text
const String DAY = "Day:";
const String MONTH = "Month:";
const String WEATHER_REPORT = "Weather Report";
const String LOCATION = "Location: ";
const String TEMPERATURE = "Temperature";
const String CONDITION = "Condition";
const String MIN = "Min:";
const String MAX = "Max:";
