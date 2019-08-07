import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dot_my_services/bloc/home_bloc.dart';
import 'package:dot_my_services/model/client_model.dart';
import 'package:dot_my_services/pages/client_page.dart';
import 'package:dot_my_services/utils/stream_error_widget.dart';
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
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: StreamBuilder(
          stream: bloc.dataStream,
          builder: (context, AsyncSnapshot<List<ClientItem>> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return ListView(
                padding: EdgeInsets.symmetric(
                  vertical: 4,
                ),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    height: 200,
                    child: StreamBuilder(
                      stream: bloc.advStream,
                      builder: (context,
                          AsyncSnapshot<List<Advertisement>> advSnapshot) {
                        if (advSnapshot.hasData && advSnapshot.data != null)
                          return Container(
                            child: CarouselSlider(
                                autoPlay: true,
                                height: 200.0,
                                viewportFraction: 0.8,
                                items: [
                                  ...advSnapshot.data.map(
                                    (Advertisement i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return GestureDetector(
                                            onTap: () {
                                              onClientTap(i.client);
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5.0),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              alignment: Alignment.center,
                                              child: CachedNetworkImage(
                                                imageUrl: i.image,
                                                placeholder: (context, url) =>
                                                    new CircularProgressIndicator(
                                                  strokeWidth: 1,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        new Icon(Icons.error),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ).toList(),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: Column(
                                          children: <Widget>[
                                            Icon(
                                              Icons.live_tv,
                                              size: 40,
                                              color: Colors.black54,
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                              "Your Advertisement\nHere",
                                              style: TextStyle(fontSize: 18),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                          mainAxisSize: MainAxisSize.min,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                          );
                        else if (advSnapshot.hasError) {
                          return StreamErrorWidget(advSnapshot.error, () {
                            bloc.fetchAdvData();
                          });
                        } else
                          return Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            ),
                          );
                      },
                    ),
                  ),
                  ...snapshot.data
                      .map((item) => ClientCard(item, () {
                            onClientTap(item);
                          }))
                      .toList(),
                ],
              );
            } else if (snapshot.hasError) {
              return StreamErrorWidget(snapshot.error, () {
                bloc.fetchData();
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
      MaterialPageRoute(
        builder: (context) => ClientPage(item),
      ),
    );
  }
}
