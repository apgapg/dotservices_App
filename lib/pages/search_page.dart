import 'package:dot_my_services/bloc/search_bloc.dart';
import 'package:dot_my_services/model/client_model.dart';
import 'package:dot_my_services/pages/category_page.dart';
import 'package:dot_my_services/utils/stream_error_widget.dart';
import 'package:dot_my_services/widgets/no_items_found.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = SearchBloc();

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
          "Search",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
        stream: bloc.dataStream,
        builder: (context, AsyncSnapshot<List<Category>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            var list = snapshot.data;
            if (list.length > 0) {
              return GridView(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2.5),
                children: <Widget>[
                  ...list
                      .map(
                        (category) => InkWell(
                          onTap: () {
                            onCategoryTap(category, context);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.blueGrey[50],
                            ),
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              child: Text(
                                category.category,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ],
              );
            } else {
              return NoItemsFound();
            }
          } else if (snapshot.hasError) {
            return StreamErrorWidget(snapshot.error, () {
              bloc.fetchData();
            });
          } else
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
              ),
            );
        },
      ),
    );
  }

  void onCategoryTap(Category category, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CategoryPage(category)));
  }
}
