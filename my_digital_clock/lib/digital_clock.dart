// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';
import 'dart:ui';

import 'package:analog_clock/widgets/custom_painters/gauge_painter.dart';
import 'package:analog_clock/widgets/particles.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';

import 'widgets/custom_painters/gauge_painter.dart';
import 'models/clock_datetime.dart';
import 'widgets/animated_background.dart';
import 'widgets/weather_info.dart';
import 'widgets/time_render.dart';
import 'widgets/day_report.dart';

class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock>
    with TickerProviderStateMixin {
  AnimationController _controller;
  ClockDateTime timeManager;

  var _temperature;
  var _temperatureString;
  var _minTemperature;
  var _maxTemperature;
  var _condition = '';
  var _location = '';
  var _unitString = '';

  @override
  void initState() {
    super.initState();

    timeManager = ClockDateTime(is24HourFormat: widget.model.is24HourFormat);
    widget.model.addListener(_updateModel);
    // Set the initial values.
    _updateModel();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    timeManager.addListener(_updateAnimation);
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperature;
      _temperatureString = widget.model.temperatureString;
      _minTemperature = widget.model.low;
      _maxTemperature = widget.model.high;
      _condition = widget.model.weatherString;
      _location = widget.model.location;
      _unitString = widget.model.unitString;
    });
  }

  void _updateAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // There are many ways to apply themes to your clock. Some are:
    //  - Inherit the parent Theme (see ClockCustomizer in the
    //    flutter_clock_helper package).
    //  - Override the Theme.of(context).colorScheme.
    //  - Create your own [ThemeData], demonstrated in [AnalogClock].
    //  - Create a map of [Color]s to custom keys, demonstrated in
    //    [DigitalClock].
    final customTheme = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).copyWith(
            // Text
            primaryColor: Colors.white,
            // Particles
            highlightColor: Color(0xFFFFFF00),
            // Second hand.
            accentColor: Color(0xFF00FF00),
            backgroundColor: Color(0xFF000000),
          )
        : Theme.of(context).copyWith(
            primaryColor: Color(0xFFD2E3FC),
            highlightColor: Color(0xFF4285F4),
            accentColor: Color(0xFF8AB4F8),
            backgroundColor: Color(0xFF3C4043),
          );

    final time = DateFormat.Hms().format(DateTime.now());

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, widget) {
        return Semantics.fromProperties(
          properties: SemanticsProperties(
            label: 'Analog clock with time $time',
            value: time,
          ),
          child: Container(
            color: customTheme.backgroundColor,
            child: Stack(
              children: [
                AnimatedBackground(
                  timeManager: timeManager,
                ),
                Center(child: SizedBox.expand(child: Particles())),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: double.infinity,
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: CustomPaint(
                      foregroundPainter: GaugePainter(
                          animation: _controller,
                          time: timeManager.time,
                          temperature: _temperature),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 60.0),
                    child: TimeRender(
                      timeString: timeManager.timeString,
                      timeSeconds: timeManager.secondsString,
                      timePeriod: timeManager.periodString,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: DayReport(
                    dayNumber: timeManager.time.day,
                    monthString: timeManager.month,
                    dayOfTheWeekString: timeManager.dayOfTheWeek,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: WeatherInfo(
                    condition: _condition,
                    temperatureString: _temperatureString,
                    maxTemperature: _maxTemperature,
                    minTemperature: _minTemperature,
                    temperature: _temperature,
                    location: _location,
                    unitString: _unitString,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
