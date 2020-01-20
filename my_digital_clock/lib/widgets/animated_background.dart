import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/clock_datetime.dart';
import '../constants.dart';

class AnimatedBackground extends StatefulWidget {
  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();

  AnimatedBackground({this.timeManager});

  final ClockDateTime timeManager;
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  AnimationController _controller;
  ClockDateTime time;

  Animation<Color> backgroundTopColor;
  Animation<Color> backgroundBottomColor;

  @override
  void initState() {
    super.initState();

    _controller = new AnimationController(
        duration: const Duration(hours: 24), vsync: this);

    _controller.forward(from: widget.timeManager.time.hour / 24);
    _controller.repeat(
      reverse: true,
    );

    backgroundTopColor = TweenSequence(<TweenSequenceItem<Color>>[
      TweenSequenceItem<Color>(
          tween: ConstantTween(
            kDarkNighColor,
          ),
          weight: kNightWeight / 2),
      TweenSequenceItem<Color>(
          tween: ColorTween(begin: kDarkNighColor, end: kDarkDayColor)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: kSunsetWeight),
      TweenSequenceItem<Color>(
          tween: ConstantTween(
            kDarkDayColor,
          ),
          weight: kDayWeight),
      TweenSequenceItem<Color>(
          tween: ColorTween(end: kDarkNighColor, begin: kDarkDayColor)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: kSunsetWeight),
      TweenSequenceItem<Color>(
          tween: ConstantTween(
            kDarkNighColor,
          ),
          weight: kNightWeight / 2),
    ]).animate(_controller);

    backgroundBottomColor = TweenSequence(<TweenSequenceItem<Color>>[
      TweenSequenceItem<Color>(
          tween: ConstantTween(
            kLightNighColor.withOpacity(kLightNighColorOpacity),
          ),
          weight: kNightWeight / 2),
      TweenSequenceItem<Color>(
          tween: ColorTween(
                  begin: kLightNighColor.withOpacity(kLightNighColorOpacity),
                  end: kSunsetColor.withOpacity(kSunsetColorOpacity))
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: kSunsetWeight / 2),
      TweenSequenceItem<Color>(
          tween: ColorTween(
                  begin: kSunsetColor.withOpacity(kSunsetColorOpacity),
                  end: kLightDayColor.withOpacity(kLightDayColorOpacity))
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: kSunsetWeight / 2),
      TweenSequenceItem<Color>(
          tween: ConstantTween(
            kLightDayColor.withOpacity(kLightDayColorOpacity),
          ),
          weight: kDayWeight),
      TweenSequenceItem<Color>(
          tween: ColorTween(
                  begin: kLightDayColor.withOpacity(kLightDayColorOpacity),
                  end: kSunsetColor.withOpacity(kSunsetColorOpacity))
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: kSunsetWeight / 2),
      TweenSequenceItem<Color>(
          tween: ColorTween(
            begin: kSunsetColor.withOpacity(kSunsetColorOpacity),
            end: kLightNighColor.withOpacity(kLightNighColorOpacity),
          ).chain(CurveTween(curve: Curves.easeOut)),
          weight: kSunsetWeight / 2),
      TweenSequenceItem<Color>(
          tween: ConstantTween(
            kLightNighColor.withOpacity(kLightNighColorOpacity),
          ),
          weight: kNightWeight / 2),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: Stack(children: <Widget>[
//      Container(
//        decoration: BoxDecoration(color: tweenColor1.value),
//      ),
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.2, 0.8],
          colors: [backgroundTopColor.value, backgroundBottomColor.value],
        )),
      ),
    ]));
  }
}
