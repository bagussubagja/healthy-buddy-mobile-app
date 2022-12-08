// ignore_for_file: must_be_immutable, prefer_final_fields, use_build_context_synchronously

import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/mydoc/mydoc_notifier.dart';
import 'package:healthy_buddy_mobile_app/models/mydoc_model/mydoc_appointment_model.dart';
import 'package:healthy_buddy_mobile_app/models/user_model/user_model.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/custom_textfield.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:indonesia/indonesia.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/authentication/user_notifier.dart';
import '../../../../routes/routes.dart';
import '../../../widgets/margin_width.dart';

class AppointmentConfirmationScreen extends StatefulWidget {
  String? name;
  String? doctorName;
  String? dateAppointment;
  String? hospital;
  String? specialist;
  String? thumbnail;
  int? price;
  int? idDoctor;
  AppointmentConfirmationScreen(
      {super.key,
      this.name,
      this.doctorName,
      this.dateAppointment,
      this.hospital,
      this.specialist,
      this.thumbnail,
      this.price,
      this.idDoctor});

  @override
  State<AppointmentConfirmationScreen> createState() =>
      _AppointmentConfirmationScreenState();
}

class _AppointmentConfirmationScreenState
    extends State<AppointmentConfirmationScreen> {
  String chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random random = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  final List<String> _mediaLabel = ["Ditempat", "Video Call"];
  int? _expectedBalance;
  int? _userBalance;
  final List<IconData> _mediaIcon = [Icons.place_rounded, Icons.video_call];
  List<bool> _selectedToogle = [true, false, false];
  int _currentIndex = 0;
  String? _formattedDateAppointment;
  String? idUser;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserClass>(context, listen: false);
    ReadCache.getString(key: 'cache').then((value) {
      setState(() {
        user.getUser(context: context, idUser: value);
        idUser = value;
      });
    });
  }

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
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
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
              _headerSection(),
              MarginHeight(height: 3.h),
              _mainSection(),
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
          'MyDoc - Appointment',
          style: titleStyle.copyWith(color: greenColor),
        ),
        Text(
          'Konfirmasi Janji-temu bersama doktermu',
          style: regularStyle.copyWith(color: greyTextColor),
        )
      ],
    );
  }

  Widget _mainSection() {
    final user = Provider.of<UserClass>(context);
    if (user.users?[0].balance != null) {
      setState(() {
        _userBalance = user.users?[0].balance;
        _expectedBalance = _userBalance! - widget.price!;
      });
    }
    final localizations = MaterialLocalizations.of(context);
    setState(() {
      _formattedDateAppointment =
          localizations.formatFullDate(DateTime.parse(widget.dateAppointment!));
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          readOnly: true,
          prefixIcon: Icon(
            Icons.person,
            color: greyTextColor,
          ),
          hintText: widget.name,
          titleText: "Nama Pasien",
        ),
        MarginHeight(height: 2.h),
        CustomTextField(
          prefixIcon: Icon(
            Icons.health_and_safety,
            color: greyTextColor,
          ),
          readOnly: true,
          hintText: widget.doctorName,
          titleText: "Nama Dokter",
        ),
        MarginHeight(height: 2.h),
        CustomTextField(
          readOnly: true,
          prefixIcon: Icon(
            Icons.local_hospital_rounded,
            color: greyTextColor,
          ),
          hintText: widget.hospital,
          titleText: "Rumah Sakit",
        ),
        MarginHeight(height: 2.h),
        CustomTextField(
          readOnly: true,
          prefixIcon: Icon(
            Icons.gpp_good,
            color: greyTextColor,
          ),
          hintText: widget.specialist,
          titleText: "Spesialis",
        ),
        MarginHeight(height: 2.h),
        CustomTextField(
          readOnly: true,
          prefixIcon: Icon(
            Icons.attach_money_sharp,
            color: greyTextColor,
          ),
          hintText: rupiah(widget.price),
          titleText: "Biaya",
        ),
        MarginHeight(height: 2.h),
        CustomTextField(
          readOnly: true,
          prefixIcon: Icon(
            Icons.calendar_month_rounded,
            color: greyTextColor,
          ),
          hintText: _formattedDateAppointment,
          titleText: "Waktu Janji Temu",
        ),
        MarginHeight(height: 2.h),
        Text(
          'Pilih Media Janji Temu :',
          style: titleStyle.copyWith(fontSize: 11.sp),
        ),
        MarginHeight(height: 2.h),
        _mediaToogleButton(_currentIndex),
        MarginHeight(height: 3.h),
        Center(
          child: ElevatedButton(
            onPressed: () async {
              if (_expectedBalance! < 0) {
                _showFailedTransaction();
              } else {
                AppointmentScheduleModel scheduleModel =
                    AppointmentScheduleModel(
                        dateAppointment: _formattedDateAppointment,
                        idUser: idUser,
                        media: _currentIndex == 0 ? "Ditempat" : "Video Call",
                        idDoctor: widget.idDoctor,
                        idSchedule: getRandomString(6));
                final item = Provider.of<MyDocScheduleAppointmentClass>(context,
                    listen: false);
                final balance =
                    Provider.of<UserTopUpClass>(context, listen: false);
                UserModel body = UserModel(balance: _expectedBalance);
                await item.addData(scheduleModel, context);
                await balance.updateTopUp(body, idUser!, context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: greenColor),
            child: Text(
              'Konfirmasi',
              style: regularStyle,
            ),
          ),
        ),
        MarginHeight(height: 3.h)
      ],
    );
  }

  Widget _mediaToogleButton(int currentIndex) {
    return Center(
      child: SizedBox(
        height: 5.h,
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
                  width: 26.w,
                  decoration: BoxDecoration(
                      color: _selectedToogle[index]
                          ? greenColor.withOpacity(0.2)
                          : greyColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: _selectedToogle[index]
                              ? greenDarkerColor
                              : greyTextColor)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        _mediaIcon[index],
                        size: 3.h,
                        color:
                            _selectedToogle[index] ? greenColor : greyTextColor,
                      ),
                      Text(
                        _mediaLabel[index],
                        style: regularStyle.copyWith(
                            color: _selectedToogle[index]
                                ? greenDarkerColor
                                : greyTextColor,
                            fontSize: 10.sp),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return MarginWidth(width: 5.w);
            },
            itemCount: _mediaLabel.length),
      ),
    );
  }

  _showFailedTransaction() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      headerAnimationLoop: true,
      animType: AnimType.bottomSlide,
      title: 'Gagal',
      desc:
          'Pembayaran kamu gagal karena saldo tidak cukup, kamu harus top up saldo terlebih dahulu!',
      buttonsTextStyle: regularStyle,
      btnCancelText: "Kembali",
      btnOkText: "Top Up",
      showCloseIcon: false,
      btnOkOnPress: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, AppRoutes.topUpScreen);
      },
      btnCancelOnPress: () {},
    ).show();
  }
}
