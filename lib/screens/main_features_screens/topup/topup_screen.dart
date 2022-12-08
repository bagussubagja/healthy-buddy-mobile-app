import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/authentication/user_notifier.dart';
import 'package:healthy_buddy_mobile_app/models/user_model/user_model.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/custom_textfield.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/loading_widget.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:indonesia/indonesia.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({super.key});

  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  final _nominalController = TextEditingController();
  bool _isVisible = false;
  bool _isLoading = false;
  int? _topUpValue = 0;
  int? _newBalanceValue = 0;
  String iduser = "";

  Future<void> _stopLoading() async {
    Timer(
      const Duration(seconds: 3),
      () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      },
    );
  }

  void _nominal() {
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

  final List<int> _sugestedNominal = [
    50000,
    100000,
    150000,
    300000,
    500000,
    1000000,
  ];

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserClass>(context, listen: false);
    ReadCache.getString(key: 'cache').then((value) {
      user.getUser(context: context, idUser: value);
      iduser = value;
    });
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
                child: _confirmationButton(),
              ),
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
        ),
        MarginHeight(height: 2.h),
      ],
    );
  }

  Widget _nominalTextField() {
    final user = Provider.of<UserClass>(context);
    int? value = user.users?[0].balance;
    return CustomTextField(
      titleText: "Masukan total top up saldo kamu :",
      hintText: "ex. 100000",
      controller: _nominalController,
      maxLength: 7,
      suffixIcon: IconButton(
          onPressed: () {
            _nominalController.clear();
            _nominal();
          },
          icon: Icon(
            Icons.clear,
            color: greyTextColor,
          )),
      onChanged: (p0) {
        _topUpValue = int.parse(_nominalController.text);
        _newBalanceValue = _topUpValue! + value!;
        if (p0.isNotEmpty) {
          _nominal();
        } else if (p0.isEmpty) {
          _nominal();
        }
        if (p0.length >= 7) {
          final snackBar = SnackBar(
            elevation: 0,
            width: double.infinity,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Peringatan!',
              message:
                  'Kamu hanya bisa mengisi saldo kamu maksimal ${rupiah(9999999)}',
              contentType: ContentType.warning,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
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
            _nominal();
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

  Widget _confirmationButton() {
    final user = Provider.of<UserClass>(context);
    int? value = user.users?[0].balance;
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
            'Top Up : ${rupiah(_nominalController.text)}',
            style: regularStyle.copyWith(color: whiteColor),
          ),
          GestureDetector(
            onTap: () async {
              setState(() {
                _isLoading = !_isLoading;
              });

              _topUpValue = int.parse(_nominalController.text);
              _newBalanceValue = _topUpValue! + value!;
              UserModel topUpBalance = UserModel(balance: _newBalanceValue);
              if (_topUpValue! < 50000) {
                _showFailedDialogue();
              } else {
                var provider =
                    Provider.of<UserTopUpClass>(context, listen: false);
                await provider.updateTopUp(topUpBalance, iduser, context);
                await _stopLoading();
                _showSuccessDialogue();
              }
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

  Future _showFailedDialogue() async {
    AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            headerAnimationLoop: true,
            animType: AnimType.bottomSlide,
            title: 'Gagal!',
            desc: 'Transaksi pengisian saldo kamu tidak berhasil!',
            buttonsTextStyle: regularStyle,
            showCloseIcon: false,
            btnCancelOnPress: () {},
            btnCancelText: 'Kembali')
        .show();
    await _stopLoading();
  }

  Future _showSuccessDialogue() async {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      headerAnimationLoop: true,
      animType: AnimType.bottomSlide,
      title: 'Sukses!',
      desc: 'Transaksi pengisian saldo kamu berhasil!',
      buttonsTextStyle: regularStyle,
      showCloseIcon: false,
      btnOkOnPress: () {},
    ).show();
  }
}
