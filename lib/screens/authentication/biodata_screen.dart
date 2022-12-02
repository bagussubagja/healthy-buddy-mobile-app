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
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  double _calorieCalculator(
      String gender, int age, int height, int weight, double activityValue) {
    if (gender == "Laki-laki") {
      return ((66.5 + (13.75 * weight) + (5.003 * height) - (6.75 * age)) *
          activityValue);
    } else if (gender == "Perempuan") {
      return ((655.1 + (9.563 * weight) + (1.850 * height) - (4.676 * age)) *
          activityValue);
    } else {
      return 0;
    }
  }

  double _activityValue(String activity) {
    if (activity == "Sangat Rendah") {
      return 1.2;
    } else if (activity == "Cukup Rendah") {
      return 1.35;
    } else if (activity == "Normal") {
      return 1.5;
    } else if (activity == "Cukup Padat") {
      return 1.7;
    } else if (activity == "Sangat Padat") {
      return 1.9;
    } else {
      return 0;
    }
  }

  List<String> _activityLabel = [
    "Sangat Rendah",
    "Cukup Rendah",
    "Normal",
    "Cukup Padat",
    "Sangat Padat"
  ];
  List<double> _activityValues = [1.2, 1.35, 1.5, 1.7, 1.9];

  String? _selectedActivityValue = 'Normal';

  double? _dailyCaloriesValue = 0;

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
              _headerSection(),
              MarginHeight(height: 5.h),
              _textFieldSection(),
              MarginHeight(height: 3.h),
              _dropDownSection(),
              MarginHeight(height: 3.h),
              _confirmationButton()
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
          'Healthy Buddy - Biodata',
          style: titleStyle.copyWith(color: greenColor),
        ),
        Text(
          'Selamat Datang di Healthy Buddy!',
          style: regularStyle.copyWith(color: greyTextColor),
        ),
      ],
    );
  }

  Widget _textFieldSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          titleText: "Nama Lengkap",
          hintText: "tulis nama kamu disini...",
          color: Colors.white,
          controller: _nameController,
          textInputType: TextInputType.name,
        ),
        MarginHeight(height: 3.h),
        CustomTextField(
          titleText: "Alamat Rumah",
          hintText: "ex. Jl. Merdeka No.17 Bandung 40390",
          color: Colors.white,
          controller: _addressController,
          textInputType: TextInputType.emailAddress,
        ),
        MarginHeight(height: 3.h),
        CustomTextField(
          titleText: "Usia",
          hintText: "ex. 24",
          color: Colors.white,
          controller: _ageController,
          textInputType: TextInputType.number,
        ),
        MarginHeight(height: 3.h),
        CustomTextField(
          titleText: "Berat Badan",
          hintText: "ex. 50 (dalam satuan kg)58",
          color: Colors.white,
          controller: _weightController,
          textInputType: TextInputType.number,
        ),
        MarginHeight(height: 3.h),
        CustomTextField(
          titleText: "Tinggi Badan",
          hintText: "ex. 175 (dalam satuan cm)",
          color: Colors.white,
          controller: _heightController,
          textInputType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _dropDownSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jenis Kelamin',
          style: regularStyle,
        ),
        DropdownButton<String>(
          dropdownColor: Colors.white,
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
        Text(
          'Bobot Aktivitas Harian',
          style: regularStyle,
        ),
        DropdownButton<String>(
          dropdownColor: Colors.white,
          alignment: AlignmentDirectional.center,
          elevation: 0,
          isExpanded: true,
          items: _activityLabel
              .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: regularStyle,
                  )))
              .toList(),
          value: _selectedActivityValue,
          onChanged: (value) {
            setState(() {
              _selectedActivityValue = value;
            });
          },
        ),
      ],
    );
  }

  Widget _confirmationButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
                  gender: _selectedGender,
                  age: int.parse(_ageController.text),
                  dailyActivity: _selectedActivityValue,
                  height: int.parse(_heightController.text),
                  weight: int.parse(_weightController.text),
                  dailyCalories: _calorieCalculator(
                    _selectedGender!,
                    int.parse(_ageController.text),
                    int.parse(_heightController.text),
                    int.parse(_weightController.text),
                    _activityValue(_selectedActivityValue!),
                  ),
                );
                var provider =
                    Provider.of<RegisterDataClass>(context, listen: false);
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
    );
  }
}
