import 'package:dot_my_services/utils/screen_utils.dart';
import 'package:flutter/material.dart';

class MyRaisedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData icon;

  MyRaisedButton({this.onPressed, this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isSmallScreen(context)
          ? IconButton(
              icon: Icon(icon),
              onPressed: onPressed,
            )
          : FlatButton.icon(
              icon: Icon(icon),
              label: Text(text),
              onPressed: onPressed,
            ),
    );
  }
}
