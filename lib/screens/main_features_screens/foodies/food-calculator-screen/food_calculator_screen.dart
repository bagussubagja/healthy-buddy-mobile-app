import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/margin_width.dart';

class FoodCalculatorScreen extends StatefulWidget {
  const FoodCalculatorScreen({super.key});

  @override
  State<FoodCalculatorScreen> createState() => _FoodCalculatorScreenState();
}

class _FoodCalculatorScreenState extends State<FoodCalculatorScreen> {
  final List<String> _exerciseLevel = [
    "Kalori Harian",
    "TBC",
  ];
  List<bool> _selectedToogle = [true, false];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: blackColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: defaultPadding,
          child: ListView(
            children: [_sportLevelToogleButton(_currentIndex)],
          ),
        ),
      ),
    );
  }

  Widget _sportLevelToogleButton(int currentIndex) {
    return Center(
      child: SizedBox(
        height: 10.h,
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
                  _currentIndex = index;
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(2),
                  height: 30,
                  width: 80,
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
              return MarginWidth(width: 10.w);
            },
            itemCount: _selectedToogle.length),
      ),
    );
  }
}
