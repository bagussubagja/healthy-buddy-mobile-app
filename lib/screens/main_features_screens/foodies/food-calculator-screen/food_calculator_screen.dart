import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/custom_textfield.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/margin_width.dart';

class FoodCalculatorScreen extends StatelessWidget {
  FoodCalculatorScreen({super.key});

  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _ageController = TextEditingController();

  String? _selectedActivityValue = 'Normal';

  List<String> _activityLabel = [
    "Sangat Rendah",
    "Cukup Rendah",
    "Normal",
    "Cukup Padat",
    "Sangat Padat"
  ];
  double _bmiResultValue = 0;
  String _bmiResultCategory = "Hasil BMI";

  double _bmiFunction(double height, double weight) {
    return (weight / ((height / 100) * (height / 100)));
  }

  String _bmiCategory(double x) {
    if (x < 17) {
      return "Sangat Kurus";
    } else if (x >= 17 && x <= 18.5) {
      return "Kurus";
    } else if (x >= 18.5 && x <= 25) {
      return "Normal";
    } else if (x >= 25.1 && x <= 27) {
      return "Gemuk";
    } else {
      return "Sangat Gemuk";
    }
  }

  List<String> _genderItem = ['Laki-laki', 'Perempuan'];
  String? _selectedGender = 'Laki-laki';

  double _calorieValue = 0;

  double _calorieCalculator(
      String gender, int age, int height, int weight, double activityValue) {
    if (gender == "Laki-laki") {
      return ((66.5 + (13.75 * weight) + (5.003 * height) - (6.75 * age)) *
          activityValue);
    } else if (gender == "Perempuan") {
      return ((655.1 + (9.563 * weight) + (1.850 * height) - (4.676 * age)) *
          activityValue);
    } else {
      return 0;
    }
  }

