import 'package:dot_my_services/model/client_model.dart';
import 'package:dot_my_services/pages/category_page.dart';
import 'package:dot_my_services/widgets/border_container.dart';
import 'package:flutter/material.dart';

class ClientCard extends StatelessWidget {
  final ClientItem item;
  final VoidCallback onTap;

  ClientCard(this.item, this.onTap);

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      item.description,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.green,
                          size: 22,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          item.areas.map((area) => area.area).join(", "),
                          style: TextStyle(
                              fontSize: 14,
                              color:
                                  Theme.of(context).textTheme.display1.color),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Wrap(
                            children: <Widget>[
                              for (Category category in item.categories)
                                InkWell(
                                  onTap: () {
                                    onCategoryTap(category, context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.blueGrey[50],
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
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          child: Icon(Icons.keyboard_arrow_right),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              /*Positioned(
                right: 0,
                bottom: 0,
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.phone,size: 20,color: Colors.blueAccent,),
                  onPressed: (){

                  },
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }

  void onCategoryTap(Category category, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CategoryPage(category)));
  }
}
