import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/custom_textfield.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/loading_widget.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:indonesia/indonesia.dart';
import 'package:sizer/sizer.dart';

class TopUpScreen extends StatefulWidget {
  TopUpScreen({super.key});

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  final _nominalController = TextEditingController();
  bool _isVisible = false;
  bool _isLoading = false;
  int _selectedNominal = 0;

  void nominal() {
    if (_nominalController.text.isEmpty) {
      setState(() {
        _isVisible = false;
      });
    } else {
      setState(() {
        _isVisible = true;
      });
    }
  }

  List<int> _sugestedNominal = [
    50000,
    100000,
    150000,
    300000,
    500000,
    1000000,
  ];

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
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
            child: Padding(
          padding: defaultPadding,
          child: ListView(
            children: [
              _headerSection(),
              MarginHeight(height: 2.h),
              _nominalTextField(),
              MarginHeight(height: 2.h),
              _suggestedNominal(),
              MarginHeight(height: 10.h),
              Visibility(
                visible: _isVisible,
                child: _appointmentButton(),
              )
            ],
          ),
        )),
      ),
    );
  }

  Widget _headerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top Up',
          style: titleStyle.copyWith(color: greenColor),
        ),
        Text(
          'Healthy Buddy - Kapanpun dan dimanapun',
          style: regularStyle.copyWith(color: greyTextColor),
        )
      ],
    );
  }

  Widget _nominalTextField() {
    return CustomTextField(
      titleText: "Masukan total top up saldo kamu :",
      hintText: "ex. 100000",
      controller: _nominalController,
      suffixIcon: IconButton(
          onPressed: () {
            _nominalController.clear();
            nominal();
          },
          icon: Icon(
            Icons.clear,
            color: greyTextColor,
          )),
      onChanged: (p0) {
        if (p0.isNotEmpty) {
          nominal();
        } else if (p0.isEmpty) {
          nominal();
        }
      },
      textInputType: TextInputType.number,
    );
  }

  Widget _suggestedNominal() {
    return Wrap(
      alignment: WrapAlignment.spaceAround,
      runSpacing: 10,
      children: List.generate(6, (index) {
        return GestureDetector(
          onTap: () {
            _nominalController.text = _sugestedNominal[index].toString();
            nominal();
          },
          child: Container(
            alignment: Alignment.center,
            height: 14.h,
            width: 14.h,
            decoration: BoxDecoration(
              color: greenColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(rupiah(_sugestedNominal[index])),
          ),
        );
      }),
    );
  }

  Widget _appointmentButton() {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 8.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: greenColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            rupiah(_nominalController.text),
            style: regularStyle.copyWith(color: whiteColor),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isLoading = !_isLoading;
              });
            },
            child: _isLoading
                ? LoadingWidget(
                  color: Colors.white,
                )
                : Container(
                    height: 5.h,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: greenDarkerColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Confirm',
                      style: regularStyle.copyWith(color: whiteColor),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
