import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/top_article_model.dart';
import '../../../services/search_data_services/search_topArticle_service.dart';
import '../../../shared/assets_directory.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/margin_width.dart';

class SearchTopArticleResult extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context).copyWith(
          appBarTheme: super
              .appBarTheme(context)
              .appBarTheme
              .copyWith(elevation: 0.0, titleTextStyle: regularStyle),
        );
  }

  SearchTopArticle _searchTopArticle = SearchTopArticle();
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions

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
      child: FutureBuilder<List<TopArticleModel>>(
        future: _searchTopArticle.getTopArticle(query: query),
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
                  onTap: () async {
                    final url = Uri.parse(data![index].link);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
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
                            width: 30.h,
                            child: Text(
                              '${data?[index].title}',
                              style: regularStyle,
                            ),
                          ),
                          Text(
                            '${data?[index].description.substring(0, 25)}...',
                            style: regularStyle.copyWith(color: greyTextColor),
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
        "Coba cari 'Anxiety'...",
        style: regularStyle,
      ),
    );
  }
}
