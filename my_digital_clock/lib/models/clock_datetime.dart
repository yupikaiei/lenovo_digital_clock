import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockDateTime extends ChangeNotifier {
  DateTime _now = DateTime.now();
  final DateFormat _seconds = new DateFormat('ss');
  final DateFormat _period = new DateFormat('a');
  final DateFormat _monthString = new DateFormat('MMMM');
  final DateFormat _dayOfTheWeekString = new DateFormat('EEEE');
  final is24HourFormat;
  DateFormat _dateFormat;

  ClockDateTime({@required this.is24HourFormat = false}) {
    this._dateFormat =
        is24HourFormat ? new DateFormat('HH:mm') : new DateFormat('hh:mm a');
    _updateTime();
  }

  void _updateTime() {
    _now = DateTime.now();
    notifyListeners();
    // Update once per second. Make sure to do it at the beginning of each
    // new second, so that the clock is accurate.
    Timer(
      Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
      _updateTime,
    );
  }

  DateTime get time => _now;
  String get periodString => is24HourFormat ? '' : _period.format(_now);
  String get secondsString => _seconds.format(_now);
  String get timeString => _dateFormat.format(_now);
  String get month => _monthString.format(_now);
  String get dayOfTheWeek => _dayOfTheWeekString.format(_now);
  String get remainingTime => _dayOfTheWeekString.format(_now);
}
