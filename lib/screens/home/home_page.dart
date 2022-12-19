import 'package:cache_manager/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthy_buddy_mobile_app/core/authentication/user_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/extras/top_article_notifier.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/screens/home/top_article/toparticle_result.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/custom_textfield.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/loading_widget.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_width.dart';
import 'package:healthy_buddy_mobile_app/shared/assets_directory.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/authentication/auth_notifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _categoryIcon = [
    'foodies.png',
    'sport.png',
    'mydoc.png',
    'top-up.png'
  ];

  final List<String> _categoryLabel = ['Foodies', 'Sport', 'MyDoc', 'Top Up'];

  @override
  void initState() {
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

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Konfirmasi?'),
            content: const Text(
                'Apakah kamu yakin untuk keluar dari aplikasi Healthy Buddy Mobile App?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Ya'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Tidak'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserClass>(context);
    final AuthenticationNotifier authenticationNotifier =
        Provider.of<AuthenticationNotifier>(context, listen: false);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
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
                  child: _headerIdentity(user),
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
                MarginHeight(height: 3.h),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
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
      ),
    );
  }

  Widget _whiteSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MarginHeight(height: 2.5.h),
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
        MarginHeight(height: 2.5.h),
        _topArticle(context),
      ],
    );
  }

  Widget _headerIdentity(UserClass user) {
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
              user.users?.name ?? "Loading...",
              style: titleStyle.copyWith(color: Colors.white),
            )
          ],
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.profileScreen);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: SizedBox(
              height: 50,
              width: 50,
              child: user.users?.gender == "Laki-laki"
                  ? Image.asset(
                      '$imageDirectory/ava1.png',
                      fit: BoxFit.cover,
                    )
                  : user.users?.gender == "Perempuan"
                      ? Image.asset(
                          '$imageDirectory/ava2.png',
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          '$imageDirectory/ava-null.png',
                          fit: BoxFit.cover,
                        ),
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
                  itemCount: 5,
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
                                    filterQuality: FilterQuality.low),
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
      backgroundColor: bgColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: bgColor,
              ),
              child: Image.asset('assets/images/logos/full_logo.png')),
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
