import 'package:dot_my_services/utils/top_level.dart';
import 'package:flutter/material.dart';

class PrimaryRaisedButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  PrimaryRaisedButton({@required this.text, @required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      color: color ?? Colors.blue,
      textColor: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(
        checkIfNotEmpty(text) ? text : "NA",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        textAlign: TextAlign.center,
      ),
      onPressed: onTap,
    );
  }
}
