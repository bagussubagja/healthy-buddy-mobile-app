import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/foodies_model/food_store_model.dart';
import 'package:healthy_buddy_mobile_app/shared/assets_directory.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/margin_height.dart';
import '../../../widgets/margin_width.dart';

class FoodStoreDetailScreen extends StatefulWidget {
  FoodStoreModel? foodStoreModel;
  FoodStoreDetailScreen({super.key, this.foodStoreModel});

  @override
  State<FoodStoreDetailScreen> createState() => _FoodStoreDetailScreenState();
}

class _FoodStoreDetailScreenState extends State<FoodStoreDetailScreen> {
  int _galleryIndex = 0;
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
                      _itemDesc(),
                      MarginHeight(height: 3.h),
                      _productGallery()
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buttonPayment()
        ],
      )),
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
              imageUrl: widget.foodStoreModel?.gallery[_galleryIndex] ??
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
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: blackColor,
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
              width: 65.w,
              child: Text(
                widget.foodStoreModel?.name ?? "Loading",
                style: titleStyle.copyWith(color: blackColor),
              ),
            ),
            Row(
              children: [
                Text(
                  'Rp',
                  style: titleStyle.copyWith(color: greenColor),
                ),
                Text(
                  widget.foodStoreModel?.price.toString() ?? "Loading...",
                  style: titleStyle.copyWith(color: blackColor),
                )
              ],
            )
          ],
        ),
        Text(
          widget.foodStoreModel?.category ?? "Loading",
          style: regularStyle.copyWith(color: greyTextColor),
        )
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
          widget.foodStoreModel?.description ?? "Loading",
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
                        imageUrl: widget.foodStoreModel?.gallery[index] ??
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
              onPressed: () {},
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
              onPressed: () {},
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
            )
          ],
        ),
      ),
    );
  }
}
