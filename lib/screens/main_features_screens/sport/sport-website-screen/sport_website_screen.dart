// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/sport/sport_website_notifier.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/margin_width.dart';

class SportWebsiteScreen extends StatefulWidget {
  const SportWebsiteScreen({super.key});

  @override
  State<SportWebsiteScreen> createState() => _SportWebsiteScreenState();
}

class _SportWebsiteScreenState extends State<SportWebsiteScreen> {

  final List<String> _exerciseLevel = [
    "Sepakbola",
    "Balapan",
    "Badminton",
    "Basket",
    "Lainnya"
  ];

  List<bool> _selectedToogle = [true, false, false, false, false];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    final itemFootball =
        Provider.of<SportWebsiteFootballClass>(context, listen: false);
    itemFootball.getSportWebsite(context: context, category: "Football");
    final itemRacing =
        Provider.of<SportWebsiteRacingClass>(context, listen: false);
    itemRacing.getSportWebsite(context: context, category: "Racing");
    final itemBadminton =
        Provider.of<SportWebsiteBadmintonClass>(context, listen: false);
    itemBadminton.getSportWebsite(context: context, category: "Badminton");
    final itemBasket =
        Provider.of<SportWebsiteBasketClass>(context, listen: false);
    itemBasket.getSportWebsite(context: context, category: "Basket");
    final itemOthers =
        Provider.of<SportWebsiteOtherClass>(context, listen: false);
    itemOthers.getSportWebsite(context: context, category: "Others");
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
            Text(
              'Sport Website',
              style: titleStyle.copyWith(color: greenColor),
            ),
            Text(
              'Healthy Buddy - Update Berita Seputar Olahraga!',
              style: regularStyle.copyWith(color: greyTextColor),
            ),
            MarginHeight(height: 3.h),
            _sportLevelToogleButton(_currentIndex),
            MarginHeight(height: 3.h),
            _itemList(),
          ],
        ),
      )),
    );
  }

  Widget _sportLevelToogleButton(int currentIndex) {
    return Center(
      child: SizedBox(
        height: 5.h,
        child: ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    for (int i = 0; i < _selectedToogle.length; i++) {
                      if (i == index) {
                        _selectedToogle[i] = true;
                      } else {
                        _selectedToogle[i] = false;
                      }
                    }
                  });
                  _currentIndex = index;
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(2),
                  width: 22.w,
                  decoration: BoxDecoration(
                      color: _selectedToogle[index]
                          ? greenColor.withOpacity(0.2)
                          : greyColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: _selectedToogle[index]
                              ? greenDarkerColor
                              : greyTextColor)),
                  child: Text(
                    _exerciseLevel[index],
                    style: regularStyle.copyWith(
                        color: _selectedToogle[index]
                            ? greenDarkerColor
                            : greyTextColor,
                        fontSize: 14),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return MarginWidth(width: 5.w);
            },
            itemCount: _exerciseLevel.length),
      ),
    );
  }

  Widget _itemList() {
    final football = Provider.of<SportWebsiteFootballClass>(context);
    final racing = Provider.of<SportWebsiteRacingClass>(context);
    final badminton = Provider.of<SportWebsiteBadmintonClass>(context);
    final basket = Provider.of<SportWebsiteBasketClass>(context);
    final others = Provider.of<SportWebsiteOtherClass>(context);

    int itemCount(int x) {
      if (x == 0) {
        return football.sportWebsite?.length ?? 0;
      } else if (x == 1) {
        return racing.sportWebsite?.length ?? 0;
      } else if (x == 2) {
        return badminton.sportWebsite?.length ?? 0;
      } else if (x == 3) {
        return basket.sportWebsite?.length ?? 0;
      } else if (x == 4) {
        return others.sportWebsite?.length ?? 0;
      } else {
        return 0;
      }
    }

    return ListView.separated(
      separatorBuilder: (context, index) {
        return MarginHeight(height: 2.h);
      },
      shrinkWrap: true,
      itemCount: itemCount(_currentIndex),
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                if (_currentIndex == 0) {
                  final url = Uri.parse(football.sportWebsite![index].link);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                } else if (_currentIndex == 1) {
                  final url = Uri.parse(racing.sportWebsite![index].link);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                } else if (_currentIndex == 2) {
                  final url = Uri.parse(badminton.sportWebsite![index].link);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                } else if (_currentIndex == 3) {
                  final url = Uri.parse(basket.sportWebsite![index].link);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                } else if (_currentIndex == 4) {
                  final url = Uri.parse(others.sportWebsite![index].link);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                }
              },
              child: Row(
                children: [
                  Container(
                    height: 7.h,
                    width: 7.h,
                    decoration: BoxDecoration(
                      color: greenColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: greenColor),
                    ),
                    child: Icon(
                      Icons.web_outlined,
                      color: greenColor,
                    ),
                  ),
                  MarginWidth(width: 5.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _currentIndex == 0
                          ? Text(
                              '${football.sportWebsite?[index].title}',
                              style: regularStyle,
                            )
                          : _currentIndex == 1
                              ? Text(
                                  '${racing.sportWebsite?[index].title}',
                                  style: regularStyle,
                                )
                              : _currentIndex == 2
                                  ? Text(
                                      '${badminton.sportWebsite?[index].title}',
                                      style: regularStyle,
                                    )
                                  : _currentIndex == 3
                                      ? Text(
                                          '${basket.sportWebsite?[index].title}',
                                          style: regularStyle,
                                        )
                                      : Text(
                                          '${others.sportWebsite?[index].title}',
                                          style: regularStyle,
                                        ),
                      _currentIndex == 0
                          ? Text(
                              '${football.sportWebsite?[index].link}',
                              style: regularStyle.copyWith(
                                  color: greyTextColor, fontSize: 9.sp),
                            )
                          : _currentIndex == 1
                              ? Text(
                                  '${racing.sportWebsite?[index].link}',
                                  style: regularStyle.copyWith(
                                      color: greyTextColor, fontSize: 9.sp),
                                )
                              : _currentIndex == 2
                                  ? Text(
                                      '${badminton.sportWebsite?[index].link}',
                                      style: regularStyle.copyWith(
                                          color: greyTextColor, fontSize: 9.sp),
                                    )
                                  : _currentIndex == 3
                                      ? Text(
                                          '${basket.sportWebsite?[index].link}',
                                          style: regularStyle.copyWith(
                                              color: greyTextColor,
                                              fontSize: 9.sp),
                                        )
                                      : Text(
                                          '${others.sportWebsite?[index].link}',
                                          style: regularStyle.copyWith(
                                              color: greyTextColor,
                                              fontSize: 9.sp),
                                        ),
                    ],
                  )
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: greyTextColor,
            )
          ],
        );
      },
    );
  }
}
