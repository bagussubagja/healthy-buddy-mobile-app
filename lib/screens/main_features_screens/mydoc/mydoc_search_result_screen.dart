import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/mydoc_model/mydoc_model.dart';
import 'package:healthy_buddy_mobile_app/services/search_data_services/search_toparticle_service.dart';
import 'package:sizer/sizer.dart';

import '../../../shared/assets_directory.dart';
import '../../../shared/theme.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/margin_width.dart';

class MyDocSearchResultScreen extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          backgroundColor: bgColor,
          appBarTheme: super
              .appBarTheme(context)
              .appBarTheme
              .copyWith(elevation: 0.0, titleTextStyle: regularStyle),
        );
  }

  final SearchMyDoc _searchMyDoc = SearchMyDoc();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(
            Icons.close,
            color: blackColor,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: blackColor,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Padding(
      padding: defaultPadding,
      child: FutureBuilder<List<MyDocModel>>(
        future: _searchMyDoc.getMyDocSearchData(query: query),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (!snapshot.hasData) {
            return LoadingWidget();
          }
          return ListView.builder(
            itemCount: data?.length ?? 0,
            itemBuilder: (context, index) {
              return Card(
                elevation: 0,
                child: ListTile(
                  title: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          height: 8.h,
                          width: 8.h,
                          child: Image.network(
                            data?[index].thumbnail ?? imgPlaceHolder,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      MarginWidth(width: 5.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 25.h,
                            child: Text(
                              '${data?[index].name}',
                              style: regularStyle,
                            ),
                          ),
                          SizedBox(
                            width: 25.h,
                            child: Text(
                              '${data?[index].description.substring(0, 25)}...',
                              style:
                                  regularStyle.copyWith(color: greyTextColor),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text(
        "Coba cari 'Mental Health'...",
        style: regularStyle,
      ),
    );
  }
}
