import 'package:flutter/material.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget(this.label, this.value, {Key? key}) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Text(
            this.label + ": ",
            style: TextStyle(
              fontSize: 20.0,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            this.value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          )
        ],
      ),
    );
  }
}
