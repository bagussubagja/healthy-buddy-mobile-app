
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/foodies/food_articles_notifier.dart';

class FoodArticleScreen extends StatefulWidget {
  const FoodArticleScreen({super.key});

  @override
  State<FoodArticleScreen> createState() => _FoodArticleScreenState();
}

class _FoodArticleScreenState extends State<FoodArticleScreen> {
  final String _placeHolder =
      'https://i.ytimg.com/vi/uBBDMqZKagY/sddefault.jpg';

  @override
  void initState() {
    super.initState();
    final item = Provider.of<FoodArticlesClass>(context, listen: false);
    item.getFoodArticleData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Food Article',
          style: regularStyle.copyWith(color: blackColor, fontSize: 16.sp),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: blackColor,
          ),
        ),
      ),
      backgroundColor: bgColor,
      body: _bodyPart(),
    );
  }

  Widget _bodyPart() {
    final item = Provider.of<FoodArticlesClass>(context);
    return ListView.builder(
      itemCount: item.foodArticle?.length ?? 0,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {},
          child: SizedBox(
            height: 50.h,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: item.foodArticle?[index].thumbnail ?? _placeHolder,
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
                Container(
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Colors.grey.withOpacity(0.2),
                        Colors.black.withOpacity(0.7),
                      ],
                      stops: const [0.0, 1.0],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final url = Uri.parse(item.foodArticle![index].link!);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        item.foodArticle?[index].title ?? "Loading..",
                        textAlign: TextAlign.center,
                        style: regularStyle.copyWith(
                            fontSize: 16.sp, color: whiteColor),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
