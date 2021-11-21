import 'package:Smarthome/constants/colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Navigation extends StatelessWidget {
  const Navigation({
    required this.onSelectedChanged,
    required this.currentIndex,
    Key? key,
  }) : super(key: key);

  final Function(int) onSelectedChanged;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 5.0,
        ),
        child: SalomonBottomBar(
          currentIndex: this.currentIndex,
          onTap: onSelectedChanged,
          items: [
            SalomonBottomBarItem(
              icon: Icon(Icons.home_outlined),
              title: Text("Home"),
              selectedColor: ACCENT,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.add_box_outlined),
              title: Text("Gerät hinzufügen"),
              selectedColor: ACCENT,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.list_alt),
              title: Text("Shortcuts"),
              selectedColor: ACCENT,
            ),
          ],
        ),
      ),
    );
  }
}
