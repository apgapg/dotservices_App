import 'package:dot_my_services/utils/constants.dart';
import 'package:dot_my_services/utils/my_icons.dart';
import 'package:dot_my_services/widgets/primary_raised_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InternetNotAvailable extends StatelessWidget {
  final VoidCallback onTap;

  InternetNotAvailable(this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
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
            Text(
              Constants.ERROR_NETWORK_NOT_AVAILABLE,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.display1.copyWith(
                    fontSize: 18,
                  ),
            ),
            SizedBox(
              height: 24,
            ),
            PrimaryRaisedButton(text: "REFRESH", onTap: onTap),
          ],
        ),
      ),
    );
  }
}
