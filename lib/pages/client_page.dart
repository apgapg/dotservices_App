import 'package:dot_my_services/model/client_model.dart';
import 'package:dot_my_services/pages/category_page.dart';
import 'package:dot_my_services/pages/info_page.dart';
import 'package:dot_my_services/utils/app_utils.dart';
import 'package:dot_my_services/utils/top_level.dart';
import 'package:dot_my_services/widgets/border_container.dart';
import 'package:flutter/material.dart';

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
          ),
          SizedBox(
            width: 8,
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600),
            child: BorderContainer(
              margin: EdgeInsets.all(4),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                                        style: TextStyle(),
                                      ),
                                    ),
                                    if (checkIfNotEmpty(widget.item.address))
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          widget.item.address,
                                          style: TextStyle(),
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
                          Text(
                            "MOBILE",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "+91 -  ${widget.item.number}",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  onPhoneTap(widget.item.number);
                                },
                                elevation: 2,
                                focusElevation: 4,
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
      ),
    );
  }

  void onPhoneTap(String mobile) async {
    AppUtils.onPhoneTap(mobile);
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
