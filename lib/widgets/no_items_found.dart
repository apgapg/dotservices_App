import 'package:dot_my_services/utils/my_icons.dart';
import 'package:dot_my_services/utils/top_level.dart';
import 'package:flutter/material.dart';

class NoItemsFound extends StatelessWidget {
  final String text;

  NoItemsFound({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              MyIcons.inbox_mail_empty_tray,
              size: 86,
              color: Colors.grey.withOpacity(0.9),
            ),
            SizedBox(
              height: 24,
            ),
            new Text(
              checkIfNotEmpty(text) ? text : "No items found",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.display1.copyWith(
                    fontSize: 20,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
