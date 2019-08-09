import 'package:dot_my_services/utils/my_icons.dart';
import 'package:flutter/material.dart';

class ServerErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onTap;

  ServerErrorWidget(this.message, this.onTap);

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
            SizedBox(
              height: 24,
            ),
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text(
                  "REFRESH",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700),
                ),
                onPressed: onTap),
          ],
        ),
      ),
    );
  }
}
