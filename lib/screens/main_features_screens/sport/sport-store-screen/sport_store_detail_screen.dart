import 'dart:ui';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:count_stepper/count_stepper.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/foodies_model/food_store_model.dart';
import 'package:healthy_buddy_mobile_app/models/sport_model/sport_store_model.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/shared/assets_directory.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:indonesia/indonesia.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/margin_height.dart';
import '../../../widgets/margin_width.dart';

class SportStoreDetailScreen extends StatefulWidget {
  SportStoreModel? sportStoreModel;
  SportStoreDetailScreen({super.key, this.sportStoreModel});

  @override
  State<SportStoreDetailScreen> createState() => _SportStoreDetailScreenState();
}

class _SportStoreDetailScreenState extends State<SportStoreDetailScreen> {
  int _itemQuantity = 1;
  int _galleryIndex = 0;
  int _totalPrice = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _imageSection(context),
                Padding(
                  padding: defaultPadding.copyWith(bottom: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _itemTitle(),
                      MarginHeight(height: 3.h),
                      _productGallery(),
                      MarginHeight(height: 3.h),
                      _itemDesc(),
                      MarginHeight(height: 3.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            width: 100.w,
            top: 0,
            child: _topSection(),
          ),
          _buttonPayment()
        ],
      )),
    );
  }

  Widget _topSection() {
    return Container(
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
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40)),
            child: CachedNetworkImage(
              imageUrl: widget.sportStoreModel!.gallery[_galleryIndex],
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
        ),
      ],
    );
  }

  Widget _itemTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 55.w,
              child: Text(
                widget.sportStoreModel!.productName,
                style: titleStyle.copyWith(color: blackColor),
              ),
            ),
            Text(
              rupiah(widget.sportStoreModel!.price),
              style: titleStyle.copyWith(color: blackColor),
            )
          ],
        ),
        MarginHeight(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.sportStoreModel!.category,
              style: regularStyle.copyWith(color: greyTextColor),
            ),
            CountStepper(
              iconColor: greenColor,
              defaultValue: 1,
              max: 10,
              min: 1,
              iconDecrementColor: greenColor,
              splashRadius: 25,
              onPressed: (value) {
                setState(() {
                  _itemQuantity = value;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _itemDesc() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tentang Produk',
          style: titleStyle.copyWith(color: blackColor),
        ),
        Text(
          widget.sportStoreModel!.description,
          style: regularStyle.copyWith(color: blackColor),
        )
      ],
    );
  }

  Widget _productGallery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Galeri Produk',
          style: titleStyle.copyWith(color: blackColor),
        ),
        SizedBox(
          height: 100,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _galleryIndex = index;
                    });
                  },
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: widget.sportStoreModel!.gallery[index],
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
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return MarginWidth(width: 3.w);
              },
              itemCount: 5),
        )
      ],
    );
  }

  Widget _buttonPayment() {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.only(left: 5, right: 5),
        height: 7.h,
        width: 100.w,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          color: whiteColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlinedButton(
              onPressed: () {
                final snackBar = SnackBar(
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Berhasil!',
                    message: 'Kamu berhasil menambahkan item  ke keranjang!',
                    contentType: ContentType.success,
                  ),
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: greenColor,
                  ),
                  Text(
                    'Keranjang',
                    style: regularStyle,
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _totalPrice = widget.sportStoreModel!.price * _itemQuantity;
                });
                showModal();
              },
              style: ElevatedButton.styleFrom(backgroundColor: greenColor),
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: whiteColor,
                  ),
                  Text(
                    'Beli Langsung',
                    style: regularStyle,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future showModal() async {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      context: context,
      builder: (context) {
        return Padding(
          padding: defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              MarginHeight(height: 2.h),
              Center(
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                      color: greyTextColor,
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
              MarginHeight(height: 2.h),
              Text(
                'Konfirmasi Orderan Kamu : ',
                style: titleStyle,
              ),
              MarginHeight(height: 1.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama Item\t: ${widget.sportStoreModel!.productName}',
                    style: regularStyle,
                  ),
                  Text(
                    'Kuantitas\t: $_itemQuantity',
                    style: regularStyle,
                  ),
                  Text(
                    'Diskon : 0%',
                    style: regularStyle,
                  ),
                  Text(
                    'Total Harga : ${rupiah(_totalPrice)}',
                    style: regularStyle,
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 70.w,
                          child: Text(
                            'Lokasi : Rancaekek, Kab Bandung.',
                            style: regularStyle,
                          )),
                      OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            'Ubah',
                            style: regularStyle,
                          ))
                    ],
                  )
                ],
              ),
              MarginHeight(height: 1.h),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Batal',
                          style: regularStyle,
                        )),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: greenColor),
                        child: Text(
                          'Konfirmasi',
                          style: regularStyle,
                        )),
                  ],
                ),
              ),
              MarginHeight(height: 2.h),
            ],
          ),
        );
      },
    );
  }
}
