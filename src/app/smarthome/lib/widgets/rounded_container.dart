import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    Key? key,
    required this.child,
    this.width,
    this.margin,
    this.padding,
    this.gradient,
  }) : super(key: key);

  final Widget? child;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      margin: margin ?? const EdgeInsets.all(30.0),
      padding: padding ??
          const EdgeInsets.only(
            top: 30.0,
            bottom: 30.0,
            left: 20.0,
            right: 20.0,
          ),
      child: this.child,
      decoration: BoxDecoration(
        gradient: this.gradient ??
            LinearGradient(
              colors: [
                Theme.of(context).accentColor.withOpacity(0.3),
                Theme.of(context).accentColor.withOpacity(0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
    );
  }
}
