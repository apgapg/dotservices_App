import 'package:dot_my_services/utils/app_utils.dart';
import 'package:dot_my_services/widgets/border_container.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DOT Services",
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600),
                child: BorderContainer(
                  margin: EdgeInsets.all(4),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          "Connect with us",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "For advertisement or listing, kindly register with your details below.\n\n*Please note we only list service providers. Connect only if you can provide consumer services in any form.",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          softWrap: true,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        // https://forms.gle/AMK412nHZUdHP7Nd9
                        Divider(),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "REGISTER BELOW",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        RaisedButton(
                          onPressed: () {
                            AppUtils.onFormTap();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.person_add,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "REGISTER ON APP",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          color: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),

                        SizedBox(
                          height: 12,
                        ),
                        Divider(),
                        SizedBox(
                          height: 8,
                        ),

                        Text(
                          "CONTACT US",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Email: dotappservices@gmail.com",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                          softWrap: true,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        RaisedButton(
                          onPressed: () {
                            AppUtils.onMailTap();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.mail,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "MAIL US",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          color: Colors.green,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Mobile: +91-8218135689",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                          softWrap: true,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        RaisedButton(
                          onPressed: () {
                            AppUtils.onPhoneTap("8218135689");
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "CALL US",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          color: Colors.deepOrangeAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
