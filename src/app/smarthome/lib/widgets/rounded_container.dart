import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    Key? key,
    required this.child,
    this.width,
    this.margin,
    this.padding,
    this.color,
  }) : super(key: key);

  final Widget? child;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? color;

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
        color: this.color ??
            Theme.of(context).colorScheme.secondary.withOpacity(0.15),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
    );
  }
}