  double _activityValue(String activity) {
    if (activity == "Sangat Rendah") {
      return 1.2;
    } else if (activity == "Cukup Rendah") {
      return 1.35;
    } else if (activity == "Normal") {
      return 1.5;
    } else if (activity == "Cukup Padat") {
      return 1.7;
    } else if (activity == "Sangat Padat") {
      return 1.9;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: blackColor,
            )),
      ),
      body: SafeArea(
          child: Padding(
        padding: defaultPadding,
        child: ListView(
          children: [
            Text(
              'Foodies Calculator',
              style: titleStyle.copyWith(color: greenColor),
            ),
            Text(
              'Pastikan tubuhmu selalu dalam keadaan sehat',
              style: regularStyle.copyWith(color: greyTextColor),
            ),
            MarginHeight(height: 1.h),
            _itemList()
          ],
        ),
      )),
    );
  }

  Widget _itemList() {
    final List<String> _itemFeatureLabel = [
      "Kalkulator BMI",
      "Kalkulator Kalori Harian"
    ];
    final List<String> _itemDescription = [
      "Hitung index masa tubuh kamu!",
      "Ketahui berapa jumlah kalori yang kamu perlukan dalam satu hari!"
    ];

    return ListView.separated(
      separatorBuilder: (context, index) {
        return MarginHeight(height: 2.h);
      },
      shrinkWrap: true,
      itemCount: _itemFeatureLabel.length,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                if (index == 0) {
                  bmiCalculator(context);
                } else if (index == 1) {
                  calorieCalculator(context);
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
                      Text(
                        _itemFeatureLabel[index],
                        style: regularStyle,
                      ),
                      SizedBox(
                        width: 50.w,
                        child: Text(
                          _itemDescription[index],
                          style: regularStyle.copyWith(
                              color: greyTextColor, fontSize: 9.sp),
                        ),
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

  void bmiCalculator(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      borderSide: BorderSide(
        color: greenColor,
        width: 2,
      ),
      width: double.infinity,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: false,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      body: StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kalkulator BMI',
                  style: titleStyle,
                ),
                CustomTextField(
                  prefixIcon: Icon(
                    Icons.height_outlined,
                    color: greyTextColor,
                  ),
                  controller: _heightController,
                  hintText: "Masukkan tinggi badan (dalam satuan cm)",
                  textInputType: TextInputType.number,
                ),
                MarginHeight(height: 1.h),
                CustomTextField(
                  prefixIcon: Icon(
                    Icons.line_weight_outlined,
                    color: greyTextColor,
                  ),
                  controller: _weightController,
                  hintText: "Masukkan berat badan (dalam satuan kg)",
                  textInputType: TextInputType.number,
                ),
                MarginHeight(height: 2.h),
                Text(
                  'Nilai BMI : $_bmiResultValue',
                  style: regularStyle,
                ),
                Text(
                  'Kategori BMI : $_bmiResultCategory',
                  style: regularStyle,
                ),
                MarginHeight(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            _bmiResultCategory = "Hasil BMI";
                            _bmiResultValue = 0;
                          });
                          _weightController.clear();
                          _heightController.clear();
                        },
                        child: Text(
                          'Batal',
                          style: regularStyle,
                        )),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _bmiResultValue = _bmiFunction(
                                double.parse(_heightController.text),
                                double.parse(_weightController.text));

                            _bmiResultCategory = _bmiCategory(_bmiResultValue);
                          });
                        },
                        child: Text(
                          'Hitung',
                          style: regularStyle,
                        ))
                  ],
                )
              ],
            ),
          );
        },
      ),
    ).show();
  }

  void calorieCalculator(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      borderSide: BorderSide(
        color: greenColor,
        width: 2,
      ),
      width: double.infinity,
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: false,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      body: StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kalkulator Kalori Harian',
                  style: titleStyle,
                ),
                CustomTextField(
                  prefixIcon: Icon(
                    Icons.height_outlined,
                    color: greyTextColor,
                  ),
                  controller: _heightController,
                  hintText: "Masukkan tinggi badan (dalam satuan cm)",
                  textInputType: TextInputType.number,
                ),
                MarginHeight(height: 1.h),
                CustomTextField(
                  prefixIcon: Icon(
                    Icons.line_weight_outlined,
                    color: greyTextColor,
                  ),
                  controller: _weightController,
                  hintText: "Masukkan berat badan (dalam satuan kg)",
                  textInputType: TextInputType.number,
                ),
                MarginHeight(height: 1.h),
                CustomTextField(
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: greyTextColor,
                  ),
                  controller: _ageController,
                  hintText: "Masukkan Umur Anda",
                  textInputType: TextInputType.number,
                ),
                Text(
                  'Jenis Kelamin',
                  style: regularStyle,
                ),
                DropdownButton<String>(
                  dropdownColor: Colors.white,
                  alignment: AlignmentDirectional.center,
                  elevation: 0,
                  isExpanded: true,
                  items: _genderItem
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: regularStyle,
                          )))
                      .toList(),
                  value: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
                Text(
                  'Bobot Aktivitas Harian',
                  style: regularStyle,
                ),
                DropdownButton<String>(
                  dropdownColor: Colors.white,
                  alignment: AlignmentDirectional.center,
                  elevation: 0,
                  isExpanded: true,
                  items: _activityLabel
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: regularStyle,
                          )))
                      .toList(),
                  value: _selectedActivityValue,
                  onChanged: (value) {
                    setState(() {
                      _selectedActivityValue = value;
                    });
                  },
                ),
                MarginHeight(height: 2.h),
                Text(
                  'Jumlah Kalori yang dibutuhkan : \n$_calorieValue kkal',
                  style: regularStyle,
                ),
                MarginHeight(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);

                          _ageController.clear();
                          _weightController.clear();
                          _heightController.clear();
                          _calorieValue = 0;
                        },
                        child: Text(
                          'Batal',
                          style: regularStyle,
                        )),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _calorieValue = _calorieCalculator(
                                _selectedGender!,
                                int.parse(_ageController.text),
                                int.parse(_heightController.text),
                                int.parse(_weightController.text),
                                _activityValue(_selectedActivityValue!));
                          });
                        },
                        child: Text(
                          'Hitung',
                          style: regularStyle,
                        ))
                  ],
                )
              ],
            ),
          );
        },
      ),
    ).show();
  }
}
