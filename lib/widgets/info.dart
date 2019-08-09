import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  final String message;
  final bool showIcon;

  InfoWidget(this.message, {this.showIcon = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (showIcon)
            Icon(
              Icons.info_outline,
              color:
                  Theme.of(context).textTheme.display1.color.withOpacity(0.5),
              size: 22,
            ),
          if (showIcon)
            SizedBox(
              width: 8.0,
            ),
          Flexible(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).textTheme.display1.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
