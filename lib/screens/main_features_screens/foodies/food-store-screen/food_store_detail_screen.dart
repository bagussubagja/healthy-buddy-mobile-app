import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cache_manager/cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:count_stepper/count_stepper.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/authentication/user_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/purchase_history/purchase_history_notifier.dart';
import 'package:healthy_buddy_mobile_app/core/wishlist/foodies_wishlist_notifier.dart';
import 'package:healthy_buddy_mobile_app/models/foodies_model/food_store_model.dart';
import 'package:healthy_buddy_mobile_app/models/purchase_history_model/purchase_history_model.dart';
import 'package:healthy_buddy_mobile_app/models/user_model/user_model.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/screens/main_features_screens/foodies/food-store-screen/food_store_status_order_screen.dart';
import 'package:healthy_buddy_mobile_app/shared/assets_directory.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:indonesia/indonesia.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../../models/foodies_model/wishlist_foodies_model.dart';
import '../../../widgets/margin_height.dart';
import '../../../widgets/margin_width.dart';

class FoodStoreDetailScreen extends StatefulWidget {
  FoodStoreModel? foodStoreModel;
  FoodStore? foodStore;
  FoodStoreDetailScreen({super.key, this.foodStoreModel, this.foodStore});

  @override
  State<FoodStoreDetailScreen> createState() => _FoodStoreDetailScreenState();
}

class _FoodStoreDetailScreenState extends State<FoodStoreDetailScreen> {
  int _itemQuantity = 1;
  int _galleryIndex = 0;
  int _price = 0;
  double _totalPrice = 0;
  String? idUser;
  String? uniqueKey;
  int _expectedBalance = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final user = Provider.of<UserClass>(context, listen: false);
    ReadCache.getString(key: 'cache').then((value) {
      setState(() {
        idUser = value;
        user.getUser(context: context, idUser: value);
        uniqueKey =
            "${value}_${widget.foodStoreModel?.id ?? widget.foodStore?.id}";
      });
    });
  }

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
                      _productGallery(),
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
              imageUrl: widget.foodStoreModel?.gallery[_galleryIndex] ??
                  widget.foodStore?.gallery?[_galleryIndex],
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
              width: 65.w,
              child: Text(
                widget.foodStoreModel?.name ?? widget.foodStore!.name!,
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
                  widget.foodStoreModel?.price.toString() ??
                      widget.foodStore!.price.toString(),
                  style: titleStyle.copyWith(color: blackColor),
                )
              ],
            )
          ],
        ),
        MarginHeight(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.foodStoreModel?.category ?? widget.foodStore!.category!,
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
          widget.foodStoreModel?.description ?? widget.foodStore!.description!,
          style: regularStyle.copyWith(color: greyTextColor),
          textAlign: TextAlign.justify,
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
                            widget.foodStore!.gallery![index],
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
    final itemFoodies = Provider.of<FoodiesWishlistClass>(context);
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
              onPressed: () async {
                WishlistFoodiesModel body = WishlistFoodiesModel(
                    idFoodiesStoreItem:
                        widget.foodStoreModel?.id ?? widget.foodStore?.id,
                    idUser: idUser,
                    itemUniqueKey: uniqueKey);
                await itemFoodies.addData(body, context);
                // showCustomSnackBar();
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
                  if (widget.foodStoreModel?.price == null) {
                    _price = widget.foodStore!.price! * _itemQuantity;
                  } else {
                    _price = widget.foodStoreModel!.price * _itemQuantity;
                  }
                });
                showModalConfirmationOrder();
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

  Future showModalConfirmationOrder() async {
    final user = Provider.of<UserClass>(context, listen: false);
    final userBalance = user.users?[0].balance;
    setState(() {
      _totalPrice = (_price - (_price * 0.15));
      _expectedBalance = userBalance! - _totalPrice.round();
    });

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
                    'Nama Item\t: ${widget.foodStoreModel?.name ?? widget.foodStore?.name}',
                    style: regularStyle,
                  ),
                  Text(
                    'Kuantitas\t: $_itemQuantity',
                    style: regularStyle,
                  ),
                  Text(
                    user.users?[0].hasDiscount == true
                        ? 'Diskon : 15%'
                        : 'Diskon : 0%',
                    style: regularStyle,
                  ),
                  Text(
                    user.users?[0].hasDiscount == true
                        ? 'Total Harga : ${rupiah(_totalPrice.round())}'
                        : 'Total Harga : ${rupiah(_price)}',
                    style: regularStyle,
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 70.w,
                          child: Text(
                            '${user.users?[0].address}',
                            style: regularStyle,
                          )),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRoutes.accountSettingScreen);
                          },
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
                        onPressed: () async {
                          if (_expectedBalance < 0) {
                            _showFailedTransaction();
                          } else {
                            PurchaseHistoryModel transactionItem =
                                PurchaseHistoryModel(
                              idUser: idUser,
                              productName: widget.foodStore?.name ??
                                  widget.foodStoreModel?.name,
                              category: "Food Store",
                              createdAt: DateTime.now().toString(),
                              price: user.users?[0].hasDiscount == true
                                  ? _totalPrice.round()
                                  : _price,
                              quantity: _itemQuantity,
                              thumbnail: widget.foodStore?.gallery?[0] ??
                                  widget.foodStoreModel?.gallery[0],
                            );
                            UserModel balance =
                                UserModel(balance: _expectedBalance);
                            var purchaseTransaction =
                                Provider.of<PurchaseHistoryClass>(context,
                                    listen: false);
                            var updateBalance = Provider.of<UserTopUpClass>(
                                context,
                                listen: false);
                            await purchaseTransaction.addFoodiesTransactionData(
                                transactionItem, context);

                            await updateBalance.updateTopUp(
                                balance, idUser!, context);
                            Navigator.pushNamed(
                                context, AppRoutes.foodStoreStatusOrder);
                          }
                        },
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
