import 'package:dot_my_services/bloc/category_bloc.dart';
import 'package:dot_my_services/model/client_model.dart';
import 'package:dot_my_services/pages/client_page.dart';
import 'package:dot_my_services/utils/stream_error_widget.dart';
import 'package:dot_my_services/widgets/client_card.dart';
import 'package:dot_my_services/widgets/info.dart';
import 'package:dot_my_services/widgets/no_items_found.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  final Category categoryItem;

  CategoryPage(this.categoryItem);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  CategoryBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = CategoryBloc(widget.categoryItem);
    bloc.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryItem.category,
        ),
      ),
      body: Container(
        child: StreamBuilder(
          stream: bloc.dataStream,
          builder: (context, AsyncSnapshot<List<ClientItem>> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              var list = snapshot.data;
              if (list.length > 0) {
                return ListView(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  children: <Widget>[
                    InfoWidget(
                        "Showing all with '${widget.categoryItem.category}' category"),
                    ...list
                        .map(
                          (item) => Container(
                            margin: EdgeInsets.symmetric(vertical: 4),
                            child: ClientCard(
                              item,
                              () {
                                onClientTap(item);
                              },
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
      ),
    );
  }

  void onClientTap(ClientItem item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ClientPage(item),
      ),
    );
  }
}
