import 'package:dot_my_services/model/client_model.dart';
import 'package:dot_my_services/pages/category_page.dart';
import 'package:dot_my_services/pages/info_page.dart';
import 'package:dot_my_services/utils/toast_utils.dart';
import 'package:dot_my_services/utils/top_level.dart';
import 'package:dot_my_services/widgets/border_container.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientPage extends StatefulWidget {
  final ClientItem item;

  ClientPage(this.item);

  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details",
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              onInfoTap();
            },
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          child: BorderContainer(
            margin: EdgeInsets.all(4),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.item.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          widget.item.description,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Divider(),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "CATEGORY",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              fit: FlexFit.tight,
                              flex: 1,
                              child: Wrap(
                                children: <Widget>[
                                  for (Category category
                                      in widget.item.categories)
                                    InkWell(
                                      onTap: () {
                                        onCategoryTap(category, context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Theme.of(context)
                                              .chipTheme
                                              .backgroundColor,
                                        ),
                                        child: Text(
                                          category.category,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                                spacing: 8,
                                runSpacing: 8,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Divider(),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "ADDRESS",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              fit: FlexFit.tight,
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      widget.item.areas
                                          .map((area) => area.area)
                                          .join(", "),
                                      style: TextStyle(color: Colors.grey[800]),
                                    ),
                                  ),
                                  if (checkIfNotEmpty(widget.item.address))
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        widget.item.address,
                                        style: TextStyle(
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            FloatingActionButton(
                              mini: true,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 24,
                              ),
                              backgroundColor: Colors.green,
                              onPressed: () {},
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Divider(),
                        SizedBox(
                          height: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () {
                                onPhoneTap(widget.item.number);
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
                                    "CONTACT",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              color: Colors.blueAccent,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onPhoneTap(String mobile) async {
    var url = 'tel:$mobile';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ToastUtils.showToast(message: 'Couldnt call');
    }
  }

  void onInfoTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InfoPage(),
      ),
    );
  }

  void onCategoryTap(Category category, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CategoryPage(category)));
  }
}
