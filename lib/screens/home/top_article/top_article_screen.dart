import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/extras/top_article_notifier.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../shared/assets_directory.dart';
import '../../widgets/loading_widget.dart';

class TopArticleScreen extends StatefulWidget {
  const TopArticleScreen({super.key});

  @override
  State<TopArticleScreen> createState() => _TopArticleScreenState();
}

class _TopArticleScreenState extends State<TopArticleScreen> {
  @override
  void initState() {
    super.initState();
    final itemArticle = Provider.of<TopArticleClass>(context, listen: false);
    itemArticle.getArticle(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: blackColor,
            )),
      ),
      body: SafeArea(
          child: Padding(
        padding: defaultPadding,
        child: ListView(
          children: [
            _topSection(),
            MarginHeight(height: 2.h),
            _topArticle(context)
          ],
        ),
      )),
    );
  }

  Widget _topSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Article',
          style: titleStyle.copyWith(color: greenColor),
        ),
        Text(
          'Healthy Buddy - Berikan yang terbaik untuk kamu!',
          style: regularStyle.copyWith(color: greyTextColor),
        )
      ],
    );
  }

  Widget _topArticle(BuildContext context) {
    final item = Provider.of<TopArticleClass>(context);
    return Column(
      children: [
        item.isLoading == true
            ? LoadingWidget()
            : SizedBox(
                width: double.infinity,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return MarginHeight(height: 2.h);
                  },
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: item.articles?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      tileColor: whiteColor,
                      onTap: () async {
                        final url = Uri.parse(item.articles![index].link);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        }
                      },
                      leading: SizedBox(
                        height: 12.h,
                        width: 12.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: item.articles?[index].thumbnail ??
                                imgPlaceHolder,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) => const Center(
                              child: Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      title: Text(item.articles?[index].title ?? "Loading"),
                      subtitle: Text(
                          '${item.articles?[index].description.substring(0, 40)}...'),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
