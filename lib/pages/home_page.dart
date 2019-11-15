import 'package:dot_my_services/bloc/home_bloc.dart';
import 'package:dot_my_services/model/client_model.dart';
import 'package:dot_my_services/pages/client_page.dart';
import 'package:dot_my_services/pages/info_page.dart';
import 'package:dot_my_services/pages/search_page.dart';
import 'package:dot_my_services/utils/stream_error_widget.dart';
import 'package:dot_my_services/widgets/circular_progress.dart';
import 'package:dot_my_services/widgets/client_card.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DOT Services",
        ),
        leading: Container(
          padding: EdgeInsets.symmetric(
            vertical: 8,
          ),
          margin: EdgeInsets.only(
            left: 16,
          ),
          child: Image.asset(
            "assets/images/logo.png",
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              onInfoTap();
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              onSearchTap();
            },
          ),
          SizedBox(
            width: 8,
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
                padding: EdgeInsets.symmetric(
                  vertical: 4,
                ),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    height:
                        MediaQuery.of(context).size.width >= 600 ? 300 : 200,
                    child: StreamBuilder(
                      stream: bloc.advStream,
                      builder: (context,
                          AsyncSnapshot<List<Advertisement>> advSnapshot) {
                        if (advSnapshot.hasData && advSnapshot.data != null)
                          return Container(
                            child: ListView(
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
                                                    alignment: Alignment.center,
                                                    child: Container(
                                                      child: CircularProgress(),
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
                                    width: MediaQuery.of(context).size.width >=
                                            600
                                        ? MediaQuery.of(context).size.width / 3
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
                            ),
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
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
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
                    ListView(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      shrinkWrap: true,
                      children: children
                          .map((item) => Container(
                                margin: EdgeInsets.symmetric(vertical: 4),
                                child: item,
                              ))
                          .toList(),
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
