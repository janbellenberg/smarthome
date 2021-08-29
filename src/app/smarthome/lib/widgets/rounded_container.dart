import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer(
      {Key? key,
      required this.child,
      this.width = double.infinity,
      this.margin = const EdgeInsets.all(30.0),
      this.padding = const EdgeInsets.only(
          top: 30.0, bottom: 30.0, left: 20.0, right: 20.0)})
      : super(key: key);

  final Widget child;
  final double width;
  final EdgeInsets margin;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      padding: padding,
      child: this.child,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).accentColor.withOpacity(0.3),
            Theme.of(context).accentColor.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Theme.of(context).backgroundColor,
      ),
    );
  }
}
