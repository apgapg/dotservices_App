import 'package:dot_my_services/bloc/home_bloc.dart';
import 'package:dot_my_services/model/client_model.dart';
import 'package:dot_my_services/pages/client_page.dart';
import 'package:dot_my_services/pages/info_page.dart';
import 'package:dot_my_services/pages/search_page.dart';
import 'package:dot_my_services/utils/app_utils.dart';
import 'package:dot_my_services/utils/screen_utils.dart';
import 'package:dot_my_services/utils/stream_error_widget.dart';
import 'package:dot_my_services/widgets/circular_progress.dart';
import 'package:dot_my_services/widgets/client_card.dart';
import 'package:dot_my_services/widgets/my_raised_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bloc = HomeBloc();

  @override
  void initState() {
    super.initState();
    bloc.initData();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  margin: EdgeInsets.only(
                    left: isLargeScreen(context) ? 56 : 16,
                    right: 12,
                  ),
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: 40,
                  ),
                ),
                Text(
                  "DOT Services",
                  style: TextStyle(),
                ),
              ],
            ),
            actions: <Widget>[
              MyRaisedButton(
                icon: (Icons.info_outline),
                text: "About Us",
                onPressed: () {
                  onInfoTap();
                },
              ),
              MyRaisedButton(
                icon: (Icons.search),
                text: ("Search"),
                onPressed: () {
                  onSearchTap();
                },
              ),
              SizedBox(
                width: isLargeScreen(context) ? 64 : 16,
              ),
            ],
          ),
          body: Container(
            child: StreamBuilder(
              stream: bloc.dataStream,
              builder: (context, AsyncSnapshot<List<ClientItem>> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  var children = snapshot.data
                      .map((item) => ClientCard(item, () {
                            onClientTap(item);
                          }))
                      .toList();
                  return ListView(
                    children: <Widget>[
                      if (kIsWeb)
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/cover.jpg',
                                  fit: BoxFit.cover,
                                  height: 350,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "Find Quality Experts near you",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 36,
                                    color: Colors.white,
                                    letterSpacing: 1.7,
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/images/logo.png",
                                      height: 52,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "DOT Services",
                                      style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 16,
                              child: Text(
                                "Find Plumbers, Mechanics, Carpenters, AC Repair and many other quality experts ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white.withOpacity(0.94),
                                    letterSpacing: 1.2),
                              ),
                            ),
                          ],
                        ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        height: MediaQuery.of(context).size.width >= 600
                            ? 300
                            : 200,
                        child: StreamBuilder(
                          stream: bloc.advStream,
                          builder: (context,
                              AsyncSnapshot<List<Advertisement>> advSnapshot) {
                            if (advSnapshot.hasData && advSnapshot.data != null)
                              return ListView(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                scrollDirection: Axis.horizontal,
                                children: [
                                  ...advSnapshot.data.map(
                                    (Advertisement i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return GestureDetector(
                                            onTap: () {
                                              if (i.client != null)
                                                onClientTap(i.client);
                                              else
                                                onInfoTap();
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              alignment: Alignment.center,
                                              /*child: CachedNetworkImage(
                                                  imageUrl: i.image,
                                                  placeholder: (context, url) =>
                                                      new CircularProgressIndicator(
                                                    strokeWidth: 1,
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          new Icon(Icons.error),
                                                ),*/
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(4),
                                                ),
                                                child: Image.network(
                                                  i.image,
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent
                                                              loadingProgress) {
                                                    if (loadingProgress == null)
                                                      return child;
                                                    return Container(
                                                      width: 300,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Container(
                                                        child:
                                                            CircularProgress(),
                                                      ),
                                                    );
                                                  },
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ).toList(),
                                  InkWell(
                                    onTap: () {
                                      onInfoTap();
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context)
                                                  .size
                                                  .width >=
                                              600
                                          ? MediaQuery.of(context).size.width /
                                              3
                                          : 300,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              Icons.live_tv,
                                              size: 40,
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Text(
                                              "Advertise here\n\nKNOW MORE >",
                                              style: TextStyle(fontSize: 16),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                          mainAxisSize: MainAxisSize.min,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            else if (advSnapshot.hasError) {
                              return StreamErrorWidget(
                                advSnapshot.error,
                                () {
                                  bloc.initData();
                                },
                              );
                            } else
                              return Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                ),
                              );
                          },
                        ),
                      ),
                      if (MediaQuery.of(context).size.width >= 600)
                        GridView(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 320,
                            childAspectRatio: 1.4,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          children: <Widget>[
                            ...snapshot.data
                                .map((item) => ClientCard(item, () {
                                      onClientTap(item);
                                    }))
                                .toList(),
                          ],
                        )
                      else
                        ...children
                            .map((item) => Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 8),
                                  child: item,
                                ))
                            .toList(),
                      if (kIsWeb)
                        Container(
                          height: 80,
                          color: Colors.black87,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Row(
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/images/logo.png",
                                    height: 40,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "DOT Services",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Text(
                                      "© 2019. All Rights Reserved",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        "Visit Us: ",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ),
                                    Theme(
                                      data: ThemeData(
                                        brightness: Brightness.dark,
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        type: MaterialType.circle,
                                        child: IconButton(
                                          icon: Icon(
                                            FontAwesomeIcons.facebook,
                                          ),
                                          color: Colors.white70,
                                          onPressed: () {
                                            AppUtils.onFbTap();
                                          },
                                        ),
                                      ),
                                    ),
                                    Theme(
                                      data: ThemeData(
                                        brightness: Brightness.dark,
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        type: MaterialType.circle,
                                        child: IconButton(
                                          icon: Icon(
                                            FontAwesomeIcons.instagram,
                                          ),
                                          color: Colors.white70,
                                          onPressed: () {
                                            AppUtils.onInstagramTap();
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 16),
                                child: InkWell(
                                  child: Image.asset(
                                      'assets/images/playstore.jpg'),
                                  onTap: () {
                                    AppUtils.onPlaystoreTap();
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return StreamErrorWidget(snapshot.error, () {
                    bloc.initData();
                  });
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 1,
                  ));
                }
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  void onClientTap(ClientItem item) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, a1, a2) => ClientPage(item),
      ),
    );
  }

  void onInfoTap() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, a1, a2) => InfoPage(),
      ),
    );
  }

  void onSearchTap() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, a1, a2) => SearchPage(),
      ),
    );
  }
}
