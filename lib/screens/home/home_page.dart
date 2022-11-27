import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cache_manager/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/authentication/user_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/extras/top_article_notifier.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/screens/home/top_article/toparticle_result.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/custom_textfield.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/loading_widget.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_width.dart';
import 'package:healthy_buddy_mobile_app/services/search_data_services/search_topArticle_service.dart';
import 'package:healthy_buddy_mobile_app/shared/assets_directory.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/authentication/auth_notifier.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _emoticon = [
    'angry.png',
    'happy.png',
    'sad.png',
  ];

  final List<String> _emotionTitle = [
    'Marah',
    'Bahagia',
    'Sedih',
  ];

  final List<String> _categoryIcon = [
    'foodies.png',
    'sport.png',
    'mydoc.png',
    'top-up.png'
  ];

  final List<String> _categoryLabel = ['Foodies', 'Sport', 'MyDoc', 'Top Up'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final item = Provider.of<TopArticleClass>(context, listen: false);
    item.getArticle(context: context);
    final user = Provider.of<UserClass>(context, listen: false);
    ReadCache.getString(key: 'cache').then((value) {
      setState(() {
        user.getUser(context: context, idUser: value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationNotifier authenticationNotifier =
        Provider.of<AuthenticationNotifier>(context, listen: false);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: greenColor,
        appBar: AppBar(
          backgroundColor: greenColor,
          elevation: 0,
          actions: [
            PopupMenuButton(
                elevation: 0,
                icon: const Icon(Icons.more_horiz_rounded),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                color: bgColor,
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: GestureDetector(
                          onTap: () async {
                            DeleteCache.deleteKey(
                                "cache",
                                Navigator.pushNamedAndRemoveUntil(context,
                                    AppRoutes.loginScreen, (route) => false));

                            await authenticationNotifier.logOut();
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.exit_to_app,
                                color: greyTextColor,
                              ),
                              Text(
                                'Log Out',
                                style: regularStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ])
          ],
        ),
        drawer: _drawer(),
        body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              MarginHeight(height: 15),
              Padding(
                padding: defaultPadding,
                child: _headerIdentity(),
              ),
              Padding(
                padding: defaultPadding,
                child: CustomTextField(
                  color: bgColor,
                  onTap: () {
                    showSearch(
                        context: context, delegate: SearchTopArticleResult());
                  },
                  readOnly: true,
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  hintText: "Cari artikel terhangat disini...",
                ),
              ),
              Padding(
                padding: defaultPadding,
                child: _emotionFeeling(),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                    color: bgColor),
                child: Padding(
                  padding: defaultPadding,
                  child: _whiteSection(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _whiteSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kategori',
          style: titleStyle.copyWith(color: greenColor),
        ),
        MarginHeight(height: 2.5.h),
        SizedBox(
          height: 12.h,
          width: double.infinity,
          child: Center(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return MarginWidth(width: 10.w);
              },
              itemCount: _categoryLabel.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          Navigator.pushNamed(context, AppRoutes.foodiesScreen);
                        } else if (index == 1) {
                          Navigator.pushNamed(context, AppRoutes.sportScreen);
                        } else if (index == 2) {
                          Navigator.pushNamed(context, AppRoutes.myDocScreen);
                        } else if (index == 3) {
                          Navigator.pushNamed(context, AppRoutes.topUpScreen);
                        }
                      },
                      child: Container(
                        height: 7.h,
                        decoration: BoxDecoration(
                          color: greenColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          '$imageDirectory/${_categoryIcon[index]}',
                          scale: 1.5.h,
                        ),
                      ),
                    ),
                    Text(
                      _categoryLabel[index],
                      style: regularStyle,
                    )
                  ],
                );
              },
            ),
          ),
        ),
        MarginHeight(height: 1.h),
        _topArticle(context)
      ],
    );
  }

  Widget _emotionFeeling() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Apa Perasaan Kamu Hari Ini?',
          style: regularStyle.copyWith(color: Colors.white),
        ),
        MarginHeight(height: 10),
        SizedBox(
          height: 14.h,
          width: double.infinity,
          child: Center(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return MarginWidth(width: 10.w);
              },
              itemCount: _emoticon.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: greenDarkerColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Image.asset('$imageDirectory/${_emoticon[index]}',
                          scale: 2.h),
                    ),
                    Text(
                      _emotionTitle[index],
                      style: regularStyle.copyWith(color: Colors.white),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _headerIdentity() {
    final user = Provider.of<UserClass>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Howdy,',
              style: regularStyle.copyWith(color: Colors.white),
            ),
            Text(
              user.users?[0].name ?? "Loading...",
              style: titleStyle.copyWith(color: Colors.white),
            )
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            height: 50,
            width: 50,
            child: user.users?[0].gender == "Laki-laki"
                ? Image.asset(
                    '$imageDirectory/ava1.png',
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    '$imageDirectory/ava2.png',
                    fit: BoxFit.cover,
                  ),
          ),
        )
      ],
    );
  }

  Widget _topArticle(BuildContext context) {
    final item = Provider.of<TopArticleClass>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Top Article',
              style: titleStyle.copyWith(color: greenColor),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.topArticleScreen);
                },
                child: Text(
                  'Lihat Semua',
                  style: regularStyle.copyWith(color: Colors.grey),
                ))
          ],
        ),
        item.isLoading == true
            ? LoadingWidget()
            : SizedBox(
                width: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: item.articles?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      tileColor: greyColor,
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

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: greenColor,
            ),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Healthy Buddy',
                  style: regularStyle.copyWith(color: whiteColor),
                )),
          ),
          ListTile(
            leading: const Icon(
              Icons.supervised_user_circle_outlined,
            ),
            title: Text(
              'Tentang Kami',
              style: regularStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.aboutUsScreen);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.help_center_outlined,
            ),
            title: Text(
              'Pusat Bantuan',
              style: regularStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.helpCenterScreen);
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
