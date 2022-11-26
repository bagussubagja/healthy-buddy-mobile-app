import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cache_manager/core/read_cache_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/authentication/user_notifier.dart';
import 'package:healthy_buddy_mobile_app/models/mydoc_model/mydoc_model.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/mydoc/appoinment_screen/appointment_confirmation_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/assets_directory.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:indonesia/indonesia.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

import '../../../widgets/margin_width.dart';

class MyDocDetailScreen extends StatefulWidget {
  MyDocModel? myDocModel;
  MyDocDetailScreen({super.key, this.myDocModel});

  @override
  State<MyDocDetailScreen> createState() => _MyDocDetailScreenState();
}

class _MyDocDetailScreenState extends State<MyDocDetailScreen> {
  final List<String> _docLabel = ["Patients", "Year exp", "Rating"];
  DateTime? _date;
  String? _selectedDate;


  List<String> _numLabel = [];

  @override
  void initState() {
    super.initState();
    _numLabel.add(widget.myDocModel!.patients.toString());
    _numLabel.add(widget.myDocModel!.yearExp.toString());
    _numLabel.add(widget.myDocModel!.rating.toString());
    final user = Provider.of<UserClass>(context, listen: false);
    ReadCache.getString(key: 'cache').then((value) {
      setState(() {
        user.getUser(context: context, idUser: value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _imageSection(context),
                  MarginHeight(height: 9.h),
                  Padding(
                    padding: defaultPadding.copyWith(bottom: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MarginHeight(height: 2.h),
                        _appointmentSection(),
                        _docdescription(),
                        MarginHeight(height: 2.h),
                        _detailDocData(),
                        MarginHeight(height: 3.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(width: 100.w, top: 0, child: _topSection()),
            Positioned(
              bottom: 0,
              child: _appointmentButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topSection() {
    return Container(
      alignment: Alignment.centerLeft,
      height: 6.h,
      color: Colors.black12,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: blackColor,
        ),
      ),
    );
  }

  Widget _imageSection(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: CachedNetworkImage(
            imageUrl: widget.myDocModel!.thumbnail,
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
        Positioned(
          top: 320,
          left: 20,
          right: 20,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 20.h,
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: greyColor.withOpacity(0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.myDocModel?.name ?? "Loading...",
                      style: titleStyle.copyWith(fontSize: 13.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                    MarginHeight(height: 1.h),
                    Text(
                      '${widget.myDocModel?.specialist} - ${widget.myDocModel?.hospital}',
                      style: regularStyle,
                      textAlign: TextAlign.center,
                    ),
                    MarginHeight(height: 1.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: blackColor,
                        ),
                        MarginWidth(width: 2.w),
                        Text(
                          '${widget.myDocModel?.operationalHour} WIB',
                          style: regularStyle.copyWith(fontSize: 10.sp),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _appointmentSection() {
    final localizations = MaterialLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Appointment',
          style: titleStyle.copyWith(color: greenColor),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedDate == null
                  ? "Silahkan atur jadwal temu-janji"
                  : localizations.formatFullDate(_date!),
              style: regularStyle,
            ),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: greenColor,
                ),
                onPressed: () async {
                  _date = await showDatePicker(
                    context: context,
                    locale: const Locale('id'),
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2100),
                  );
                  if (_date == null) {
                    return;
                  } else {
                    setState(() {
                      _selectedDate = _date.toString();
                      print(_date);
                    });
                  }
                },
                child: Text(
                  'Ubah',
                  style: regularStyle,
                ))
          ],
        )
      ],
    );
  }

  Widget _docdescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tentang Dokter',
          style: titleStyle.copyWith(color: greenColor),
        ),
        Text(
          widget.myDocModel?.description ?? "Loading...",
          style: regularStyle,
          textAlign: TextAlign.justify,
        )
      ],
    );
  }

  Widget _detailDocData() {
    return SizedBox(
      height: 10.h,
      child: Center(
        child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                width: 25.w,
                decoration: BoxDecoration(
                  color: greenColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _numLabel[index],
                      style: titleStyle.copyWith(color: greenColor),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      _docLabel[index],
                      style: regularStyle,
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return MarginWidth(width: 10);
            },
            itemCount: 3),
      ),
    );
  }

  Widget _appointmentButton() {
    final user = Provider.of<UserClass>(context);
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 8.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: greenColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Biaya : ${rupiah(widget.myDocModel?.price)}',
            style: regularStyle.copyWith(color: whiteColor),
          ),
          GestureDetector(
            onTap: () {
              if (_selectedDate != null) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return AppointmentConfirmationScreen(
                      name: user.users?[0].name,
                      doctorName: widget.myDocModel?.name,
                      dateAppointment: _selectedDate,
                      hospital: widget.myDocModel?.hospital,
                      specialist: widget.myDocModel?.specialist,
                      thumbnail: widget.myDocModel?.thumbnail,
                      price: widget.myDocModel?.price,
                    );
                  },
                ));
              } else if (_selectedDate == null) {
                _showSnackBar();
              }
            },
            child: Container(
              height: 5.h,
              padding: const EdgeInsets.only(left: 15, right: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: greenDarkerColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Konfirmasi',
                style: regularStyle.copyWith(color: whiteColor),
              ),
            ),
          )
        ],
      ),
    );
  }

  _showSnackBar() {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Gagal!',
        message: 'Jadwal Temu-Janji Tidak Boleh Kosong',
        contentType: ContentType.failure,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  _showFailedAppointment() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      headerAnimationLoop: true,
      animType: AnimType.bottomSlide,
      title: 'Gagal',
      desc: 'Kamu tidak melakukan temu-janji dengan dokter karena...',
      buttonsTextStyle: regularStyle,
      btnOkText: "Kembali",
      showCloseIcon: false,
      btnOkOnPress: () {},
    ).show();
  }
}
