import 'dart:async';

import 'package:ecommerce_shop_app/core/extensions/text_style_extension.dart';
import 'package:ecommerce_shop_app/core/res/styles/colors.dart';
import 'package:ecommerce_shop_app/core/res/styles/text.dart';
import 'package:flutter/material.dart';

class OTPTimer extends StatefulWidget {
  const OTPTimer({super.key, required this.email});

  final String email;

  @override
  State<OTPTimer> createState() => _OTPTimerState();
}

class _OTPTimerState extends State<OTPTimer> {
  int _mainDuration = 60;
  int _duration = 60;
  int increment = 30;

  Timer? _timer;

  bool canResend = false;
  bool resending = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        _duration--;
      });
      if (_duration == 0) {
        // if (_mainDuration > 60) increment;

        _mainDuration += increment;
        _duration = _mainDuration;

        timer.cancel();

        setState(() {
          canResend = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final minutes = _duration ~/ 60;
    final seconds = _duration.remainder(60);
    return Center(
      child: canResend
          ? resending
                ? CircularProgressIndicator.adaptive(
                    backgroundColor: MyColors.lightThemePrimaryColor,
                  )
                : TextButton(
                    onPressed: () async {
                      setState(() {
                        resending = true;
                      });
                      //TODO(Resend-OTP): Implement OTP resend
                      setState(() {
                        resending = false;
                      });
                      _startTimer();
                      setState(() {
                        canResend = false;
                      });
                    },
                    child: Text(
                      'Resend Code',
                      style: TextStyles.headingMedium4.primary,
                    ),
                  )
          : RichText(
              text: TextSpan(
                text: 'Resend code in ',
                style: TextStyles.headingMedium4.grey,
                children: [
                  TextSpan(
                    text: '$minutes: ${seconds.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      color: MyColors.lightThemePrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
