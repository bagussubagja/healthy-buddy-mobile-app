import 'package:cache_manager/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/mydoc/mydoc_notifier.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../shared/assets_directory.dart';

class MyDocAppointmentHistoryScreen extends StatefulWidget {
  int? id;
   MyDocAppointmentHistoryScreen({super.key, this.id});

  @override
  State<MyDocAppointmentHistoryScreen> createState() =>
      _MyDocAppointmentHistoryScreenState();
}

class _MyDocAppointmentHistoryScreenState
    extends State<MyDocAppointmentHistoryScreen> {
  String? idUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ReadCache.getString(key: 'cache').then((value) {
      setState(() {
        idUser = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final item =
        Provider.of<MyDocScheduleAppointmentClass>(context, listen: false);
    item.getSchedule(context: context, idUser: idUser ?? "", idDoctor: widget.id ?? 1);
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
            _topSection(),
            MarginHeight(height: 2.h),
            _itemList(),
          ],
        ),
      )),
    );
  }

  Widget _topSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Healthy Buddy - Appointment',
          style: titleStyle.copyWith(color: greenColor, fontSize: 14.sp),
        ),
        Text(
          'Temui Dokter Terbaik untuk mu!',
          style: regularStyle.copyWith(color: greyTextColor),
        ),
      ],
    );
  }

  Widget _itemList() {
    final item = Provider.of<MyDocScheduleAppointmentClass>(context);
    return ListView.separated(
        shrinkWrap: true,
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            elevation: 0,
            child: ExpansionTile(
              title: Text(
                '${item.schedule?[index].myDoc?.name}',
                style: regularStyle,
              ),
              subtitle: Text(
                "Tanggal : ${item.schedule?[index].dateAppointment}",
                style: regularStyle.copyWith(color: greyTextColor),
              ),
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              childrenPadding: const EdgeInsets.all(10),
              leading: Container(
                margin: const EdgeInsets.only(left: 15),
                height: 10.h,
                width: 10.h,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: item.schedule?[index].myDoc?.thumbnail ??
                          imgPlaceHolder,
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
                    )),
              ),
              children: [
                Text(
                  'Rumah Sakit : ${item.schedule?[index].myDoc?.hospital}',
                  style: regularStyle,
                ),
                Text(
                  'Spesialis : ${item.schedule?[index].myDoc?.specialist}',
                  style: regularStyle,
                ),
                Text(
                  'Tipe Temu-Janji : ${item.schedule?[index].media}',
                  style: regularStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        await item.deleteAppointmentData(
                            id: item.schedule![index].id!, context: context);
                      },
                      child: Text(
                        'Hapus',
                        style: regularStyle,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: greenColor),
                        child: Text(item.schedule?[index].media == "Video Call"
                            ? "Video Call"
                            : "Temui di Lokasi"))
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return MarginHeight(height: 3.h);
        },
        itemCount: item.schedule?.length ?? 0);
  }
}
