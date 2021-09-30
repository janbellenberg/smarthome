import 'package:Smarthome/constants/colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  const Navigation({
    required this.onSelectedChanged,
    Key? key,
  }) : super(key: key);

  final Function(int) onSelectedChanged;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
        color: Theme.of(context).colorScheme.secondary,
        backgroundColor: Theme.of(context).colorScheme.background,
        height: 60,
        items: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.home_outlined, size: 30, color: WHITE),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.add_box_outlined, size: 30, color: WHITE),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.list_alt, size: 30, color: WHITE),
          ),
        ],
        onTap: onSelectedChanged);
  }
}
