import 'package:dot_my_services/utils/my_icons.dart';
import 'package:flutter/material.dart';

class ServerErrorWidget extends StatelessWidget {
  final String message;

  ///A widget to show an error returned from server api
  ///
  ///Use only when you want to display unknown error like 500 etc
  ServerErrorWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              MyIcons.cloud_computing,
              size: 86,
              color: Colors.grey.withOpacity(0.9),
            ),
            SizedBox(
              height: 24,
            ),
            new Text(
              message,
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
