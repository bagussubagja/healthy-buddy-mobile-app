import 'package:cache_manager/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/purchase_history/purchase_history_notifier.dart';
import 'package:healthy_buddy_mobile_app/screens/widgets/margin_height.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:indonesia/indonesia.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../shared/assets_directory.dart';

class PurchaseHistoryScreen extends StatefulWidget {
  const PurchaseHistoryScreen({super.key});

  @override
  State<PurchaseHistoryScreen> createState() => _PurchaseHistoryScreenState();
}

class _PurchaseHistoryScreenState extends State<PurchaseHistoryScreen> {
  String? idUser;
  @override
  void initState() {
    super.initState();
    final item = Provider.of<PurchaseHistoryClass>(context, listen: false);
    ReadCache.getString(key: 'cache').then((value) {
      setState(() {
        idUser = value;
        item.getPurchaseHistory(context: context, idUser: value);
      });
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
      body: SafeArea(
          child: Padding(
        padding: defaultPadding,
        child: ListView(
          children: [
            _topSection(),
            MarginHeight(height: 3.h),
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
          'Healthy Buddy',
          style: titleStyle.copyWith(color: greenColor),
        ),
        Text(
          'Kesehatan Kamu yang Paling Penting',
          style: regularStyle.copyWith(color: greyTextColor),
        ),
      ],
    );
  }

  Widget _itemList() {
    final item = Provider.of<PurchaseHistoryClass>(context);
    return ListView.separated(
        shrinkWrap: true,
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final itemPurchaseHistory = item.purchaseHistory?[index];
          return Card(
            child: ExpansionTile(
              title: Text(
                '${itemPurchaseHistory?.productName}',
                style: regularStyle,
              ),
              subtitle: Text(
                rupiah(itemPurchaseHistory?.price),
                style: regularStyle.copyWith(color: greyTextColor),
              ),
              leading: Container(
                margin: const EdgeInsets.only(left: 15),
                height: 10.h,
                width: 10.h,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl:
                          itemPurchaseHistory?.thumbnail ?? imgPlaceHolder,
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
                  'Tanggal Pembelian : ${itemPurchaseHistory?.createdAt?.substring(0, 10)}',
                  style: regularStyle,
                ),
                Text(
                  'Kuantitas Item : ${itemPurchaseHistory?.quantity}pcs',
                  style: regularStyle,
                ),
                Text(
                  'Kategori : ${itemPurchaseHistory?.category}',
                  style: regularStyle,
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return MarginHeight(height: 3.h);
        },
        itemCount: item.purchaseHistory?.length ?? 0);
  }
}
