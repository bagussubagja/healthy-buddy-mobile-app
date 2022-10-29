import 'package:appinio_animated_toggle_tab/appinio_animated_toggle_tab.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_width.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:sizer/sizer.dart';
import 'package:toggle_switch/toggle_switch.dart';

class FoodReceiptMenuScreen extends StatefulWidget {
  FoodReceiptMenuScreen({super.key});

  @override
  State<FoodReceiptMenuScreen> createState() => _FoodReceiptMenuScreenState();
}

class _FoodReceiptMenuScreenState extends State<FoodReceiptMenuScreen> {
  int _currentIndex = 0;
  bool _isSelected = false;

  final List<String> _foodCategory = ["Breakfast", "Lunch", "Dinner", "Drink"];
  List<bool> _selectedToogle = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_horiz_rounded,
                color: blackColor,
              ))
        ],
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios,
              color: blackColor,
            )),
      ),
      body: SafeArea(
          child: Padding(
        padding: defaultPadding,
        child: ListView(
          children: [
            Text(
              'Food Receipt',
              style: titleStyle.copyWith(color: greenColor),
            ),
            MarginHeight(height: 0.75.h),
            Text(
              'Apa yang akan kamu masak hari in?',
              style: regularStyle.copyWith(color: greyTextColor),
            ),
            MarginHeight(height: 15),
            Text(
              'Rekomendasi',
              style: titleStyle.copyWith(color: greyTextColor),
            ),
            MarginHeight(height: 1.h),
            SizedBox(
              height: 40.h,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 200,
                      height: 100,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Ini Judul',
                            style: titleStyle,
                          ),
                          MarginHeight(height: 5.h),
                          Text(
                            'Lorem Ipsum Dolor Sit Amet',
                            style: regularStyle,
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return MarginWidth(
                      width: 3.w,
                    );
                  },
                  itemCount: 10),
            ),
            MarginHeight(height: 3.h),
            Center(
              child: SizedBox(
                height: 30,
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
                          print(index);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(2),
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                              color: _selectedToogle[index]
                                  ? greenColor.withOpacity(0.5)
                                  : greyColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: greenDarkerColor)),
                          child: Text(
                            _foodCategory[index],
                            style: regularStyle.copyWith(
                                color: _selectedToogle[index]
                                    ? whiteColor
                                    : greenDarkerColor,
                                fontSize: 14),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return MarginWidth(width: 10);
                    },
                    itemCount: 4),
              ),
            )
          ],
        ),
      )),
    );
  }
}
