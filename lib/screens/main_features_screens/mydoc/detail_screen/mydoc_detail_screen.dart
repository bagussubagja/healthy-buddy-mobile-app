// ignore_for_file: must_be_immutable

import 'dart:ui';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cache_manager/core/read_cache_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/authentication/user_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/favorites/favorites_notifier.dart';
import 'package:healthy_buddy_mobile_app/models/favorite_model/fav_mydoc_model.dart';
import 'package:healthy_buddy_mobile_app/models/mydoc_model/mydoc_model.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/mydoc/appoinment_screen/appointment_confirmation_screen.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:indonesia/indonesia.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/margin_width.dart';

class MyDocDetailScreen extends StatefulWidget {
  MyDocModel? myDocModel;
  MyDoc? myDoc;
  MyDocDetailScreen({super.key, this.myDocModel, this.myDoc});

  @override
  State<MyDocDetailScreen> createState() => _MyDocDetailScreenState();
}

class _MyDocDetailScreenState extends State<MyDocDetailScreen> {
  final List<String> _docLabel = ["Patients", "Year exp", "Rating"];
  DateTime? _date;
  String? _selectedDate;

  List<String> numLabel = [];

  String? idUser;

  @override
  void initState() {
    super.initState();
    if (widget.myDoc?.name != null) {
      numLabel.add(widget.myDoc!.patients.toString());
      numLabel.add(widget.myDoc!.yearExp.toString());
      numLabel.add(widget.myDoc!.rating.toString());
    } else if (widget.myDocModel?.name != null) {
      numLabel.add(widget.myDocModel!.patients.toString());
      numLabel.add(widget.myDocModel!.yearExp.toString());
      numLabel.add('${widget.myDocModel!.rating.toString()}/5');
    }
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
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _imageSection(context),
                  MarginHeight(height: 7.h),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: whiteColor,
            ),
          ),
          IconButton(
            onPressed: () async {
              final fav = Provider.of<FavoriteClass>(context, listen: false);
              FavMyDocModel body = FavMyDocModel(
                  idDoc: widget.myDocModel?.id ?? widget.myDoc?.id,
                  idUser: idUser,
                  uniqueKey:
                      '${idUser}_${widget.myDocModel?.id ?? widget.myDoc?.id}');
              await fav.addFavDocData(body, context);
            },
            icon: Icon(
              Icons.favorite,
              color: whiteColor,
            ),
          ),
        ],
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
            imageUrl:
                '${widget.myDocModel?.thumbnail ?? widget.myDoc?.thumbnail}',
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
          top: 37.h,
          left: 3.h,
          right: 3.h,
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
                      widget.myDocModel?.name ?? widget.myDoc!.name!,
                      style: titleStyle.copyWith(fontSize: 13.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                    MarginHeight(height: 1.h),
                    Text(
                      '${widget.myDocModel?.specialist ?? widget.myDoc?.specialist} - ${widget.myDocModel?.hospital ?? widget.myDoc?.hospital}',
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
                          '${widget.myDocModel?.operationalHour ?? widget.myDoc?.operationalHour} WIB',
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
        MarginHeight(height: 1.h),
        Text(
          'Tentang Dokter',
          style: titleStyle.copyWith(color: greenColor),
        ),
        MarginHeight(height: 1.h),
        Text(
          widget.myDocModel?.description ?? widget.myDoc!.description!,
          style: regularStyle.copyWith(color: greyTextColor),
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
                      numLabel[index],
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
            'Biaya : ${rupiah(widget.myDocModel?.price ?? widget.myDoc?.price)}',
            style: regularStyle.copyWith(color: whiteColor),
          ),
          GestureDetector(
            onTap: () {
              if (_selectedDate != null) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return AppointmentConfirmationScreen(
                      name: user.users?.name,
                      doctorName: widget.myDocModel?.name ?? widget.myDoc?.name,
                      dateAppointment: _selectedDate,
                      hospital:
                          widget.myDocModel?.hospital ?? widget.myDoc?.hospital,
                      specialist: widget.myDocModel?.specialist ??
                          widget.myDoc?.specialist,
                      thumbnail: widget.myDocModel?.thumbnail ??
                          widget.myDoc?.thumbnail,
                      price: widget.myDocModel?.price ?? widget.myDoc?.price,
                      idDoctor: widget.myDocModel?.id ?? widget.myDoc?.id,
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
}
