import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/core/authentication/auth_notifier.dart';
import 'package:healthy_buddy_mobile_app/models/user_model/user_model.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:healthy_buddy_mobile_app/shared/theme.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../widgets/custom_textfield.dart';
import '../widgets/margin_height.dart';

class BiodataScreen extends StatefulWidget {
  String? email;
  BiodataScreen({super.key, this.email});

  @override
  State<BiodataScreen> createState() => _BiodataScreenState();
}

class _BiodataScreenState extends State<BiodataScreen> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  List<String> _genderItem = ['Laki-laki', 'Perempuan'];

  String? _idUser;

  String? _selectedGender = 'Laki-laki';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReadCache.getString(key: "cache").then((idUser) {
      setState(() {
        _idUser = idUser;
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
        ),
        body: SafeArea(
            child: Padding(
          padding: defaultPadding,
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                'Healthy Buddy',
                style: titleStyle.copyWith(color: greenColor),
              ),
              Text(
                'Selamat Datang di Healthy Buddy!',
                style: regularStyle.copyWith(color: greyTextColor),
              ),
              MarginHeight(height: 5.h),
              CustomTextField(
                titleText: "Nama Lengkap",
                hintText: "tulis nama kamu disini...",
                color: greyColor,
                controller: _nameController,
                textInputType: TextInputType.name,
              ),
              MarginHeight(height: 3.h),
              CustomTextField(
                titleText: "Alamat Rumah",
                hintText: "ex. Jl. Merdeka No.17 Bandung 40390",
                color: greyColor,
                controller: _addressController,
                textInputType: TextInputType.emailAddress,
              ),
              MarginHeight(height: 3.h),
              Text(
                'Jenis Kelamin',
                style: regularStyle,
              ),
              DropdownButton<String>(
                dropdownColor: greyColor,
                alignment: AlignmentDirectional.center,
                elevation: 0,
                isExpanded: true,
                items: _genderItem
                    .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                          style: regularStyle,
                        )))
                    .toList(),
                value: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              MarginHeight(height: 3.h),
              ElevatedButton(
                  onPressed: () async {
                    if (_nameController.text.isNotEmpty &&
                        widget.email!.isNotEmpty &&
                        _addressController.text.isNotEmpty &&
                        _genderItem.isNotEmpty &&
                        _idUser!.isNotEmpty &&
                        _selectedGender!.isNotEmpty) {
                      UserModel userModel = UserModel(
                          idUser: _idUser!,
                          email: widget.email,
                          name: _nameController.text,
                          address: _addressController.text,
                          gender: _selectedGender);
                      var provider = Provider.of<RegisterDataClass>(context,
                          listen: false);
                      await provider.postData(userModel);
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.statePageUI, (route) => false);
                    } else {
                      final snackBar = SnackBar(
                        elevation: 0,
                        width: double.infinity,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Field Tidak Boleh Kosong!',
                          message:
                              'Kamu harus memasukan data nama, alamat, dan jenis kelamin untuk melakukan register!',
                          contentType: ContentType.warning,
                        ),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: greenColor),
                  child: Text(
                    'Selesai',
                    style: regularStyle,
                  ))
            ],
          ),
        )),
      ),
    );
  }
}
