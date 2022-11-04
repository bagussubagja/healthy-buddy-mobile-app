import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/custom_textfield.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_width.dart';
import 'package:healthy_buddy_mobile_app/shared/assets_directory.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

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
  ];

  final List<String> _categoryLabel = ['Foodies', 'Sport', 'MyDoc'];

  @override
  Widget build(BuildContext context) {
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
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
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
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  hintText: "try find fruits...",
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
                        } else {
                          Navigator.pushNamed(context, AppRoutes.myDocScreen);
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
              'Bagus Subagja',
              style: titleStyle.copyWith(color: Colors.white),
            )
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            height: 50,
            width: 50,
            child: Image.asset(
              '$imageDirectory/avatar-demo.jpg',
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }

  Widget _topArticle(BuildContext context) {
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
                onPressed: () {},
                child: Text(
                  'Lihat Semua',
                  style: regularStyle.copyWith(color: Colors.grey),
                ))
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) {
              return ListTile(
                tileColor: greyColor,
                leading: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: greenColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5)),
                ),
                title: const Text('Ini Title'),
                subtitle: const Text('Lorem Ipsum Dolor Sit Amet'),
              );
            },
          ),
        ),
      ],
    );
  }
}
