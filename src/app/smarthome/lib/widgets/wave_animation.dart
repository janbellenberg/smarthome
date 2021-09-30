import 'package:Smarthome/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaveAnimation extends StatelessWidget {
  const WaveAnimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: WaveWidget(
        config: CustomConfig(
          gradients: [
            [
              Theme.of(context).colorScheme.secondary.withAlpha(175),
              Theme.of(context).colorScheme.secondary.withAlpha(175)
            ],
            [
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.secondary
            ],
            [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary
            ],
            [Theme.of(context).colorScheme.primary, GRAY],
          ],
          durations: [35000, 20000, 15000, 20000],
          heightPercentages: [0.20, 0.30, 0.40, 0.65],
          gradientBegin: Alignment.bottomCenter,
          gradientEnd: Alignment.topCenter,
        ),
        size: Size(
          double.infinity,
          200,
        ),
      ),
    );
  }
}
